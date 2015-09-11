//
//  Beer.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "Beer.h"

@implementation Beer

+ (instancetype)beerWithName:(NSString *)aName
                       color:(NSString *)aColor
                       grade:(NSUInteger)aGrade {
    return [[self alloc] initWithName:aName
                                color:aColor
                                grade:aGrade];
}

- (instancetype)initWithName:(NSString *)aName
                       color:(NSString *)aColor
                       grade:(NSUInteger)aGrade {
    if (self = [super init]) {
        self.name = aName;
        self.color = aColor;
        self.grade = aGrade;
    }
    
    return self;
}

-(NSString *)name {
    return self->name;
}
-(void)setName:(NSString *)aName {
    self->name = aName;
}

-(NSString *)color {
    return self->color;
}

-(void)setColor:(NSString *)aColor {
    self->color = aColor;
}

-(NSUInteger)grade {
    return self->grade;
}
-(void)setGrade:(NSUInteger)aGrade {
    self->grade = aGrade;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Name: %@\nColor: %@\nGrade: %lu℃",self.name, self.color, self.grade];
}


@end
