//
//  CustomBarButtonItem.h
//  MoviesModels
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(void);

@interface CustomBarButtonItem : UIBarButtonItem

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlock:(ActionBlock)actionBlock;

@end
