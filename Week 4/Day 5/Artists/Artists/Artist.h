//
//  Artist.h
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject <NSCopying, NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *longDescription;
@property (nonatomic, copy) NSString *stage;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSDate *startDate;

+ (instancetype)randomArtist;

+ (instancetype)artistWithName:(NSString *)name longDescription:(NSString *)longDescription stage:(NSString *)stage imageURL:(NSURL *)imageURL startDate:(NSDate *)startDate;

- (instancetype)initWithName:(NSString *)name longDescription:(NSString *)longDescription stage:(NSString *)stage imageURL:(NSURL *)imageURL startDate:(NSDate *)startDate;

@end
