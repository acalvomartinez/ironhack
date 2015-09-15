//
//  SurveyDataSource.h
//  Survey
//
//  Created by Toni on 15/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyDataSource : NSObject

- (NSDictionary *)fetchSurvey;
- (NSString *)titleForQuestion:(NSUInteger)index;
- (NSArray *)optionsforQuestion:(NSUInteger)index;
- (BOOL)isLastQuestion:(NSUInteger)index;

@end
