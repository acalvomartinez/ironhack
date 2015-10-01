//
//  RequestManager.h
//  MoviesModels
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailureBlock)(NSError *error);

@interface RequestManager : NSObject

- (void)getJSONWithURL:(NSString *)url success:(SuccessBlock)successBlock failure:(FailureBlock)failure;

@end
