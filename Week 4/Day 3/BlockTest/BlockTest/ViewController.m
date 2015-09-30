//
//  ViewController.m
//  BlockTest
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"
#import "Counter.h"

typedef NSInteger(^SumBlock)(NSInteger, NSInteger);
typedef void(^SumBlock2)(NSInteger, NSInteger);

@interface ViewController ()

@property (nonatomic, copy) SumBlock mySumBlock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Counter *counter = [[Counter alloc]init];
    
    //[counter countTo10000:self selector:@selector(selectorAfterCount)];
    [counter countTo10000WithCompletion:^(BOOL completed) {
        
        if (completed) {
             NSLog(@"Count Ended");
        }
       
    }];
    
    
}

- (void)selectorAfterCount {
    NSLog(@"End counter");
}

- (void)blockTest {
    
    SumBlock sumBlock = ^(NSInteger number1, NSInteger number2) {
        return number1 + number2;
    };
    
    NSLog(@"%ld", (long)sumBlock(40,2));
    
    self.mySumBlock = sumBlock;
    
    SumBlock2 sumBlock2 = ^(NSInteger number1, NSInteger number2) {
        NSLog(@"%d",number1-number2);
    };
    
    [self applyBlock:sumBlock2];
}

- (void)applyBlock:(SumBlock2)block {
    block(1,2);
}

@end
