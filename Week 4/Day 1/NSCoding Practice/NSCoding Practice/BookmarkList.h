//
//  BookmarkList.h
//  NSCoding Practice
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookmarkList : NSObject

@property (nonatomic, strong, readonly) NSArray *bookmarks;

- (void)addBookmarkWithName:(NSString *)name url:(NSString *)url;

@end
