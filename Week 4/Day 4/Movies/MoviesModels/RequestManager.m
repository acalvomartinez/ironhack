//
//  RequestManager.m
//  MoviesModels
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "RequestManager.h"


@interface RequestManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation RequestManager

- (AFHTTPRequestOperationManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}

- (void)getJSONWithURL:(NSString *)url success:(SuccessBlock)successBlock failure:(FailureBlock)failure {
    [self.manager GET:url
           parameters:nil
              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  successBlock(responseObject);
              }
              failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                  failure(error);
    }];
}

@end
