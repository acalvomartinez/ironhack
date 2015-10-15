//
//  ViewController.m
//  MemeRastreator
//
//  Created by Toni on 15/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

#import "Memes.h"
#import "Meme.h"
#import "BokehScene.h"
#import "CCColorCube.h"

@interface ViewController ()
@property (nonatomic, strong) Memes *memes;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet SKView *scene;
@property (strong, nonatomic) BokehScene *bs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.memes = [[Memes alloc] initWithPlistFilename:@"memes"];
    
    self.bs = [BokehScene sceneWithSize:self.scene.bounds.size];
    self.bs.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene presentScene:self.bs];
}

- (IBAction)newMemeButtonPressed:(id)sender {
    
    Meme *meme = [self.memes randomElement];
    
    [self donwloadMemeFromURL:meme.url];
}


- (void)donwloadMemeFromURL:(NSString *)urlString {
    
    NSLog(@"%@",urlString);
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        CCColorCube *colorCube = [[CCColorCube alloc] init];
        NSArray *imgColors = [colorCube extractColorsFromImage:image flags:(CCAvoidWhite | CCAvoidBlack) count:4];
        
        SKEmitterNode *emitter = (SKEmitterNode *)[self.bs childNodeWithName:@"particle"];
        //self.bs.backgroundColor = [imgColors lastObject];
        emitter.particleColor = [imgColors lastObject];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
             self.imageView.image = image;
         });
    }];
    
    
    [downloadTask resume];
    
}



@end
