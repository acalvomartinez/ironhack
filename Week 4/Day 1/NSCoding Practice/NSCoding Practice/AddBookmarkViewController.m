//
//  AddBookmarkViewController.m
//  NSCoding Practice
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "AddBookmarkViewController.h"


@interface AddBookmarkViewController ()

@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@end

@implementation AddBookmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)doneButtonPressed:(id)sender {
    NSString *url = self.urlTextField.text;
    NSString *name = self.nameTextField.text;
    
    if (url.length == 0 || name.length == 0) {
        return;
    }
    
    [self.delegate addBookmarkViewController:self didSaveBookmarkWithURL:url name:name];
}

@end
