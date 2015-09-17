//
//  DetailViewController.h
//  GOTTableView
//
//  Created by Toni on 17/09/15.
//  Copyright (c) 2015 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h> 
@class  Personaje;
@protocol DetailViewControllerDelgate <NSObject>
- (void) didPressedKillButton: (Personaje *) personaje;
@end

@interface DetailViewController : UIViewController

@property (nonatomic,strong) Personaje *character;
@property (nonatomic,weak) id<DetailViewControllerDelgate> delegate;
@end
