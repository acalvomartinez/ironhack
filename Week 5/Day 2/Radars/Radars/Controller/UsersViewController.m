//
//  UsersViewController.m
//  Radars
//
//  Created by Toni on 09/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "UsersViewController.h"
#import "RadarsAdapter.h"

#import "Radar.h"

@interface UsersViewController () <RadarsAdapterDelegate>

@property (nonatomic, strong) RadarsAdapter *radarAdapter;


@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.radarAdapter = [[RadarsAdapter alloc] initWithManagedObjectContext:self.managedObjectContext
                                                               andTableView:self.tableView];
    
    self.radarAdapter.delegate = self;
    
    NSFetchRequest *fetchRequest = [Radar fetchRequestWithFields:@[@"user"]
                                                       andOrders:@[@YES]
                                              andDistinctResults:YES];
    fetchRequest.resultType = NSDictionaryResultType;
    
    [self.radarAdapter resultsWithFetchRequest:fetchRequest withSectionNameKeyPath:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Radar *radar = (Radar *)[self.radarAdapter objectAtIndexPath:indexPath];
    [self.delegate filterResultsWithUserRadar:radar];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - RadarAdaprterDelegate

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    Radar *radar = (Radar *)[self.radarAdapter objectAtIndexPath:indexPath];
    cell.textLabel.text = radar.user;
}


@end
