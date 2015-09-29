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

@property (strong, nonatomic) NSMutableArray *likes;
@property (strong, nonatomic) NSString *likesFilePath;

@end

@implementation ShowsTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLoggedNotification:) name:@"userLoggedNotification" object:nil];
        
        self.shows = [NSMutableArray array];
    }
    return self;
}


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

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![self isUserLogged]) {
        [self performSegueWithIdentifier:@"showsLogin" sender:self];
    } else {
        self.user = [self loggedUser];
        [self setupLikesFilePath];
        
        self.likes = [NSMutableArray arrayWithContentsOfFile:self.likesFilePath];
        
        if (!self.likes) {
            self.likes = [NSMutableArray new];
        }
    }
    
    [self.tableView reloadData];
}

- (void)setupLikesFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths firstObject];
    
    self.likesFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_saves.plist", self.user.name]];
}

- (UserEntity *)loggedUser {
    NSFetchRequest *fetchRequest = [NSFetchRequest  fetchRequestWithEntityName:NSStringFromClass([UserEntity class])];
    
    NSError *error;
    NSArray *fetchResult = [self.managedContext executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchResult count] == 0)
    {
        return nil;
    }
    
    return [fetchResult firstObject];
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
    
    if (self.likes.count)
    {
        [self.likes writeToFile:self.likesFilePath atomically:YES];
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
    
    if ([self.likes containsObject:show.showId]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Show *show=[self.shows objectAtIndex:indexPath.item];
//    
//    if (indexPath.row>=0 && indexPath.row<=1)
//    {
//        [self compareWithFirstShow:show];
//    }
//    else
//    {
//        [self findShow:show];
//    }
    Show *show = [self.shows objectAtIndex:indexPath.item];
    
    if ([self.likes containsObject:show.showId]) {
        [self.likes removeObject:show.showId];
    } else {
        [self.likes addObject:show.showId];
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
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
    
    self.likesFilePath = nil;
    self.likes = nil;
}

@end
