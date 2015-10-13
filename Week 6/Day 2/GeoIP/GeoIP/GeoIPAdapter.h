//
//  GeoIPAdapter.h
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@protocol GeoIPAdapterDelegate <NSObject>

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end


@interface GeoIPAdapter : NSObject <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) id<GeoIPAdapterDelegate> delegate;

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext andTableView:(UITableView *)tableView;

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)sections;

- (void)resultsWithFetchRequest:(NSFetchRequest *)fetchRequest
         withSectionNameKeyPath:(NSString *)sectionNameKeyPath;

@end
