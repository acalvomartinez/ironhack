//
//  DownloadManager.h
//  GDC Practice
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

typedef void(^DownloadImageCompletionBlock)(UIImage *);

@interface ImageManager : NSObject

+ (instancetype)sharedInstance;

- (void)downloadImageAtURL:(NSString *)url completion:(DownloadImageCompletionBlock)completion;
@end
