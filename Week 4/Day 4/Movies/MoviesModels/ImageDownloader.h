//
//  ImageDownloader.h
//  MoviesModels
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

typedef void(^DownloadImageCompletionBlock)(UIImage *);
typedef void(^FailureFileManagerBlock)(NSError *);

@interface ImageDownloader : NSObject

+ (instancetype)sharedInstance;

- (void)downloadImageAtURL:(NSString *)url completion:(DownloadImageCompletionBlock)completion;
@end
