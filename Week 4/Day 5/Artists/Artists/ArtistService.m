//
//  ArtistService.m
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ArtistService.h"

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
            }];
        }
    });
}

- (dispatch_queue_t)service_q {
    if (!_service_q) {
        _service_q = dispatch_queue_create("com.ironhack.artists.service", DISPATCH_QUEUE_SERIAL);
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

- (void)fetchDataFromRemoteOnCompletion:(void (^)(NSArray *))completion {
    NSURL *url = [NSURL URLWithString:kArtistJSONURL];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [urlSession dataTaskWithURL:url
                                           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                               NSError *parseError;
                                               NSArray *JSONArray = [NSJSONSerialization JSONObjectWithData:data
                                                                                                    options:kNilOptions
                                                                                                      error:&parseError];
                                               
                                               NSArray *artists = [self artistsFromJSONArray:JSONArray];
                                               
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   if (completion) {
                                                       completion(artists);
                                                   }
                                               });
                                           }];
    
    [task resume];
}



#pragma mark - Serializiation

- (NSArray *)artistsFromJSONArray:(NSArray *)JSONArray {
    
    NSMutableSet *artists = [NSMutableSet new];
    
    for (NSDictionary *dictionary in JSONArray) {
        
        NSURL *imageURL = [NSURL URLWithString:dictionary[@"image_url"]];
        NSDate *startDate = [NSDate dateWithString:dictionary[@"start_day"]];
        NSUInteger artistId = [dictionary[@"id"] integerValue];
        
        Artist *artist = [Artist artistWithName:dictionary[@"name"]
                                longDescription:dictionary[@"description"]
                                          stage:dictionary[@"stage"]
                                       imageURL:imageURL
                                      startDate:startDate
                                       artistId:artistId];
        [artists addObject:artist];
    }
    
    return [artists allObjects];
    
}

@end
