//
//  Movie.h
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import <Mantle/MTLModel.h>

@interface Movie : MTLModel

@property (copy,nonatomic) NSString *movieId;
@property (copy,nonatomic) NSString *movieDescription;
@property (copy,nonatomic) NSString *movieTitle;
@property (nonatomic) CGFloat movieRating;

@end
