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

#import "GeoIPDetailMapViewController.h"

@interface GeoIPsViewController () <GeoIPAdapterDelegate>

@property (nonatomic, strong) GeoIPAdapter *geoIPAdapter;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trashButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end

@implementation GeoIPsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"List";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshButtonPressed:) forControlEvents:UIControlEventValueChanged];
    
    [super viewWillAppear:animated];
    
    self.geoIPAdapter = [[GeoIPAdapter alloc] initWithManagedObjectContext:self.parentContext
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
    NSArray *directions = [IP4Generator genareteIP4ArrayWithCapacity:3];
    
    __weak GeoIPsViewController *weakSelf = self;
    GeoIPAPIWrapper *apiWrapper = [[GeoIPAPIWrapper alloc] init];
    [apiWrapper geoIPsInDirections:directions
                        completion:^(NSArray<NSString *> *jsonGeoIPs) {
                            [GeoIPJSONParser parseJSONArray:jsonGeoIPs
                                               onCompletion:^(NSArray<GeoIPJSON *> *geoIPJSONs) {
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       [GeoIPJSONMapper mapGeoIPJSONs:geoIPJSONs
                                                                            inContext:weakSelf.childContext];
                                                       
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

- (IBAction)megaEvilInsert:(id)sender {
    [self megaInsert:self.childContext];
}

- (void)megaInsert:(NSManagedObjectContext *)context {
    for (int i = 0; i < 1000; i++) {
        GeoIP *geoIP = [GeoIP insertInManagedObjectContext:context];
        geoIP.ip = [IP4Generator generateRandomIP4];
        geoIP.country = [NSString stringWithFormat:@"Country %d",i];
    }
    
    NSError *error;
    [context save:&error];
    if (error) {
        NSLog(@"😱");
    }
    
    [self.parentContext save:nil];
}

- (IBAction)removeAllPressed:(id)sender {
    [self removeAllGeoIPFromContext:self.childContext];
}

- (void)removeAllGeoIPFromContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[GeoIP entityName]];
    NSError *error;
    NSArray *geoIPs = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        return;
    }
    
    [geoIPs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [context deleteObject:obj];
    }];
    
    error = nil;
    [context save:&error];
    if (error) {
        NSLog(@"😱");
    }
    [self.parentContext save:nil]; 
}



#pragma mark - GeoIPAdapterDelegate

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    GeoIP *geoIP = (GeoIP *)[self.geoIPAdapter objectAtIndexPath:indexPath];
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.geoIPAdapter sections][indexPath.section];
    CGFloat d = 1 - (CGFloat)(indexPath.row + 1) / (CGFloat)[sectionInfo numberOfObjects];
    
    cell.backgroundColor = [UIColor colorWithHue:d saturation:d brightness:d alpha:1];
    
    GeoIPCell *geoIPCell = (GeoIPCell *)cell;
    geoIPCell.geoIP = geoIP;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"MapDetailSegue"]) {
        GeoIPDetailMapViewController *vc = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        GeoIP *geoIP = (GeoIP *)[self.geoIPAdapter objectAtIndexPath:indexPath];
        vc.geoIP = geoIP;
    }
}


@end
