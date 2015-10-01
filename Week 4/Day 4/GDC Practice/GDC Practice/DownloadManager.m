//
//  DownloadManager.m
//  GDC Practice
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "DownloadManager.h"

@interface DownloadManager ()

@property (strong, nonatomic) dispatch_queue_t download_q;

@end

@implementation DownloadManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static DownloadManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[DownloadManager alloc]init];
    });
    return instance;
}

- (dispatch_queue_t)download_q {
    if(!_download_q) {
        _download_q = dispatch_queue_create("com.ironhack.process.donwload", DISPATCH_QUEUE_SERIAL);
    }
    return _download_q;
}

- (void)downloadImageAtURL:(NSString *)url completion:(DownloadImageCompletionBlock)completion {
    dispatch_async(self.download_q, ^{
        UIImage *image = [self donwloadImage:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);
        });
    });
}

- (UIImage *)donwloadImage:(NSString *)urlString {
    NSURL *url  =[NSURL URLWithString:urlString];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:imageData];
}

@end
