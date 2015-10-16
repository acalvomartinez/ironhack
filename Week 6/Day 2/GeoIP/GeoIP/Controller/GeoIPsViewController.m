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
@property (nonatomic, strong) NSManagedObjectContext *backgroundContext;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trashButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

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
    
    self.trashButton.enabled = NO;
    self.addButton.enabled = NO;
    
    __weak typeof(self) weakSelf = self;
    [self createContextInBackgroundWithCompletionBlock:^{
        weakSelf.trashButton.enabled = YES;
        weakSelf.addButton.enabled = YES;
    }];
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
                                                                            inContext:weakSelf.managedObjectContext];
                                                       
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
    __weak typeof(self) weakSelf = self;
    [self.backgroundContext performBlockAndWait:^{
        [weakSelf megaInsert:weakSelf.backgroundContext];
    }];
}

- (void)somethingSaved:(NSNotification *)notificationWithContext {
    [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notificationWithContext];
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
}

- (void)createContextInBackgroundWithCompletionBlock:(void(^)(void))completion {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSAssert([NSThread currentThread] != [NSThread mainThread], @"OMG!");
        
        weakSelf.backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        weakSelf.backgroundContext.persistentStoreCoordinator = weakSelf.managedObjectContext.persistentStoreCoordinator;
        
        [[NSNotificationCenter defaultCenter] addObserver:weakSelf
                                                 selector:@selector(somethingSaved:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:weakSelf.backgroundContext];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion == nil ? : completion();
        });
    });
}

- (IBAction)removeAllPressed:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self.backgroundContext performBlockAndWait:^{
        [weakSelf removeAllGeoIPFromContext:weakSelf.backgroundContext];
    }];
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
