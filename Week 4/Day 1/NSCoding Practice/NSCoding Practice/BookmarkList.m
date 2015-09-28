//
//  BookmarkList.m
//  NSCoding Practice
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "BookmarkList.h"
#import "Bookmark.h"

@interface BookmarkList ()

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, copy) NSString *path;
@end

@implementation BookmarkList

- (instancetype)init {
    if (self = [super init]) {
        _path = [self dataFilePath];
        _list = [self loadBookmarks];
    }
    return self;
}

- (NSArray *)bookmarks {
    return [self.list copy];
}

- (void)addBookmarkWithName:(NSString *)name url:(NSString *)url {
    Bookmark *bookmark = [[Bookmark alloc]init];
    bookmark.url = url;
    bookmark.name = name;
    
    [self.list addObject:bookmark];
    [self saveBookmarksToDisk];
}

#pragma mark - File Data Management

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"bookmarks.dat"];
}


- (NSMutableArray *)loadBookmarks {
    
    NSArray *bookmarks = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
    
    if (!bookmarks) {
        bookmarks = [NSArray new];
    }
    
    return [bookmarks mutableCopy];
}

- (void)saveBookmarksToDisk {
    [NSKeyedArchiver archiveRootObject:self.bookmarks toFile:self.path];
}

@end
