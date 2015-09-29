//
//  ShowsTableViewController.m
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "ShowsTableViewController.h"

#import "Show.h"
#import "ShowsProvider.h"
#import "NSArray+Random.h"
#import "NSString+Random.h"

#import "UserLoginViewController.h"

#import "UserEntity.h"

static NSString * const savedShowsFileName = @"shows";

@interface ShowsTableViewController () <UITabBarControllerDelegate>

@property (strong,nonatomic) NSMutableArray *shows;
@property (strong,nonatomic) ShowsProvider *showsProvider;
@property (strong, nonatomic) UserEntity *user;

@end

@implementation ShowsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shows = [NSMutableArray array];

    UIBarButtonItem *saveShowsButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveShows:)];
    self.navigationItem.leftBarButtonItem = saveShowsButton;
    UIBarButtonItem *duplicateMovieButton = [[UIBarButtonItem alloc] initWithTitle:@"Duplicate" style:UIBarButtonItemStylePlain target:self action:@selector(addDuplicatedShow:)];
    UIBarButtonItem *addMovieButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addShow:)];
    self.navigationItem.rightBarButtonItems = @[duplicateMovieButton, addMovieButton];
    
    self.showsProvider = [[ShowsProvider alloc] init];
    self.shows = [[self.showsProvider showsFromRemote] mutableCopy];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLoggedNotification:) name:@"userLoggedNotification" object:nil];
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![self isUserLogged]) {
        [self performSegueWithIdentifier:@"showsLogin" sender:self];
    }
}

- (BOOL)isUserLogged {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest  fetchRequestWithEntityName:NSStringFromClass([UserEntity class])];
    
    NSError *error;
    NSArray *fetchResult = [self.managedContext executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchResult count] == 0)
    {
        return NO;
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userLoggedNotification" object:self userInfo:@{@"userLogged":[fetchResult firstObject]}];
    
    return YES;
}

- (void)handleUserLoggedNotification:(NSNotification *)notification {
    self.user = [notification.userInfo objectForKey:@"userLogged"];
    self.navigationItem.title = self.user.name;
    
}

- (void)addDuplicatedShow:(id)sender
{
    [self.shows addObject:[self.shows mm_randomObject]];
    
    [self.tableView reloadData];
}

- (void)addShow:(id)sender
{
    [self.shows addObject:[self randomShow]];
    [self.tableView reloadData];
}

- (Show *)randomShow
{
    Show *show = [[Show alloc] init];
    show.showId = [NSString mm_randomString];
    show.showTitle = [NSString mm_randomString];
    show.showDescription = [NSString mm_randomString];
    show.showRating = arc4random()/10.0f;
    
    return show;
}

- (NSString *)archivePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    return [documentsDirectory stringByAppendingPathComponent:savedShowsFileName];
}

- (void)saveShows:(id)sender
{
    if (self.shows.count)
    {
        [NSKeyedArchiver archiveRootObject:self.shows toFile:[self archivePath]];
    }
}

- (void)loadShows
{
    NSArray *shows = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    if (shows.count)
    {
        self.shows = [shows mutableCopy];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Show *show = self.shows[indexPath.item];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = show.showTitle;
    cell.detailTextLabel.text = show.showDescription;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Show *show=[self.shows objectAtIndex:indexPath.item];
    
    if (indexPath.row>=0 && indexPath.row<=1)
    {
        [self compareWithFirstShow:show];
    }
    else
    {
        [self findShow:show];
    }
}

- (void)compareWithFirstShow:(Show *)show
{
    UIAlertController *alert;
    Show *firstShow=[self.shows firstObject];
    
    if ([firstShow isEqual:show])
    {
        alert = [UIAlertController alertControllerWithTitle:@"Equal Show" message:@"It is equal !!" preferredStyle:UIAlertControllerStyleAlert];
    }
    else
    {
        alert = [UIAlertController alertControllerWithTitle:@"Equal Show" message:@"IIt is NOT equal" preferredStyle:UIAlertControllerStyleAlert];
    }
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)findShow:(Show *)show
{
    UIAlertController *alert;
    
    if ([self.shows containsObject:show])
    {
        alert = [UIAlertController alertControllerWithTitle:@"Find Show" message:@"Found !" preferredStyle:UIAlertControllerStyleAlert];
    }
    else
    {
        alert = [UIAlertController alertControllerWithTitle:@"Find Show" message:@"Not in dataSource" preferredStyle:UIAlertControllerStyleAlert];
    }
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - Segue Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UserLoginViewController *viewController = segue.destinationViewController;
    viewController.managedContext = self.managedContext;
}

@end
