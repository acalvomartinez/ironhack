//
//  ShowsProvider.h
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessCompletionBlock)(NSArray *);
typedef void(^FailureBlock)(NSError *);

@interface ShowsProvider : NSObject

- (NSArray *)showsFromRemote;

- (void)loadShowsDataFromRemoteOnSucces:(SuccessCompletionBlock)success failure:(FailureBlock)failure;

@end
