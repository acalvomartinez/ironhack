//
//  ShowProvider.m
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ShowProvider.h"

#import "Movie.h"
#import "TVShow.h"

#import "NSString+Random.h"

@interface ShowProvider ()

@property (nonatomic, strong) NSMutableArray *movieList;
@property (nonatomic, strong) NSMutableArray *tvShowList;

@end

@implementation ShowProvider

- (instancetype)init {
    if (self = [super init]) {
        _movieList = [NSMutableArray new];
        _tvShowList = [NSMutableArray new];

    }
    return  self;
}

- (NSArray *)movies {
    return [self.movieList copy];
}

- (NSArray *)tvShows {
    return [self.tvShowList copy];
}

- (void)generateRandomMovies:(NSUInteger)total {
    for (NSUInteger i = 0; i < total; i++) {
        [self addRandomMovie];
    }
}

- (void)generateRandomTVShows:(NSUInteger)total {
    for (NSUInteger i = 0; i < total; i++) {
        [self addRandomTVShow];
    }

}

- (void)addRandomMovie {
    Movie *randomMovie = [[Movie alloc]init];
    randomMovie.movieId = [NSString mm_randomString];
    randomMovie.movieDescription = [NSString mm_randomString];
    randomMovie.title = [NSString mm_randomString];
    randomMovie.rating = 0;
    
    [self.movieList addObject:randomMovie];
}

- (void)addRandomTVShow {
    TVShow *randomTVShow = [[TVShow alloc]init];
    randomTVShow.tvShowId = [NSString mm_randomString];
    randomTVShow.tvShowDescription = [NSString mm_randomString];
    randomTVShow.title = [NSString mm_randomString];
    randomTVShow.rating = 0;
    
    [self.tvShowList addObject:randomTVShow];
}

@end
