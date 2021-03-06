//
//  ArtistService.m
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ArtistService.h"

#import "ArtistJSONParser.h"

#import "Artist.h"

#import "NSDate+Formatter.h"

static NSString * const kArtistJSONURL = @"https://ironhackartists.firebaseio.com/artists.json";
static NSString * const kFileNameArtistData = @"artist.dat";

@interface ArtistService ()

@property (nonatomic, copy) NSArray *artists;
@property (nonatomic, copy) NSString *artistsPath;
@property (nonatomic, strong) dispatch_queue_t service_q;

@end


@implementation ArtistService

- (void)artistsWithCompletion:(void (^)(NSArray *))completion {
    
    dispatch_async(self.service_q, ^{
        if ([self existsArtistsAtDisk]) {
            [self fetchArtistFromDiskOnCompletion:^(NSArray *artists) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(artists);
                    }
                });
            }];
        } else {
            [self fetchDataFromRemoteOnCompletion:^(NSArray *artists) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(artists);
                    }
                });
                [self saveArtistsToDisk:artists];
            } onError:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }
    });
}

- (void)toggleFavoriteForArtistWithId:(NSInteger)artistId completion:(void (^)(void))completion {
    dispatch_async(self.service_q, ^{
        [self fetchArtistFromDiskOnCompletion:^(NSArray *artists) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"artistId==%lu",artistId];
            Artist *artist = [[artists filteredArrayUsingPredicate:predicate] firstObject];
            artist.favorited = !artist.favorited;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion();
                }
            });
            [self saveArtistsToDisk:artists];
        }];
    });
}

- (dispatch_queue_t)service_q {
    if (!_service_q) {
        _service_q = dispatch_queue_create("com.ironhack.service.artists", DISPATCH_QUEUE_SERIAL);
    }
    return _service_q;
}

- (NSString *)artistsPath {
    if (!_artistsPath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _artistsPath = [[paths firstObject] stringByAppendingPathComponent:kFileNameArtistData];
    }
    return _artistsPath;
}



#pragma mark - Persistence

- (void)saveArtistsToDisk:(NSArray *)artists {
    [NSKeyedArchiver archiveRootObject:artists toFile:self.artistsPath];
}

- (NSString *)filenamePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filenamePath = [[paths firstObject] stringByAppendingPathComponent:kFileNameArtistData];
    
    return filenamePath;
}

- (BOOL)existsArtistsAtDisk {
    return [[NSFileManager defaultManager]fileExistsAtPath:self.artistsPath];
}

- (void)fetchArtistFromDiskOnCompletion:(void (^)(NSArray *))completion {
    NSArray *artists = [NSKeyedUnarchiver unarchiveObjectWithFile:self.artistsPath];
    if (completion) {
        completion(artists);
    }
}

- (void)fetchDataFromRemoteOnCompletion:(void (^)(NSArray *))completion onError:(void (^)(NSError *))errorBlock {
    NSURL *url = [NSURL URLWithString:kArtistJSONURL];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [urlSession dataTaskWithURL:url
                                           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                               
                                               NSError *parseError;
                                               NSArray *artists = [ArtistJSONParser artistsFromJSONData:data error:parseError];
                                               
                                               if (!artists) {
                                                   errorBlock (parseError);
                                                   return;
                                               }
                                               
                                               if (completion) {
                                                    completion(artists);
                                               }
                                           }];
    
    [task resume];
}





@end
