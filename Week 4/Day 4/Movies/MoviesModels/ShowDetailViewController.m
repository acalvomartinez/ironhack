//
//  ShowDetailViewController.m
//  MoviesModels
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "CustomBarButtonItem.h"
#import "Show.h"

#import "UIAlertView+Block.h"
#import "UIImageView+Shows.h"

@interface ShowDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (strong, nonatomic) CustomBarButtonItem *likeBarButton;

@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.detailTextView.text = self.show.showDescription;
    [self.detailImageView setImageFromURL:self.show.posterURL completion:nil];
    
    self.likeBarButton = [[CustomBarButtonItem alloc]initWithTitle:@"Like" style:UIBarButtonItemStylePlain actionBlock:^{
        
        UIAlertView *alertView = [UIAlertView alertViewWithTitle:self.title message:@"Confirm?" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"OK"] onDismiss:^(NSInteger buttonIndex) {
            NSLog(@"Dismissed index %@", @(buttonIndex));
        } onCancel:^{
            NSLog(@"Canceled!");
        }];
        
        [alertView show];
    }];
    
    self.navigationItem.rightBarButtonItem = self.likeBarButton;
    
}



@end
