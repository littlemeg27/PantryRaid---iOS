//
//  GrocreyStore.h
//  PantryRaid
//
//  Created by Brenna Pavlinchak on 12/4/16.
//  Copyright © 2016 Brenna Pavlinchak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrocreyStore : NSObject
{
    NSString *nameOfCompany;
    NSString *grocreyStoreAddress;
    NSString *grocreyStoreState;
    NSString *grocreyStoreCity;
    NSString *grocreyStoreZipcode;
    NSString *grocreyStorePhoneNumber;
    float longitudeOfBusiness;
    float latitudeOfBusiness;
}

-(id)initWithNameName:(NSString*)name company:(NSString*)company address:(NSString*)address city:(NSString*)city state:(NSString*)state  zipcode:(NSString*)zipcode phoneNumber:(NSString*)phoneNumber longitude:(float)longitude latitude:(float)latitude;

@property (nonatomic, strong)NSString *nameOfCompany;
@property (nonatomic, strong)NSString *grocreyStoreAddress;
@property (nonatomic, strong)NSString *grocreyStoreState;
@property (nonatomic, strong)NSString *grocreyStoreCity;
@property (nonatomic, strong)NSString *grocreyStoreZipcode;
@property (nonatomic, strong)NSString *grocreyStorePhoneNumber;
@property (nonatomic, assign)float longitudeOfBusiness;
@property (nonatomic, assign)float latitudeOfBusiness;

@end
