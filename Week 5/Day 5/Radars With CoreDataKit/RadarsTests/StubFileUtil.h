//
//  StubFileUtil.h
//  Radars
//
//  Created by Toni on 07/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StubFileUtil : NSObject

+ (NSString *)loadJSONStubFileNamed:(NSString *)stubFilename;

@end
