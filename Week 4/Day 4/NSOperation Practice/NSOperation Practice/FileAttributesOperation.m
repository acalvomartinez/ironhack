//
//  FileAttributesOperation.m
//  NSOperation Practice
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "FileAttributesOperation.h"

@interface FileAttributesOperation ()

@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) FileAttributesCompletionBlock completion;

@end

@implementation FileAttributesOperation

- (instancetype)initWithPath:(NSString *)path completion:(FileAttributesCompletionBlock)completion {
    if (self = [super init]) {
        _path = [path copy];
        _completion = [completion copy];
    }
    return self;
}

- (void)main {
    for (NSInteger i = 0; i < 5; i++) {
        if (self.cancelled) {
            return;
        }
        NSLog(@"Sleeping %@", @(i));
        sleep(1);
    }
    
    if (self.cancelled) {
        return;
    }
    
    NSError *error;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:self.path error:&error];
    self.completion(attributes);
}

@end
