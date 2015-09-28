//
//  BookmarsViewController.m
//  NSCoding Practice
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "BookmarsViewController.h"
#import "BookmarkList.h"
#import "Bookmark.h"

#import "AddBookmarkViewController.h"

@interface BookmarsViewController () <AddBookmarkDelegate>

@property (nonatomic, strong) BookmarkList *model;

@end

@implementation BookmarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [[BookmarkList alloc]init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model.bookmarks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookmarkCell" forIndexPath:indexPath];
    
    Bookmark *bookmark = [self.model.bookmarks objectAtIndex:indexPath.row];
    
    cell.textLabel.text = bookmark.url;
    cell.detailTextLabel.text = bookmark.name;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
    AddBookmarkViewController *vc = (AddBookmarkViewController *)nc.topViewController;
    vc.delegate = self;
    
}

#pragma mark - AddBookmark Delegate

- (void)addBookmarkViewController:(id)viewController
           didSaveBookmarkWithURL:(NSString *)url
                             name:(NSString *)name {

    
    if ([self.model addBookmarkWithName:name url:url]) {
        [self.tableView reloadData];
        [viewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSLog(@"ERROR");
    }

    
    
    
}



@end
