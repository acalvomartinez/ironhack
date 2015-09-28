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

@property (nonatomic, strong) NSMutableSet *list;
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
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"url" ascending:YES];
    
    return [self.list sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (BOOL)addBookmarkWithName:(NSString *)name url:(NSString *)url {
    Bookmark *bookmark = [[Bookmark alloc]init];
    bookmark.url = url;
    bookmark.name = name;
    
    [self.list addObject:bookmark];
    [self saveBookmarksToDisk];
    
    return YES;
}

#pragma mark - File Data Management

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"bookmarks.dat"];
}


- (NSMutableSet *)loadBookmarks {
    
    NSMutableSet *bookmarks = [NSMutableSet setWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.path]];
    
    if (!bookmarks) {
        bookmarks = [NSMutableSet new];
    }
    
    return bookmarks;
}

- (void)saveBookmarksToDisk {
    [NSKeyedArchiver archiveRootObject:self.list toFile:self.path];
}

@end
