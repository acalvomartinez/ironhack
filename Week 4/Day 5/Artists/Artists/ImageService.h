//
//  ImageService.h
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

@interface ImageService : NSObject

- (void)imageWithURL:(NSURL *)imageURL completion:(void (^)(UIImage *))completion;

@end
