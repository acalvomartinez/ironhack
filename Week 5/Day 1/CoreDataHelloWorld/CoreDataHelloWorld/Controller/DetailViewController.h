//
//  DetailViewController.h
//  CoreDataHelloWorld
//
//  Created by Toni on 05/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

