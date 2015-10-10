//
//  RadarJSON.h
//  Radars
//
//  Created by Toni on 08/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadarJSON : NSObject

@property (nonatomic, copy) NSString *classification;
@property (nonatomic, copy) NSString *radarDescription;
@property (nonatomic, assign) NSUInteger radarId;
@property (nonatomic, strong) NSDate *modified;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, strong) NSDate *originated;
@property (nonatomic, copy) NSString *parent;
@property (nonatomic, copy) NSString *product;
@property (nonatomic, copy) NSString *productVersion;
@property (nonatomic, copy) NSString *reproducible;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *resolved;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *user;

@end