//
//  TVShows.h
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreGraphics;

@interface TVShow : NSObject <NSCoding,NSCopying>

@property (nonatomic, copy) NSString *tvShowId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *tvShowDescription;
@property (nonatomic, assign) CGFloat rating;

- (BOOL)isEqualToTVShow:(TVShow *)other;
           
@end
