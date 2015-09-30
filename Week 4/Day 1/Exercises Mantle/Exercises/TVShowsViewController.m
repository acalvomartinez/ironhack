//
//  TVShowsViewController.m
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "TVShowsViewController.h"

#import "ShowProvider.h"
#import "TVShow.h"

@interface TVShowsViewController ()

@property (nonatomic, strong) ShowProvider *model;

@end

@implementation TVShowsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TV Shows";
    
    self.model = [[ShowProvider alloc]init];
    [self.model loadShowsFromRemote];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model.tvShows count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tvShowCell" forIndexPath:indexPath];
    
    TVShow *tvShow = [self.model.tvShows objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tvShow.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TVShow *tvShow = [self.model.tvShows objectAtIndex:indexPath.row];
    
    if ([self compareWithFirstElement:tvShow]) {
        [self showAlertWithMessage:@"It is equal to first element"];
    } else {
        [self countOccurrences:tvShow];
    }
}

#pragma mark - Private Methods

- (BOOL)compareWithFirstElement:(TVShow *)show {
    TVShow *firstShow = [self.model.tvShows objectAtIndex:0];
    
    return [show isEqual:firstShow];
}

- (void)countOccurrences:(TVShow *)tvShow {
    NSUInteger count = [self.model countTVShowOccurrences:tvShow];

    NSString *message = [NSString stringWithFormat:@"You have %lu equals TVShow: %@", (unsigned long)count, tvShow.title];
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
    [self.model duplicateRandomTVShow];
    [self.tableView reloadData];
}

- (IBAction)saveButtonPressed:(id)sender {
    [self.model saveTVShows];
}

- (IBAction)addButtonPressed:(id)sender {
    [self.model addTVShow];
    [self.tableView reloadData];
}

@end
