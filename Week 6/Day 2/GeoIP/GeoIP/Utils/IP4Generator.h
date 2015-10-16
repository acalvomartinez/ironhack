//
//  IP4Generator.h
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IP4Generator : NSObject

+ (NSString *)generateRandomIP4;
+ (NSArray *)genareteIP4ArrayWithCapacity:(NSUInteger)capacity;

@end
