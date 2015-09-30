//
//  MoviesViewController.m
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "MoviesViewController.h"

#import "ShowProvider.h"
#import "Movie.h"

@interface MoviesViewController ()

@property (nonatomic, strong) ShowProvider *model;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Movies";
    
    self.model = [[ShowProvider alloc]init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model.movies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    
    Movie *movie = [self.model.movies objectAtIndex:indexPath.row];
    
    cell.textLabel.text = movie.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     Movie *movie = [self.model.movies objectAtIndex:indexPath.row];
    
    if ([self compareWithFirstElement:movie]) {
        [self showAlertWithMessage:@"It is equal to first element"];
    } else {
        [self countOccurrences:movie];
    }
}

- (BOOL)compareWithFirstElement:(Movie *)movie {
    Movie *firstMovie = [self.model.movies objectAtIndex:0];
    
    return [movie isEqual:firstMovie];
}

- (void)countOccurrences:(Movie *)movie {
    NSUInteger count = [self.model countMovieOccurrences:movie];
    
    NSString *message = [NSString stringWithFormat:@"You have %lu equals Movie: %@", (unsigned long)count, movie.title];
    [self showAlertWithMessage:message];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)duplicateButtonPressed:(id)sender {
    [self.model duplicateRandomMovie];
    [self.tableView reloadData];
}

- (IBAction)saveButtonPressed:(id)sender {
    [self.model saveMovies];
}

- (IBAction)addButtonPressed:(id)sender {
    [self.model addMovie];
    [self.tableView reloadData];
}

@end
