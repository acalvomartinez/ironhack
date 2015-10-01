//
//  FileAttributesOperation.h
//  NSOperation Practice
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FileAttributesCompletionBlock)(NSDictionary *);

@interface FileAttributesOperation : NSOperation

- (instancetype)initWithPath:(NSString *)path completion:(FileAttributesCompletionBlock)completion;

@end
