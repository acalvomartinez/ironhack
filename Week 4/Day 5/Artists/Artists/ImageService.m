//
//  ImageService.m
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ImageService.h"

@import UIKit;

@interface ImageService ()

@property (nonatomic, strong) dispatch_queue_t service_q;

@end

@implementation ImageService

- (void)imageWithURL:(NSURL *)imageURL completion:(void (^)(UIImage *))completion {
    
    dispatch_async(self.service_q, ^{
        NSString *filenamePath = [self filenamePathForURL:imageURL];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filenamePath]) {
            NSData *imageData = [NSData dataWithContentsOfFile:filenamePath];
            UIImage *image = [UIImage imageWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        } else {
            [self fetchImageFromRemoteURL:imageURL completion:^(UIImage *image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(image);
                });
            }];
        }
    });
}


- (dispatch_queue_t)service_q {
    if (!_service_q) {
        _service_q = dispatch_queue_create("com.ironhack.service.image", DISPATCH_QUEUE_CONCURRENT);
    }
    return _service_q;
}

- (NSString *)filenamePathForURL:(NSURL *)imageURL {
    NSString *filename = [imageURL lastPathComponent];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[paths firstObject] stringByAppendingPathComponent:filename];
}

- (void)fetchImageFromRemoteURL:(NSURL *)url completion:(void (^)(UIImage *))completion {
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
    }] resume];
}

@end
