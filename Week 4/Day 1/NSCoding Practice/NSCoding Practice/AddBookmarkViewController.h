//
//  AddBookmarkViewController.h
//  NSCoding Practice
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddBookmarkDelegate <NSObject>

- (void)addBookmarkViewController:(id)viewController
           didSaveBookmarkWithURL:(NSString *)url
                             name:(NSString *)name;

@end

@interface AddBookmarkViewController : UIViewController

@property (nonatomic, weak) id<AddBookmarkDelegate> delegate;

@end
