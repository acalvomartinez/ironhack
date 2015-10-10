//
//  StubFileUtil.m
//  Radars
//
//  Created by Toni on 07/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "StubFileUtil.h"

@implementation StubFileUtil

+ (NSString *)loadJSONStubFileNamed:(NSString *)stubFilename {
    NSBundle *bundle = [NSBundle bundleForClass:self];
    NSString *filePath = [bundle pathForResource:stubFilename ofType:@"json"];
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:filePath] encoding:NSUTF8StringEncoding];
}



@end
