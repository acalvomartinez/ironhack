//
//  Movie.h
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Mantle/Mantle.h>

@import CoreGraphics;

@interface Movie : MTLModel

@property (nonatomic, copy) NSString *movieId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *movieDescription;
@property (nonatomic, assign) CGFloat rating;

@end
