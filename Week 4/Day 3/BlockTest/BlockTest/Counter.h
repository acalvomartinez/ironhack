//
//  Counter.h
//  BlockTest
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Counter : NSObject

- (void)countTo10000:(id)object selector:(SEL)selector;

- (void)countTo10000WithCompletion:(void (^)(BOOL))completion;
@end
