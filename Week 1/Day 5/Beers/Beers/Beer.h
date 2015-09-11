//
//  Beer.h
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beer : NSObject {
    NSString *name;
    NSString *color;
    NSUInteger grade;
}

+ (instancetype)beerWithName:(NSString *)name
                       color:(NSString *)color
                       grade:(NSUInteger)grade;

- (instancetype)initWithName:(NSString *)name
                       color:(NSString *)color
                       grade:(NSUInteger)grade;

-(NSString *)name;
-(void)setName:(NSString *)aName;

-(NSString *)color;
-(void)setColor:(NSString *)aColor;

-(NSUInteger)grade;
-(void)setGrade:(NSUInteger)aGrade;

@end
