//
//  GeoIPsViewController.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "GeoIPsViewController.h"

#import "GeoIPAPIWrapper.h"
#import "GeoIPAdapter.h"
#import "GeoIP.h"

#import "IP4Generator.h"

#import "GeoIPJSONParser.h"
#import "GeoIPJSONMapper.h"

#import "GeoIPCell.h"

#import "GeoIPMapViewController.h"

@interface GeoIPsViewController () <GeoIPAdapterDelegate>

@property (nonatomic, strong) GeoIPAdapter *geoIPAdapter;

@end

@implementation GeoIPsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSAssert(self.managedObjectContext != nil, @"ViewControllers needs a managedObjectContext!");
    
    self.title = @"List";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshButtonPressed:) forControlEvents:UIControlEventValueChanged];
    
    self.geoIPAdapter = [[GeoIPAdapter alloc] initWithManagedObjectContext:self.managedObjectContext
                                                               andTableView:self.tableView];
    
    self.geoIPAdapter.delegate = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.geoIPAdapter sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.geoIPAdapter sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"GeoIPCell"];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


#pragma mark - Actions

- (IBAction)refreshButtonPressed:(UIBarButtonItem *)sender {
    
    __weak GeoIPsViewController *weakSelf = self;
    
    GeoIPAPIWrapper *apiWrapper = [[GeoIPAPIWrapper alloc] init];
    
    NSArray *directions = [IP4Generator genareteIP4ArrayWithCapacity:3];
    
    [apiWrapper geoIPsInDirections:directions
                        completion:^(NSArray<NSString *> *jsonGeoIPs) {
                           
                            [GeoIPJSONParser parseJSONArray:jsonGeoIPs
                                               onCompletion:^(NSArray<GeoIPJSON *> *geoIPJSONs) {
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       NSArray * geoIPs = [GeoIPJSONMapper mapGeoIPJSONs:geoIPJSONs
                                                                                               inContext:weakSelf.managedObjectContext];
                                                       
                                                       NSLog(@"%@",geoIPs);
                                                       [weakSelf.tableView reloadData];
                                                       [weakSelf.refreshControl endRefreshing];
                                                   });
                                               } onErrorBlock:^(NSError *error) {
                                                   NSLog(@"%@",error);
                                                   [weakSelf.refreshControl endRefreshing];
                                               }];
                            
    } onError:^(NSError * error) {
        NSLog(@"%@", error);
        [weakSelf.refreshControl endRefreshing];
    }];
    
}

#pragma mark - GeoIPAdapterDelegate

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    GeoIP *geoIP = (GeoIP *)[self.geoIPAdapter objectAtIndexPath:indexPath];
    
    GeoIPCell *geoIPCell = (GeoIPCell *)cell;
    geoIPCell.geoIP = geoIP;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"MapDetailSegue"]) {
        GeoIPMapViewController *vc = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        GeoIP *geoIP = (GeoIP *)[self.geoIPAdapter objectAtIndexPath:indexPath];
        vc.geoIP = geoIP;
    }
}


@end
