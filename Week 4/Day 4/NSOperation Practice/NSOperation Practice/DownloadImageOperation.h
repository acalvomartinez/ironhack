//
//  DownloadImageOperation.h
//  NSOperation Practice
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

typedef void(^DownloadImageCompletionBlock)(UIImage *);

@interface DownloadImageOperation : NSOperation

- (instancetype)initWithURLString:(NSString *)urlString completion:(DownloadImageCompletionBlock)completion;

@end
