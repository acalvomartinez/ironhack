//
//  ViewController.m
//  CommentBox
//
//  Created by Gorka Magaña on 24/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCommentBoxConstraint;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *gangnamStyleImageView;
@property (weak, nonatomic) IBOutlet UIView *commentBoxView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // Gangnam Style guy
    NSMutableArray *images = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 16; i++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"win_%lu", i]]];
    }
    self.gangnamStyleImageView.animationImages = images;
    self.gangnamStyleImageView.animationDuration = 1;
    [self.gangnamStyleImageView startAnimating];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat bottomDistance = self.view.bounds.size.height - endFrame.origin.y;
    
    self.bottomCommentBoxConstraint.constant = bottomDistance;
    
    [self.view layoutIfNeeded];
}


- (IBAction)sendButtonPressed:(id)sender {
    [self.textField resignFirstResponder];
}

@end
