#import "_GeoIP.h"

@interface GeoIP : _GeoIP {}
// Custom logic goes here.

+ (instancetype)geoIPWithCountry:(NSString *)country
                              ip:(NSString *)ip
                        latitude:(NSNumber*)latitude
                       longitude:(NSNumber *)longitude
                       inContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *)fetchRequestWithFields:(NSArray<NSString *> *)fields
                                 andOrders:(NSArray<NSNumber *> *)orders
                        andDistinctResults:(BOOL)distinct;

@end
