//
//  Memes.m
//  MemeRastreator
//
//  Created by Toni on 15/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "Memes.h"

#import "Meme.h"

@interface Memes ()
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation Memes

- (instancetype)initWithPlistFilename:(NSString *)filename {
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
        NSArray *memeURLs = [NSArray arrayWithContentsOfFile:path];
        
        for (NSString *urlString in memeURLs) {
            Meme *m = [[Meme alloc] init];
            m.url = urlString;
    
            [self addElement:m];
        }
    }
    return self;
}


- (NSMutableArray *)list {
    if (_list == nil) {
        _list = [[NSMutableArray alloc] init];
    }
    return _list;
}

- (NSArray <Meme *> *)allElements {
    return self.list;
}

- (NSUInteger)count {
    return self.list.count;
}

- (void)addElement:(Meme *)element {
    return [self.list addObject:element];
}

- (void)removeElement:(Meme *)element {
    return [self.list removeObject:element];
}

- (Meme *)randomElement {
    if ([self count] == 0) {
        return nil;
    }
    
    NSUInteger randomIndex = arc4random() % [self count];
    
    return [self.list objectAtIndex:randomIndex];
}

@end
