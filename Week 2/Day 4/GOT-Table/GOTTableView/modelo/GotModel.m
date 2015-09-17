//
//  GotModel.m
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "GotModel.h"
#import "Casa.h"
#import "Personaje.h"

@implementation GotModel

- (void) cargaModelo
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"personajes" ofType:@"json"];
   
    NSError* localError;
    NSData* JSONData = [NSData dataWithContentsOfFile:filePath options:0 error:&localError];
    if(JSONData && !localError)
        [self generaPersonajes:JSONData];
    else {
        NSLog(@"Error cargando JSON");
    }
}

- (void) generaPersonajes:(NSData*) jsonData
{
    NSParameterAssert(jsonData);
    
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options: 0 error: &localError];
    NSDictionary *parsedObject = (id)jsonObject;
    
    if (parsedObject == nil) {
        NSLog(@"Error parseando JSON");
        return;
    }
    
    NSArray* casas = [parsedObject objectForKey:@"houses"];
    if(casas==nil) {
        NSLog(@"Error parseando JSON. No hay tag 'houses'");
        return;
    }
    
    NSMutableArray* personajesAux = [[NSMutableArray alloc] init];
    NSMutableSet* personajesSet = [[NSMutableSet alloc] init];
    NSMutableArray* results = [[NSMutableArray alloc] init];
    for (NSDictionary* casaDict in casas) {
        
        Casa* casa = [[Casa alloc] init];
        casa.nombre = [casaDict valueForKey:@"name"];
        casa.lema = [casaDict valueForKey:@"theme"];
        casa.imagen = [casaDict valueForKey:@"image"];
        
        NSArray* personajes = [casaDict valueForKey:@"people"];
        for (NSDictionary* personajeDict in personajes) {
            Personaje* personaje = [[Personaje alloc] init];
            personaje.nombre = [personajeDict valueForKey:@"name"];
            personaje.descripcion = [personajeDict valueForKey:@"description"];
            personaje.imagen = [personajeDict valueForKey:@"image"];
            [casa addPersonaje:personaje];
            
            if(![personajesSet containsObject:personaje.imagen]) {
                [personajesSet addObject:personaje.imagen];
                [personajesAux addObject:personaje];
            }
        }
        
        [results addObject:casa];
    }
    
    self.personajes = personajesAux.copy;
    self.casas = results.copy;
}

- (void)removeCharacterAtIndexPath:(NSIndexPath *)indexPath {
    
    Casa *house = [self.casas objectAtIndex:indexPath.section];
    
    //Personaje *character = [house.personajes objectAtIndex:indexPath.row];
    
    //[house removePersonaje:character];
    [house removePersonajeAtIndex:indexPath.row];

}

- (void)removeCharacter:(Personaje *)characterToDelete {
    
    for (Casa *house in self.casas) {
        for (Personaje *character in house.personajes) {
            if ([character.nombre isEqualToString:characterToDelete.nombre]) {
                [house removePersonaje:characterToDelete];
            }
        }
    }
    
}

- (void)moveCharacterAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    Casa *sourceHouse = [self.casas objectAtIndex:fromIndexPath.section];
    Personaje *sourceCharacter = [sourceHouse.personajes objectAtIndex:fromIndexPath.row];
    
    Casa *destinationHouse = [self.casas objectAtIndex:toIndexPath.section];
    
    if (fromIndexPath.section == toIndexPath.section) {
        Personaje *sourceCopy = [self copyCharacter:sourceCharacter];
        
        NSUInteger destinationIndex;
        if (fromIndexPath.row < toIndexPath.row) {
            destinationIndex = toIndexPath.row + 1;
        } else {
            destinationIndex = toIndexPath.row;
        }
        
        [self insertCharacter:sourceCopy inHouse:destinationHouse atIndex:destinationIndex];
    } else {
        [self insertCharacter:sourceCharacter inHouse:destinationHouse atIndex:toIndexPath.row];
        
    }
    
    [sourceHouse removePersonaje:sourceCharacter];
}

- (Personaje *)copyCharacter:(Personaje *)character {
    Personaje *copyCharacter = [[Personaje alloc] init];
    
    copyCharacter.nombre = character.nombre;
    copyCharacter.imagen = character.imagen;
    copyCharacter.descripcion = character.descripcion;
    
    return copyCharacter;
    
}

- (void)replaceCharacterAtIndex:(NSUInteger)index withPersonaje:(Personaje *)personaje atHouse:(Casa *)house {
    NSMutableArray *characters = [house.personajes mutableCopy];
    [characters replaceObjectAtIndex:index withObject:personaje];
    house.personajes = [characters mutableCopy];
}

- (void)insertCharacter:(Personaje *)character inHouse:(Casa *)house atIndex:(NSUInteger)index {
    NSMutableArray *characters = [house.personajes mutableCopy];
    [characters insertObject:character atIndex:index];
    house.personajes = [characters mutableCopy];
}


@end
