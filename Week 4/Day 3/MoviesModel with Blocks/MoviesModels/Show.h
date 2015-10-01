
//
//  Show.h
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

@interface Show : MTLModel <MTLJSONSerializing>

@property (copy,nonatomic) NSString *showId;
@property (copy,nonatomic) NSString *showDescription;
@property (copy,nonatomic) NSString *showTitle;
@property (strong,nonatomic) NSURL *posterURL;
@property (nonatomic) CGFloat showRating;

@end
