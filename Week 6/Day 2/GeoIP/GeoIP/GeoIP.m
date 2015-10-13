#import "GeoIP.h"

@interface GeoIP ()

// Private interface goes here.

@end

@implementation GeoIP

+ (instancetype)geoIPWithCountry:(NSString *)country
                              ip:(NSString *)ip
                        latitude:(NSNumber*)latitude
                       longitude:(NSNumber *)longitude
                       inContext:(NSManagedObjectContext *)context {
    
    GeoIP *geoIP = [[GeoIP alloc] initWithEntity:[GeoIP entityInManagedObjectContext:context]
                  insertIntoManagedObjectContext:context];
    
    
    geoIP.country = country;
    geoIP.ip = ip;
    geoIP.latitude = latitude;
    geoIP.longitude = longitude;
    
    return geoIP;
}

+ (NSFetchRequest *)fetchRequestWithFields:(NSArray<NSString *> *)fields
                                 andOrders:(NSArray<NSNumber *> *)orders
                        andDistinctResults:(BOOL)distinct {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:[GeoIP entityName]];
    [fetchRequest setFetchBatchSize:20];
    
    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithCapacity:fields.count];
    
    for (NSString *key in fields) {
        NSUInteger index = [fields indexOfObject:key];
        
        BOOL ascending = (orders.count > index) ? [[orders objectAtIndex:index] boolValue] : NO;
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
        
        [sortDescriptors addObject:sortDescriptor];
    }
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    fetchRequest.returnsDistinctResults = distinct;
    
    return fetchRequest;
}


@end
