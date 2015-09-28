//
//  ShowProvider.h
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowProvider : NSObject

- (NSArray *)movies;
- (NSArray *)tvShows;

- (void)duplicateRandomMovie;
- (void)duplicateRandomTVShow;

- (void)saveMovies;
- (void)saveTVShows;

@end
