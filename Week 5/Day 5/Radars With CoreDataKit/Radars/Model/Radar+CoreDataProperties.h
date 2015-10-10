//
//  Radar+CoreDataProperties.h
//  Radars
//
//  Created by Toni on 08/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Radar.h"

NS_ASSUME_NONNULL_BEGIN

@interface Radar (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *product;
@property (nullable, nonatomic, retain) NSString *productVersion;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *user;

@end

NS_ASSUME_NONNULL_END
