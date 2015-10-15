//
//  Memes.h
//  MemeRastreator
//
//  Created by Toni on 15/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Collection.h"

@class Meme;

@interface Memes : NSObject <Collection>

- (instancetype)initWithPlistFilename:(NSString *)filename;

- (NSArray <Meme *> *)allElements;
- (void)addElement:(Meme *)element;
- (void)removeElement:(Meme *)element;

- (Meme *)randomElement;

@end
