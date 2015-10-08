//
//  EditRadarViewController.m
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "EditRadarViewController.h"
#import "Radar.h"

@interface EditRadarViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextView;
@property (weak, nonatomic) IBOutlet UITextField *userTextView;
@end

@implementation EditRadarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.radar) {
        self.titleTextView.text = self.radar.title;
        self.userTextView.text = self.radar.user;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.radar.title = self.titleTextView.text;
    self.radar.user = self.userTextView.text;
    
    NSManagedObjectContext *context = self.radar.managedObjectContext;
    
    NSError *error;
    [context save:&error];
    if (error) {
        NSLog(@"%@",error);
        self.radar.user = @"error@error.com";
        [context save:&error];
    }
}


@end
