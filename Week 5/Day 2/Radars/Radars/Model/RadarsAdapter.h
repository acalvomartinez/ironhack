//
//  RadarsAdapter.h
//  Radars
//
//  Created by Toni on 09/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
@class RadarViewCell;

@protocol RadarsAdapterDelegate <NSObject>

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@interface RadarsAdapter : NSObject <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) id<RadarsAdapterDelegate> delegate;


- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext andTableView:(UITableView *)tableView;

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)sections;

- (void)resultsWithFetchRequest:(NSFetchRequest *)fetchRequest
         withSectionNameKeyPath:(NSString *)sectionNameKeyPath;

@end
