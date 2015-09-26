//
//  ImagePreviewViewController.h
//  GestureRecognizers
//
//  Created by Gorka Magaña on 25/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePreviewViewController : UIViewController
@property (nonatomic, weak, readonly) UIImageView *imageView;
@property (nonatomic, strong) UIImage *fullSizedImage;
@end
