// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Radar.h instead.

#import <CoreData/CoreData.h>

extern const struct RadarAttributes {
	__unsafe_unretained NSString *product;
	__unsafe_unretained NSString *productVersion;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *user;
} RadarAttributes;

@interface RadarID : NSManagedObjectID {}
@end

@interface _Radar : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RadarID* objectID;

@property (nonatomic, strong) NSString* product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* productVersion;

//- (BOOL)validateProductVersion:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _Radar (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveProduct;
- (void)setPrimitiveProduct:(NSString*)value;

- (NSString*)primitiveProductVersion;
- (void)setPrimitiveProductVersion:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSString*)primitiveUser;
- (void)setPrimitiveUser:(NSString*)value;

@end
