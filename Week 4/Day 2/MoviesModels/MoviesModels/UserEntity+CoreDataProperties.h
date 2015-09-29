//
//  UserEntity+CoreDataProperties.h
//  MoviesModels
//
//  Created by Toni on 29/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *password;

@end

NS_ASSUME_NONNULL_END
