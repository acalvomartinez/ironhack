//
//  ViewController.m
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

#import "Artist.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Artist *artistRandom = [Artist randomArtist];
    Artist *artistCopy  = [artistRandom copy];
    
    NSLog(@"artistRandom: %@ artistCopy %@", artistRandom, artistCopy);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
