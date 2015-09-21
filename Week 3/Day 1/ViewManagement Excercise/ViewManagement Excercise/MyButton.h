//
//  MyButton.h
//  ViewManagement Excercise
//
//  Created by Toni on 21/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIView

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *color;

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                        color:(UIColor *)color NS_DESIGNATED_INITIALIZER;

@end
