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
#import "NSArray+RandomItem.h"

@interface ShowProvider ()

@property (nonatomic, strong) NSMutableArray *movieList;
@property (nonatomic, strong) NSMutableArray *tvShowList;
@property (nonatomic, copy) NSString *moviesFilePath;
@property (nonatomic, copy) NSString *tvShowsFilePath;

@end

@implementation ShowProvider

- (instancetype)init {
    if (self = [super init]) {
        _moviesFilePath = [self moviesDataFilePath];
        _tvShowsFilePath = [self tvShowsDataFilePath];
    }
    return  self;
}

- (NSArray *)movies {
    return [self.movieList copy];
}

- (NSArray *)tvShows {
    return [self.tvShowList copy];
}

- (NSString *)moviesDataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"movies.dat"];
}

- (NSString *)tvShowsDataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"tvshows.dat"];
}


- (NSMutableArray *)generateRandomMovies:(NSUInteger)total {
    
    NSMutableArray *movies = [NSMutableArray arrayWithCapacity:total];
    
    for (NSUInteger i = 0; i < total; i++) {
        Movie *randomMovie = [[Movie alloc]init];
        randomMovie.movieId = [NSString mm_randomString];
        randomMovie.movieDescription = [NSString mm_randomString];
        randomMovie.title = [NSString mm_randomString];
        randomMovie.rating = 0;
        
        [movies addObject:randomMovie];
    }
    
    return movies;
}

- (NSMutableArray *)generateRandomTVShows:(NSUInteger)total {
    
    NSMutableArray *tvShows = [NSMutableArray arrayWithCapacity:total];
    
    for (NSUInteger i = 0; i < total; i++) {
        TVShow *randomTVShow = [[TVShow alloc]init];
        randomTVShow.tvShowId = [NSString mm_randomString];
        randomTVShow.tvShowDescription = [NSString mm_randomString];
        randomTVShow.title = [NSString mm_randomString];
        randomTVShow.rating = 0;
        
        [tvShows addObject:randomTVShow];
        
    }
    
    return tvShows;

}

- (void)duplicateRandomMovie {
    Movie *movie = [self.movieList randomItem];
    
    [self.movieList addObject:[movie copy]];
}

- (void)duplicateRandomTVShow {
    TVShow *tvShow = [self.tvShowList randomItem];
    
    [self.tvShowList addObject:[tvShow copy]];
}

- (void)addTVShow {
    TVShow *tvShow = [[TVShow alloc]init];
    tvShow.tvShowId = [NSString mm_randomString];
    tvShow.tvShowDescription = [NSString mm_randomString];
    tvShow.title = [NSString mm_randomString];
    tvShow.rating = 0;
    
    [self.tvShowList addObject:tvShow];
}

- (void)addMovie {
    Movie *movie = [[Movie alloc]init];
    movie.movieId = [NSString mm_randomString];
    movie.movieDescription = [NSString mm_randomString];
    movie.title = [NSString mm_randomString];
    movie.rating = 0;
    
    [self.movieList addObject:movie];
}

- (NSUInteger)countMovieOccurrences:(Movie *)movie {
    NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:self.movies];
    
    return [countedSet countForObject:movie];
    
}

- (NSUInteger)countTVShowOccurrences:(TVShow *)tvShow {
    NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:self.tvShows];
    
    return [countedSet countForObject:tvShow];
}

- (void)saveTVShows {
    [NSKeyedArchiver archiveRootObject:self.tvShowList toFile:self.tvShowsFilePath];
}

- (void)saveMovies {
    [NSKeyedArchiver archiveRootObject:self.movieList toFile:self.moviesFilePath];
}

- (NSMutableArray *)movieList {
    if (!_movieList) {
         _movieList = [NSKeyedUnarchiver unarchiveObjectWithFile:self.moviesFilePath];
        
        if (!_movieList)
        {
            _movieList = [self generateRandomMovies:5];
        }
        
    }
    return _movieList;
}

- (NSMutableArray *)tvShowList {
    if (!_tvShowList) {
        _tvShowList = [NSKeyedUnarchiver unarchiveObjectWithFile:self.tvShowsFilePath];
        
        if (!_tvShowList) {
           _tvShowList = [self generateRandomTVShows:5];
        }
        
    }
    return _tvShowList;
}

- (void)loadShowsFromRemote {
    NSDictionary *JSONDictionary = [self showsJSONDictionaryFromRemote];
    
    NSArray *showsJSON =[JSONDictionary valueForKey:@"shows"];
    NSError *parseError;
    self.tvShowList = [[MTLJSONAdapter modelsOfClass:[TVShow class] fromJSONArray:showsJSON error:&parseError] mutableCopy];
}

- (NSDictionary *)showsJSONDictionaryFromRemote
{
    NSURL *jsonURL = [NSURL URLWithString:@"https://ironhack4thweek.s3.amazonaws.com/shows.json"];
    NSData *seriesData = [NSData dataWithContentsOfURL:jsonURL];
    NSError *error;
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:seriesData options:NSJSONReadingMutableContainers error:&error];
    
    return JSONDictionary;
}


@end
