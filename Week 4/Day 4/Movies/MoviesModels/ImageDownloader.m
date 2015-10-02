//
//  ImageDownloader.m
//  MoviesModels
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "ImageDownloader.h"

static NSString * const kCacheKeysFileName = @"keys.plist";
static NSString * const kCacheFolder = @"cacheFolder";


@import UIKit;

@interface ImageDownloader ()
@property (strong, nonatomic) dispatch_queue_t cache_q;
@property (strong, nonatomic) NSMutableDictionary *cacheKeys;
@property (copy, nonatomic) NSString *cacheFolderPath;
@end

@implementation ImageDownloader

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ImageDownloader *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ImageDownloader alloc]init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveKeys) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
    
}

- (void)saveKeys {
    NSString *cacheKeysPath = [self.cacheFolderPath stringByAppendingPathComponent:kCacheKeysFileName];
    [self.cacheKeys writeToFile:cacheKeysPath atomically:YES];
}

- (dispatch_queue_t)cache_q {
    if(!_cache_q) {
        _cache_q = dispatch_queue_create("com.ironhack.process.cache", DISPATCH_QUEUE_SERIAL);
    }
    return _cache_q;
}

- (void)downloadImageAtURL:(NSString *)url completion:(DownloadImageCompletionBlock)completion {
    
    dispatch_async(self.cache_q, ^{
        UIImage *image = [self imageFromCacheWithURL:url];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(image);
                }
            });
        } else {
            
            UIImage *imageDownloaded = [self donwloadImage:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (imageDownloaded) {
                    [self cacheImage:imageDownloaded withURL:url];
                }
                if (completion) {
                    completion(imageDownloaded);
                }
                
            });
        }
    });
}

- (UIImage *)donwloadImage:(NSString *)urlString {
    NSURL *url  =[NSURL URLWithString:urlString];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:imageData];
}


- (UIImage *)imageFromCacheWithURL:(NSString *)url {
    
    NSString *intervalDate = [self.cacheKeys objectForKey:url];
    
    if (!intervalDate) {
        return nil;
    }
    
    return [self cachedImageForIntervalDate:intervalDate];
}

- (UIImage *)cachedImageForIntervalDate:(NSString *)intervalDate {
    NSString *imagePath = [self.cacheFolderPath stringByAppendingPathComponent:intervalDate];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    return [UIImage imageWithData:imageData];
}

- (void)cacheImage:(UIImage *)image withURL:(NSString *)url {
    NSString *intervalDate = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    NSString *imageFilePath = [self.cacheFolderPath stringByAppendingPathComponent:intervalDate];
    
    [self.cacheKeys setObject:intervalDate forKey:url];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:imageFilePath atomically:YES];
    
}

- (NSDictionary *)cacheKeys {
    if (!_cacheKeys) {
        _cacheKeys = [self setupCacheKeysOnFailure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    return _cacheKeys;
}

- (NSString *)cacheFolderPath {
    if (!_cacheFolderPath) {
        _cacheFolderPath = [self setupCacheFolderOnFailure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    return _cacheFolderPath;
}

- (NSMutableDictionary *)setupCacheKeysOnFailure:(FailureFileManagerBlock)failure {
    
    NSString *cacheKeysPath = [self.cacheFolderPath stringByAppendingPathComponent:kCacheKeysFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:cacheKeysPath]) {
       
        return [NSMutableDictionary new];
    }
    
    NSDictionary *cacheKeysDictionary = [NSDictionary dictionaryWithContentsOfFile:cacheKeysPath];
    return [cacheKeysDictionary mutableCopy];
}

- (NSString *)setupCacheFolderOnFailure:(FailureFileManagerBlock)failure {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *cacheFolderPath = [[paths firstObject] stringByAppendingPathComponent:kCacheFolder];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:cacheFolderPath]) {
        NSError *error;
        
        [[NSFileManager defaultManager] createDirectoryAtPath:cacheFolderPath
                                  withIntermediateDirectories:NO attributes:@{} error:&error];
        
        if (error) {
            failure(error);
            return nil;
        }

    }

    return cacheFolderPath;
}


@end
