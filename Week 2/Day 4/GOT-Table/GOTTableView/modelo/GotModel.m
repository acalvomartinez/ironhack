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
@end
