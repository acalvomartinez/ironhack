//
//  UIImageView+Download.h
//  MoviesModels
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageCompletionBlock)(BOOL);

@interface UIImageView (Shows)

- (void)setImageFromURL:(NSString *)url completion:(ImageCompletionBlock)completion;

@end
