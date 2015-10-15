//
//  Collection.h
//  MemeRastreator
//
//  Created by Toni on 15/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Collection <NSObject>
@required
- (void)addElement:(id)element;
- (NSUInteger)count;
- (NSArray <id>*)allElements;
- (void)removeElement:(id)element;

@optional
- (id)randomElement;

@end
