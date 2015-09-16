//
//  ViewController.m
//  PageViewController
//
//  Created by Toni on 16/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *imagesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
}

- (void)setupScrollView {
    UIImage *image1 = [UIImage imageNamed:@"chewacca"];
    UIImage *image2 = [UIImage imageNamed:@"darthvader"];
    UIImage *image3 = [UIImage imageNamed:@"hansolo"];
    
    self.imagesArray = @[image1, image2, image3];
    
    CGFloat xOffset = 0;
    for (UIImage *image in self.imagesArray) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake(xOffset, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        imageView.clipsToBounds = YES;
        [self.scrollView addSubview:imageView];
        
        xOffset += self.scrollView.frame.size.width;
    }
    
    self.scrollView.contentSize = CGSizeMake(xOffset, self.view.frame.size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
