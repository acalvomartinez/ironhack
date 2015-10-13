//
//  CoreLocationHelper.h
//  MapKitHelloWorld
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CoreLocationHelper : NSObject

+ (BOOL)isLocationServiceAuthorizedByUser;

@end
