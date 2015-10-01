//
//  UserEntity+CoreDataProperties.h
//  MoviesModels
//
//  Created by Joan Romano on 9/28/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSString *userPassword;

@end

NS_ASSUME_NONNULL_END
