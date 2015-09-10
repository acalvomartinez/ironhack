//
//  ViewController.h
//  MyFirstApp
//
//  Created by Toni on 08/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyProtocol <NSObject>

@property (strong, nonatomic) NSString *myProtocolProperty;

- (void)myProtocolFirstMethod;
- (void)myProtocolSecondMethod;

@end

@interface ViewController : UIViewController <MyProtocol, UIAlertViewDelegate>

@property (assign, nonatomic) BOOL doThingsExecuted;

- (void)doThings;


@end

