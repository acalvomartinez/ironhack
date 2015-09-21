//
//  CustomView.h
//  SubclassingViewsPractice
//
//  Created by Toni on 21/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

@property (nonatomic, copy) NSString *title;

- (instancetype) initWithFrame:(CGRect)frame title:(NSString *)title NS_DESIGNATED_INITIALIZER;

@end
