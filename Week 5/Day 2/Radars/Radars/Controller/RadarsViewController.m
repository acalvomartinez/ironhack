//
//  RadarsViewController.m
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "RadarsViewController.h"
#import "RadarsViewController+ACMNSFetchResultsController.h"

#import "EditRadarViewController.h"

#import "CoreDataStack.h"
#import "RadarViewCell.h"
#import "Radar.h"

#import "RadarAPIWrapper.h"
#import "JSONParser.h"
#import "RadarJSON.h"
#import "JSONRadarMapper.h"


@interface RadarsViewController ()

@end

@implementation RadarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(self.managedObjectContext != nil, @"ViewControllers needs a managedObjectContext!");
    
    self.title = @"Radars";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshButtonPressed:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RadarViewCell *cell = (RadarViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RadarCell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    Radar *radar = (Radar *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    return radar.user;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RadarDetailSegue"]) {
        Radar *radar = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
        
        EditRadarViewController *vc = segue.destinationViewController;
        vc.radar = radar;
    }
}


#pragma mark - Actions

- (IBAction)refreshButtonPressed:(UIBarButtonItem *)sender {
    
    __weak RadarsViewController *weakSelf = self;
    
    RadarAPIWrapper *apiWrapper = [[RadarAPIWrapper alloc] init];
    
    [apiWrapper radarsWithBaseURL:@"https://openradar.appspot.com/api/radars"
                       completion:^(NSString * _Nullable returnData) {
                           
                           NSAssert([NSThread currentThread] == [NSThread mainThread], @"OMG!");
                          
                           NSArray<RadarJSON *> *jsonRadars = [JSONParser parseJSONString:returnData];
                           
                           if (jsonRadars) {
                               [JSONRadarMapper mapJSONRadars:jsonRadars inContext:weakSelf.managedObjectContext];
                               
                               [weakSelf.tableView reloadData];
                               
                               [weakSelf.refreshControl endRefreshing];
                           }
                           
                       } onError:^(NSError * _Nullable error) {
                           NSLog(@"%@", error);
                           
                           [weakSelf.refreshControl endRefreshing];
                       }];
    
}


- (void)configureCell:(RadarViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Radar *radar = (Radar *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.radar =radar;
}

@end
