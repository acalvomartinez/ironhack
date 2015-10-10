//
//  FakeRadarGenerator.h
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@interface FakeRadarGenerator : NSObject

- (void)genarateRadarsInContext:(NSManagedObjectContext *)context;

@end
