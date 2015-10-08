//
//  RadarsViewController.m
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "RadarsViewController.h"

#import "EditRadarViewController.h"

#import "CoreDataStack.h"
#import "RadarViewCell.h"
#import "Radar.h"

#import "RadarAPIWrapper.h"
#import "JSONParser.h"


@interface RadarsViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
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


- (void)configureCell:(RadarViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Radar *radar = (Radar *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.radar =radar;
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[Radar description]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"user" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                    managedObjectContext:self.managedObjectContext
                                                                      sectionNameKeyPath:nil
                                                                               cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
    }
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
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
                           
                           //TODO: ASK DIEGO ABOUT HOW TO...
                           
                           [JSONParser parseJSONString:returnData usingContext:weakSelf.managedObjectContext];
                           [weakSelf.tableView reloadData];
                           
                           [weakSelf.refreshControl endRefreshing];
                           
                       } onError:^(NSError * _Nullable error) {
                           NSLog(@"%@", error);
                           
                           [weakSelf.refreshControl endRefreshing];
                       }];
    
}

@end
