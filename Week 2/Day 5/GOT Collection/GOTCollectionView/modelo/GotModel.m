//
//  GotModel.m
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "GotModel.h"
#import "House.h"
#import "Character.h"

@implementation GotModel

- (void)loadModel;
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"personajes" ofType:@"json"];
    
    NSError* localError;
    NSData* JSONData = [NSData dataWithContentsOfFile:filePath options:0 error:&localError];
    if(JSONData && !localError)
        [self generateCharacters:JSONData];
    else {
        NSLog(@"Error loading JSON");
    }
}

- (void)generateCharacters:(NSData *)jsonData
{
    NSParameterAssert(jsonData);
    
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options: 0 error: &localError];
    NSDictionary *parsedObject = (id)jsonObject;
    
    if (parsedObject == nil) {
        NSLog(@"Error parsing JSON");
        return;
    }
    
    NSArray *houses = [parsedObject objectForKey:@"houses"];
    if(houses == nil) {
        NSLog(@"Error parsing JSON. No tag 'houses'");
        return;
    }
    
    NSMutableArray *charactersAux = [[NSMutableArray alloc] init];
    NSMutableSet *charactersSet = [[NSMutableSet alloc] init];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSDictionary *houseDict in houses) {
        
        House *house = [[House alloc] init];
        house.name = [houseDict valueForKey:@"name"];
        house.motto = [houseDict valueForKey:@"theme"];
        house.image = [houseDict valueForKey:@"image"];
        
        NSArray *characters = [houseDict valueForKey:@"people"];
        for (NSDictionary *characterDict in characters) {
            Character *character = [[Character alloc] init];
            character.name = [characterDict valueForKey:@"name"];
            character.characterDescription = [characterDict valueForKey:@"description"];
            character.image = [characterDict valueForKey:@"image"];
            [house addCharacter:character];
            
            if(![charactersSet containsObject:character.image]) {
                [charactersSet addObject:character.image];
                [charactersAux addObject:character];
            }
        }
        
        [results addObject:house];
    }
    
    self.characters = charactersAux.copy;
    self.houses = results.copy;
}

@end
