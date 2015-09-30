//
//  ShowProvider.h
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TVShow;
@class Movie;

@interface ShowProvider : NSObject

- (NSArray *)movies;
- (NSArray *)tvShows;

- (void)duplicateRandomMovie;
- (void)duplicateRandomTVShow;

- (void)addMovie;
- (void)addTVShow;

- (void)saveMovies;
- (void)saveTVShows;

- (NSUInteger)countMovieOccurrences:(Movie *)movie;
- (NSUInteger)countTVShowOccurrences:(TVShow *)tvShow;

- (void)loadShowsFromRemote;

@end
