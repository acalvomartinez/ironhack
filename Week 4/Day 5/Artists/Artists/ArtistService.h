//
//  ArtistService.h
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtistService : NSObject

- (void)artistsWithCompletion:(void (^)(NSArray *))completion;

@end
