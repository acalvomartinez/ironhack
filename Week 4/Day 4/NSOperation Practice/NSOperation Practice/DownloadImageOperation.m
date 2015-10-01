//
//  DownloadImageOperation.m
//  NSOperation Practice
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "DownloadImageOperation.h"

@import UIKit;

@interface DownloadImageOperation ()

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) DownloadImageCompletionBlock completion;

@end

@implementation DownloadImageOperation


- (instancetype)initWithURLString:(NSString *)urlString completion:(DownloadImageCompletionBlock)completion {
    if (self = [super init]) {
        _url = [NSURL URLWithString:urlString];
        _completion = [completion copy];
    }
    return self;
}

- (void)main {
    if (self.cancelled) {
        return;
    }
    
    NSData *imageData = [NSData dataWithContentsOfURL:self.url];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.completion([UIImage imageWithData:imageData]);
    });
    
}

@end
