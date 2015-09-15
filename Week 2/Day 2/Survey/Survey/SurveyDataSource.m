//
//  SurveyDataSource.m
//  Survey
//
//  Created by Toni on 15/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "SurveyDataSource.h"

@implementation SurveyDataSource

- (NSDictionary *)fetchSurvey {
    return @{@"preguntas":@[
                     @{@"pregunta" : @"cual es tu comida favorita?", @"respuestas":@[@"paella", @"tortilla", @"hamburguesa"]},
                     @{@"pregunta" : @"cual es tu cerveza favorita?", @"respuestas":@[@"mahou", @"estrella de galicia", @"heineken"]},
                     @{@"pregunta" : @"que postura usas para dormir?",@"respuestas": @[@"boca arriba", @"boca abajo", @"de lado"]},
                     @{@"pregunta" : @"donde te gustaria ir de vacaciones?", @"respuestas": @[@"Nueva York", @"Bora bora", @"Australia"]}
                     ]
             };
}

- (NSString *)titleForQuestion:(NSUInteger)index {
    
    NSArray *question = [[self fetchSurvey] objectForKey:@"preguntas"];
    
    return [question[index] objectForKey:@"pregunta"];
}

- (NSArray *)optionsforQuestion:(NSUInteger)index {
    NSArray *question = [[self fetchSurvey] objectForKey:@"preguntas"];
    
    return [question[index] objectForKey:@"respuestas"];
}

- (BOOL)isLastQuestion:(NSUInteger)index {
    return index > [self.fetchSurvey count] + 1;
}

@end
