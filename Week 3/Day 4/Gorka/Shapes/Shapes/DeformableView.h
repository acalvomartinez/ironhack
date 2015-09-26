//
//  DeformableView.h
//  Shapes
//
//  Created by Gorka Magaña on 24/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeformableView : UIView
@property (nonatomic) CGFloat xDisplacement;
- (void)setXDisplacement:(CGFloat)xDisplacement animated:(BOOL)animated;
@end
