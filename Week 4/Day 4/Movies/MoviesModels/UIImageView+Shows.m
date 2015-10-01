//
//  UIImageView+Download.m
//  MoviesModels
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "UIImageView+Shows.h"

#import "ImageDownloader.h"

@import UIKit;

@implementation UIImageView (Shows)

- (void)setImageFromURL:(NSString *)url completion:(ImageCompletionBlock)completion {
    
//    dispatch_queue_t download_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//    dispatch_async(download_queue, ^{
//        NSData *imageData = [NSData dataWithContentsOfURL:url];
//        UIImage *image = [UIImage imageWithData:imageData];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (image) {
//                self.image = image;
//            }
//            if (completion) {
//                completion(image?YES:NO);
//            }
//           
//        });
//    });
    
    [[ImageDownloader sharedInstance] downloadImageAtURL:url completion:^(UIImage *image) {
        self.image = image;
        if (completion) {
            completion(image?YES:NO);
        }
    }];
    
}

@end
