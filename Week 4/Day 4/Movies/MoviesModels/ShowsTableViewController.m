//
//  ShowsTableViewController.m
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "ShowsTableViewController.h"

#import "Show.h"
#import "UserEntity.h"
#import "ShowsProvider.h"
#import "NSArray+Random.h"
#import "NSString+Random.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "UserEntity+CoreDataProperties.h"

#import "ShowDetailViewController.h"
#import "CustomBarButtonItem.h"

#import "UIImageView+Shows.h"

#import <libextobjc/EXTScope.h>

static NSString * const savedShowsFileName = @"shows";

@interface ShowsTableViewController () <UITabBarControllerDelegate>

@property (strong,nonatomic) NSMutableArray *shows;
@property (strong,nonatomic) NSMutableArray *likes;
@property (strong,nonatomic) ShowsProvider *showsProvider;

@end

@implementation ShowsTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin:) name:UserDidLogNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout:) name:UserDidLogoutNotification object:nil];
        self.title = @"Shows";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CustomBarButtonItem *saveShowsButton = [[CustomBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain actionBlock:^{
        [self saveShows:saveShowsButton];
    }];
    self.navigationItem.leftBarButtonItem = saveShowsButton;
    CustomBarButtonItem *duplicateMovieButton = [[CustomBarButtonItem alloc] initWithTitle:@"Duplicate" style:UIBarButtonItemStylePlain actionBlock:^{
        [self addDuplicatedShow:saveShowsButton];
    }];
    CustomBarButtonItem *addMovieButton = [[CustomBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain actionBlock:^{
        [self addShow:saveShowsButton];
    }];
    self.navigationItem.rightBarButtonItems = @[duplicateMovieButton, addMovieButton];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateTitleWithLoggedUser:[self loggedUser]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![self loggedUser])
    {
        [self presentLoginView];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"presentLogin"]) {
        LoginViewController *loginViewController = segue.destinationViewController;
        loginViewController.managedObjectContext = self.managedObjectContext;
    }
    
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        ShowDetailViewController *detailViewController = segue.destinationViewController;
        
        Show *show = [self.shows objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        detailViewController.show = show;
    }
    
}

- (UserEntity *)loggedUser
{
    UserEntity *loggedUser;
    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([UserEntity class])];
    request.predicate=[NSPredicate predicateWithFormat:@"1=1"];
    NSArray *users=[self.managedObjectContext executeFetchRequest:request error:nil];
    if (users.count) {
        loggedUser=[users firstObject];
    }
    return loggedUser;
}

- (void)presentLoginView
{
    [self performSegueWithIdentifier:@"presentLogin" sender:self];
}

- (void)updateTitleWithLoggedUser:(UserEntity *)user
{
    self.navigationItem.title = user? [NSString stringWithFormat:@"Movies (%@)",user.userName] : @"Shows";
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    Show *show = self.shows[indexPath.item];
    cell.textLabel.text=show.showTitle;
    cell.detailTextLabel.text=show.showDescription;
    cell.accessoryType = [self.likes containsObject:show.showId] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    @weakify(cell);
    [cell.imageView setImageFromURL:show.posterURL completion:^(BOOL success) {
        @strongify(cell);
        [cell layoutSubviews];
    }];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Notifications

- (void)userDidLogin:(NSNotification *)notification
{
    [self updateTitleWithLoggedUser:[self loggedUser]];
}

- (void)userDidLogout:(NSNotification *)notification
{
    [self loadData];
    [self.tableView reloadData];
}

#pragma mark - Add

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

#pragma mark - Load

- (void)loadData
{
    [self loadLikes];
    [self loadShowsFromRemote];
}

- (void)loadShows
{
    self.showsProvider = [[ShowsProvider alloc] init];
    self.shows = [[self.showsProvider showsFromRemote] mutableCopy];
    
    NSArray *shows = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    if (shows.count)
    {
        self.shows =  [shows mutableCopy];
    }
}

- (void)loadShowsFromRemote
{
    self.showsProvider = [[ShowsProvider alloc] init];
    
    @weakify(self);
    [self.showsProvider loadShowsDataFromRemoteOnSucces:^(NSArray *results) {
        @strongify(self);
        self.shows = [results mutableCopy];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadLikes
{
    NSString *savesFilePath = [self savesFilePath];
    NSDictionary *likesDictionary = [NSDictionary dictionaryWithContentsOfFile:savesFilePath];
    self.likes = likesDictionary ? [likesDictionary[@"likes"] mutableCopy] : [NSMutableArray array];
}

- (NSString *)archivePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    return [documentsDirectory stringByAppendingPathComponent:savedShowsFileName];
}

#pragma mark - Save

- (NSString *)savesFilePath
{
    UserEntity *loggedUser = [self loggedUser];
    NSString *savesFilePath;
    if (loggedUser)
    {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        savesFilePath = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_saves.plist",loggedUser.userName]];
    }
    return savesFilePath;
}

- (void)saveShows:(id)sender
{
    if (self.shows.count)
    {
        [NSKeyedArchiver archiveRootObject:self.shows toFile:[self archivePath]];
        [self saveLikes];
    }
}

- (void)saveLikes
{
    NSString *savesFilePath = [self savesFilePath];
    if (savesFilePath) {
        [@{@"likes":self.likes} writeToFile:savesFilePath atomically:YES];
    }
}

@end
