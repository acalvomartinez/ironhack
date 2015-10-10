//
//  FakeRadarGenerator.m
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "FakeRadarGenerator.h"

#import <CoreDataKit/NSManagedObjectContext+ACMInsertManagedObject.h>
#import "NSString+Random.h"

#import "Radar.h"

@interface FakeRadarGenerator ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation FakeRadarGenerator

- (void)genarateRadarsInContext:(NSManagedObjectContext *)context {
    self.context = context;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[Radar description]];
    
    NSError *error;
    NSUInteger radarCount = [[context executeFetchRequest:request error:&error] count];
    
    if (!error && radarCount > 0) {
        return;
    }
    
    for (NSUInteger i = 0; i < 50; i++) {
        [self insertExampleRadarWithTitle:[NSString randomTitleGenerator:40] user:[NSString randomEmailGenerator]];
    }
    
    error = nil;
    [self.context save:&error];
    
    if (error) {
        NSLog(@"Error: %@",error);
    }
}

- (Radar *)insertExampleRadarWithTitle:(NSString *)title user:(NSString *)user {
    Radar *sut = (Radar *)[self.context insertNewObjectForEntityForName:[Radar description]];
    sut.title = title;
    sut.user = user;
    return sut;
}

@end
