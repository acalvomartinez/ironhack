//
//  Radar.m
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "Radar.h"

#import "NSManagedObjectContext+ACMInsertManagedObject.h"

@implementation Radar

// Insert code here to add functionality to your managed object subclass

+ (Radar *)radarWithUser:(NSString *)user andTitle:(NSString *)title inContext:(NSManagedObjectContext *)context {
    Radar *radar = (Radar *)[context insertNewObjectForEntityForName:[Radar description]];
    radar.user = user;
    radar.title = title;
    
    return radar;
}


@end
