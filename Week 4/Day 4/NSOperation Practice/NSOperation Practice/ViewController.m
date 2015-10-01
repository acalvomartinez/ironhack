//
//  ViewController.m
//  NSOperation Practice
//
//  Created by Toni on 01/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

#import "DownloadImageOperation.h"
#import "FileAttributesOperation.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) NSOperationQueue *operationQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cancelButton.enabled = NO;
}


- (IBAction)cancelButtonPressed:(id)sender {
    [self.operationQueue cancelAllOperations];
}

- (IBAction)goButtonPressed:(id)sender {
    
    self.goButton.enabled = NO;
    self.cancelButton.enabled = YES;
    
    FileAttributesOperation *fileAttributesOperation = [[FileAttributesOperation alloc] initWithPath:@"/" completion:^(NSDictionary *attributes) {
        NSLog(@"%@",attributes);
    }];
    
    DownloadImageOperation *downloadImageOperation = [[DownloadImageOperation alloc]initWithURLString:@"http://thestarwarstrilogy.com/StarWars/wallpaper/Original-Trilogy-Darth-Vader/Original%20Trilogy%20-%20Darth%20Vader%2005.jpg" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    
    [downloadImageOperation setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.goButton.enabled = YES;
            self.cancelButton.enabled = NO;
        });
    }];
    
    [downloadImageOperation addDependency:fileAttributesOperation];
    
    [self.operationQueue addOperation:fileAttributesOperation];
    [self.operationQueue addOperation:downloadImageOperation];
}

- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc]init];
    }
    return _operationQueue;
}

@end
