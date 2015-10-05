//
//  ArtistsViewController.m
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ArtistsViewController.h"
#import "ArtistService.h"
#import "Artist.h"

#import "ArtistDetailViewController.h"

@interface ArtistsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *artists;


@end

@implementation ArtistsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Artists!";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self loadArtistsFromService];
}

#pragma mark - Private

- (void)loadArtistsFromService {
    ArtistService *service = [[ArtistService alloc]init];
    [service artistsWithCompletion:^(NSArray *artists) {
        self.artists = artists;
        [self.tableView reloadData];
    }];
}

#pragma mark - TableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"artistCell" forIndexPath:indexPath];
    
    Artist *artist = [self.artists objectAtIndex:indexPath.item];
    cell.textLabel.text = artist.name;
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Navegation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ArtistSegue"]) {
        UINavigationController *nc = segue.destinationViewController;
        
        ArtistDetailViewController *vc = (ArtistDetailViewController *)nc.topViewController;
        
        Artist *artist = [self.artists objectAtIndex:[self.tableView indexPathForSelectedRow].item];
        vc.artist = artist;
    }
}

@end
