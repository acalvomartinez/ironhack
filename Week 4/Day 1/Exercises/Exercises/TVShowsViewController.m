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


#pragma mark - Actions

- (IBAction)duplicateButtonPressed:(id)sender {
    [self.model duplicateRandomTVShow];
    [self.tableView reloadData];
}

- (IBAction)saveButtonPressed:(id)sender {
    [self.model saveTVShows];
}
@end
