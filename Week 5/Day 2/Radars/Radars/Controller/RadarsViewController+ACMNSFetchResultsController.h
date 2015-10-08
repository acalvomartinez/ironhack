//
//  RadarsViewController+FetchResults.h
//  Radars
//
//  Created by Toni on 08/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "RadarsViewController.h"

@class RadarViewCell;

@interface RadarsViewController (ACMNSFetchResultsController) <NSFetchedResultsControllerDelegate>

- (NSFetchedResultsController *)fetchedResultsController;

@end
