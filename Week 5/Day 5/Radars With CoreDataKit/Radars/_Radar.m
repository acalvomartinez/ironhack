// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Radar.m instead.

#import "_Radar.h"

const struct RadarAttributes RadarAttributes = {
	.product = @"product",
	.productVersion = @"productVersion",
	.title = @"title",
	.user = @"user",
};

@implementation RadarID
@end

@implementation _Radar

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Radar" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Radar";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Radar" inManagedObjectContext:moc_];
}

- (RadarID*)objectID {
	return (RadarID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic product;

@dynamic productVersion;

@dynamic title;

@dynamic user;

@end

