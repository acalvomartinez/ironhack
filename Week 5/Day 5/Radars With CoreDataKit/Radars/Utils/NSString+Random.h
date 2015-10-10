//
//  NSString+Random.h
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Random)

+ (NSString *)randomTitleGenerator:(NSInteger)characterLength;
+ (NSString *)randomEmailGenerator;

@end
