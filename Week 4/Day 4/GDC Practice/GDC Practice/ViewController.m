//
//  ViewController.m
//  GDC Practice
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

//http://img.lum.dolimg.com/v1/images/Darth-Vader_6bda9114.jpeg
//http://images.esellerpro.com/2486/I/356/6/magnet-star-wars-darth-vader.jpg
//http://images1.wikia.nocookie.net/__cb20111108044044/swcp/es/images/e/e8/VaderFather.jpg
//http://i1.cdnds.net/14/05/618x402/darth-vader.jpg

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@property (strong, nonatomic) dispatch_queue_t download_q;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self presentImage:@"http://img.lum.dolimg.com/v1/images/Darth-Vader_6bda9114.jpeg" intoImageView:self.imageView1];
    [self presentImage:@"http://thestarwarstrilogy.com/StarWars/wallpaper/Original-Trilogy-Darth-Vader/Original%20Trilogy%20-%20Darth%20Vader%2005.jpg" intoImageView:self.imageView2];
    [self presentImage:@"http://images1.wikia.nocookie.net/__cb20111108044044/swcp/es/images/e/e8/VaderFather.jpg" intoImageView:self.imageView3];
    [self presentImage:@"http://i1.cdnds.net/14/05/618x402/darth-vader.jpg" intoImageView:self.imageView4];
    
}

- (dispatch_queue_t)download_q {
    if(!_download_q) {
        _download_q = dispatch_queue_create(@"com.ironhack.process.donwload", DISPATCH_QUEUE_SERIAL);
    }
    return _download_q;
}

- (void)presentImage:(NSString *)urlString intoImageView:(UIImageView *)imageView {
    dispatch_async(self.download_q, ^{
        UIImage *image = [self donwloadImage:urlString];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
    
}

- (UIImage *)donwloadImage:(NSString *)urlString {
    NSURL *url  =[NSURL URLWithString:urlString];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:imageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
