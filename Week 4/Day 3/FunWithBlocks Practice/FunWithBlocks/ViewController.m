//
//  ViewController.m
//  FunWithBlocks
//
//  Created by Joan Romano on 9/29/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "ViewController.h"

typedef void (^ImageCompletionBlock)(UIImage*);
typedef void (^TransformImageCompletionBlock)();

@interface ViewController ()

@property (nonatomic, strong) UIImageView *wallpaperView;
@property (nonatomic, copy) NSArray *wallpapers;
@property (nonatomic) NSInteger lastWallpaperIndex;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.wallpaperView = [[UIImageView alloc] initWithImage:nil];
    self.wallpaperView.frame = self.view.bounds;
    self.wallpaperView.contentMode = UIViewContentModeCenter;
    
    [self.view addSubview:self.wallpaperView];
    
    self.wallpapers = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"6.jpg", @"7.jpg"];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadWallpaper)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    
    [self loadWallpaper];
}

- (NSInteger)lastWallpaperIndex {
    if (!_lastWallpaperIndex) {
        _lastWallpaperIndex = 0;
    }
    return _lastWallpaperIndex;
}

- (void)loadWallpaper
{
    [UIView animateWithDuration:0.5 animations:^{
        self.wallpaperView.alpha = 0;
        [self fetchImageWithIndex:self.lastWallpaperIndex completionBlock:^(UIImage * wallpaperImage) {
            self.wallpaperView.image = wallpaperImage;
            [UIView animateWithDuration:0.5 animations:^{
                self.wallpaperView.alpha = 1;
            }];
            [self bounceImage];
            self.lastWallpaperIndex = (self.lastWallpaperIndex + 1) % [self.wallpapers count];
        }];
    }];
    
    

}


- (void)fetchImageWithIndex:(NSUInteger)index completionBlock:(ImageCompletionBlock)completion {
    
    UIImage *wallpaperImage = [UIImage imageNamed:self.wallpapers[index]];
    
    [self scaleImage:wallpaperImage width:320 completionBlock:completion];
    
}

- (void)scaleImage:(UIImage *)image width:(CGFloat)width completionBlock:(ImageCompletionBlock)completion {
    
    CGFloat ratio = width / image.size.width;
    
    CGSize size = CGSizeMake(width, image.size.height * ratio);
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    completion(scaledImage);
}

- (void)bounceImage {
    CGFloat durantion = 0.1f;
    
    [self animateTransformImageWithDuration:durantion
                                  transform:CGAffineTransformMakeScale(1.1, 1.1)
                                 completion:^() {
                                    [self animateTransformImageWithDuration:durantion
                                                                   transform:CGAffineTransformMakeScale(0.9, 0.9)
                                                                  completion:^() {
                                                                      [self animateTransformImageWithDuration:durantion
                                                                                                    transform:CGAffineTransformMakeScale(1, 1)
                                                                                                   completion:nil];
                                                                  }];
                                 }];
}

- (void)animateTransformImageWithDuration:(CGFloat)duration
                                transform:(CGAffineTransform)transform
                               completion:(TransformImageCompletionBlock)completionBlock {
    
    [UIView animateWithDuration:duration animations:^{
        self.wallpaperView.transform = transform;
    } completion:^(BOOL finished) {
        if (completionBlock) {
            completionBlock();
        }
        
    }];
}

@end
