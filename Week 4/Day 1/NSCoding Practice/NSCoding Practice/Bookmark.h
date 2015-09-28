//
//  Bookmark.h
//  NSCoding Practice
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Mantle/Mantle.h>

@interface Bookmark : MTLModel

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *name;

@end
