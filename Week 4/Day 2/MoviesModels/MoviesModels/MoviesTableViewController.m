//
//  MoviesTableViewController.m
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "MoviesTableViewController.h"

#import "Movie.h"
#import "NSArray+Random.h"
#import "NSString+Random.h"

#import "UserEntity.h"

static NSString *const savedMoviesFileName = @"movies";

@interface MoviesTableViewController ()

@property (strong,nonatomic) NSMutableArray *movies;

@property (strong, nonatomic) UserEntity *user;

@property (strong, nonatomic) NSMutableArray *likes;

@end

@implementation MoviesTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLoggedNotification:) name:@"userLoggedNotification" object:nil];
        
        self.movies = [NSMutableArray array];
    }
    return self;
}

- (NSMutableArray *)likes {
    if (!_likes) {
        _likes = [self loadSavedMovieLikes];
    }
    return _likes;
}

- (NSMutableArray *)loadSavedMovieLikes {
    return [NSMutableArray new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *saveMoviesButton=[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveMovies:)];
    self.navigationItem.leftBarButtonItem = saveMoviesButton;
    UIBarButtonItem *duplicateMovieButton = [[UIBarButtonItem alloc] initWithTitle:@"Duplicate" style:UIBarButtonItemStylePlain target:self action:@selector(addDuplicatedMovie:)];
    UIBarButtonItem *addMovieButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addMovie:)];
    self.navigationItem.rightBarButtonItems = @[duplicateMovieButton, addMovieButton];
    
    [self loadMovies];
    
    if (!self.movies.count)
    {
        for (NSInteger i = 0; i < 5; i++) {
            [self.movies addObject:[self randomMovie]];
        }
        
    }
}

- (void)handleUserLoggedNotification:(NSNotification *)notification {
    self.user = [notification.userInfo objectForKey:@"userLogged"];
    self.navigationItem.title = self.user.name;
    
}

- (void)addDuplicatedMovie:(id)sender
{
    [self.movies addObject:[self.movies mm_randomObject]];
    
    [self.tableView reloadData];
}

- (void)addMovie:(id)sender
{
    [self.movies addObject:[self randomMovie]];
    
    [self.tableView reloadData];
}

- (Movie *)randomMovie
{
    Movie *movie = [[Movie alloc] init];
    movie.movieId = [NSString mm_randomString];
    movie.movieTitle = [NSString mm_randomString];
    movie.movieDescription = [NSString mm_randomString];
    movie.movieRating = arc4random()/10.0f;
    
    return movie;
}

- (NSString *)archivePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:savedMoviesFileName];
}

- (void)saveMovies:(id)sender
{
    if (self.movies.count)
    {
        [NSKeyedArchiver archiveRootObject:self.movies toFile:[self archivePath]];
    }
}

- (void)loadMovies
{
    NSArray *movies = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    if (movies.count)
    {
        self.movies = [movies mutableCopy];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    Movie *movie=[self.movies objectAtIndex:indexPath.item];
    cell.textLabel.text=movie.movieTitle;
    cell.detailTextLabel.text=movie.movieDescription;
    
    if ([self.likes containsObject:movie.movieId]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Movie *movie = [self.movies objectAtIndex:indexPath.item];
//    
//    if (indexPath.row>=0 && indexPath.row<=1)
//    {
//        [self compareWithFirstMovie:movie];
//    }
//    else
//    {
//        [self findMovie:movie];
//    }
    
    Movie *movie = [self.movies objectAtIndex:indexPath.item];
    
    if ([self.likes containsObject:movie.movieId]) {
        [self.likes removeObject:movie.movieId];
    } else {
        [self.likes addObject:movie.movieId];
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
    
}


- (void)compareWithFirstMovie:(Movie *)movie
{
    UIAlertController *alert;
    Movie *firstMovie = [self.movies firstObject];
    
    if ([firstMovie isEqual:movie])
    {
        alert = [UIAlertController alertControllerWithTitle:@"Equal Movie" message:@"It is equal !!" preferredStyle:UIAlertControllerStyleAlert];
    }
    else
    {
        alert = [UIAlertController alertControllerWithTitle:@"Equal Movie" message:@"IIt is NOT equal" preferredStyle:UIAlertControllerStyleAlert];
    }
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)findMovie:(Movie *)movie
{
    UIAlertController *alert;
    
    if ([self.movies containsObject:movie])
    {
        alert = [UIAlertController alertControllerWithTitle:@"Find Movie" message:@"Found !" preferredStyle:UIAlertControllerStyleAlert];
    }
    else
    {
        alert = [UIAlertController alertControllerWithTitle:@"Find Movie" message:@"Not in dataSource" preferredStyle:UIAlertControllerStyleAlert];
    }
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [alert dismissViewControllerAnimated:YES completion:nil];
                             
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
