//
//  RadarsViewController.m
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "RadarsViewController.h"
#import "EditRadarViewController.h"

#import <CoreDataKit/CoreDataStack.h>
#import "RadarViewCell.h"
#import "RadarSectionCell.h"
#import "Radar.h"

#import "RadarAPIWrapper.h"
#import "JSONParser.h"
#import "RadarJSON.h"
#import "JSONRadarMapper.h"

#import "RadarsAdapter.h"
#import "UsersViewController.h"

#import "NSString+Random.h"


@interface RadarsViewController () <RadarsAdapterDelegate, UsersViewControllerDelegate>

@property (nonatomic, strong) RadarsAdapter *radarAdapter;

@end

@implementation RadarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(self.managedObjectContext != nil, @"ViewControllers needs a managedObjectContext!");
    
    self.title = @"Radars";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshButtonPressed:) forControlEvents:UIControlEventValueChanged];
    
    self.radarAdapter = [[RadarsAdapter alloc] initWithManagedObjectContext:self.managedObjectContext
                                                               andTableView:self.tableView];
    
    self.radarAdapter.delegate = self;
    
    [self startTimerInfo];
}

- (void)startTimerInfo {
    
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(insertRandom:) userInfo:nil repeats:YES];

}

- (void)insertRandom:(NSTimer *)timer {
    [Radar radarWithUser:[NSString randomEmailGenerator]
                andTitle:[NSString randomTitleGenerator:20]
                 product:[NSString randomTitleGenerator:20]
          productVersion:[NSString randomTitleGenerator:20]
               inContext:self.managedObjectContext];
    
    NSLog(@"insertRandom");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.radarAdapter sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.radarAdapter sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RadarViewCell *cell = (RadarViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RadarCell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    Radar *radar = (Radar *)[self.radarAdapter objectAtIndexPath:indexPath];
    
    RadarSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderSectionCell"];
    cell.radar = radar;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 70;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RadarDetailSegue"]) {
        Radar *radar = [self.radarAdapter objectAtIndexPath:self.tableView.indexPathForSelectedRow];
        
        EditRadarViewController *vc = segue.destinationViewController;
        vc.radar = radar;
    }
    if ([segue.identifier isEqualToString:@"UsersSegue"]) {
        UsersViewController *users = segue.destinationViewController;
        users.managedObjectContext = self.managedObjectContext;
        users.delegate = self;
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

#pragma mark - RadarAdaprterDelegate

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    Radar *radar = (Radar *)[self.radarAdapter objectAtIndexPath:indexPath];
    
    RadarViewCell *radarCell = (RadarViewCell *)cell;
    radarCell.radar = radar;
}

- (void)filterResultsWithUserRadar:(Radar *)radar {
    NSFetchRequest *fetchRequest = [Radar fetchRequestWithFields:@[@"user"]
                                                       andOrders:@[@YES]
                                              andDistinctResults:NO];
    NSPredicate *predicateUser = [NSPredicate predicateWithFormat:@"user == %@",radar.user];
    [fetchRequest setPredicate:predicateUser];
    
    [self.radarAdapter resultsWithFetchRequest:fetchRequest withSectionNameKeyPath:@"user"];
    [self.tableView reloadData];
}

@end
