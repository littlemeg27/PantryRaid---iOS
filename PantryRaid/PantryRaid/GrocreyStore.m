//
//  GrocreyStore.m
//  PantryRaid
//
//  Created by Brenna Pavlinchak on 12/4/16.
//  Copyright © 2016 Brenna Pavlinchak. All rights reserved.
//

#import "GrocreyStore.h"

@implementation GrocreyStore

@synthesize nameOfCompany, grocreyStoreAddress, grocreyStoreState, grocreyStoreCity, grocreyStoreZipcode, grocreyStorePhoneNumber, longitudeOfBusiness, latitudeOfBusiness;

-(id)initWithNameName:(NSString*)name company:(NSString*)company address:(NSString*)address city:(NSString*)city state:(NSString*)state  zipcode:(NSString*)zipcode phoneNumber:(NSString*)phoneNumber longitude:(float)longitude latitude:(float)latitude;
{
    if((self = [super init]))
    {
        nameOfCompany = [company copy];
        grocreyStoreAddress = [address copy];
        grocreyStoreState = [state copy];
        grocreyStoreCity = [city copy];
        grocreyStoreZipcode = [zipcode copy];
        grocreyStorePhoneNumber = [phoneNumber copy];
        longitudeOfBusiness = longitude;
        latitudeOfBusiness = latitude;
    }
    return self;
}
@end
