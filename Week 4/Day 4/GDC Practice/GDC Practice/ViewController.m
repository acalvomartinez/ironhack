//
//  ViewController.m
//  GDC Practice
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

#import "ImageManager.h"

//http://img.lum.dolimg.com/v1/images/Darth-Vader_6bda9114.jpeg
//http://images.esellerpro.com/2486/I/356/6/magnet-star-wars-darth-vader.jpg
//http://images1.wikia.nocookie.net/__cb20111108044044/swcp/es/images/e/e8/VaderFather.jpg
//http://i1.cdnds.net/14/05/618x402/darth-vader.jpg

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    
//    [[ImageManager sharedInstance] downloadImageAtURL:@"http://img.lum.dolimg.com/v1/images/Darth-Vader_6bda9114.jpeg" completion:^(UIImage *image) {
//        self.imageView1.image = image;
//    }];
//    
//    [[ImageManager sharedInstance] downloadImageAtURL:@"http://thestarwarstrilogy.com/StarWars/wallpaper/Original-Trilogy-Darth-Vader/Original%20Trilogy%20-%20Darth%20Vader%2005.jpg" completion:^(UIImage *image) {
//        self.imageView2.image = image;
//    }];
//    
//    [[ImageManager sharedInstance] downloadImageAtURL:@"http://images1.wikia.nocookie.net/__cb20111108044044/swcp/es/images/e/e8/VaderFather.jpg" completion:^(UIImage *image) {
//        self.imageView3.image = image;
//    }];
//    
//    [[ImageManager sharedInstance] downloadImageAtURL:@"http://i1.cdnds.net/14/05/618x402/darth-vader.jpg" completion:^(UIImage *image) {
//        self.imageView4.image = image;
//    }];
    
    [self test];
}

- (void)test {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        [self performSelector:@selector(log) withObject:self afterDelay:2.0];
    });
}

- (void)log {
    NSLog(@"Hello World!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
