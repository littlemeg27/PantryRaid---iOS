//
//  ApplicationState.m
//  PantryRaid
//
//  Created by Brenna Pavlinchak on 12/4/16.
//  Copyright © 2016 Brenna Pavlinchak. All rights reserved.
//

#import "ApplicationState.h"
#import "GrocreyStore.h"

@implementation ApplicationState

static ApplicationState  *_sharedApplicationState = nil;

@synthesize grocreyStoreArray;

+(ApplicationState*)sharedApplicationState //We are creating the singleton for the application
{
    @synchronized([ApplicationState class])
    {
        if(!_sharedApplicationState) //Check to see if it is the applicationState so that we can create it for the first time
        {
            _sharedApplicationState = [[self alloc] init];
        }
        
        return _sharedApplicationState;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([ApplicationState class])
    {
        NSAssert(_sharedApplicationState == nil, @"You have already created a singleton, you do not need a second one!"); //Checking to see if we had already made a singleton
        _sharedApplicationState = [super alloc];
        return _sharedApplicationState;
    }
    
    return nil;
}

#pragma init/dealloc

-(id)init
{
    if((self = [super init]))
    {
        //Publix
        GrocreyStore *bradford = [[GrocreyStore alloc] initWithNameName:@"Bradford" company:@"Publix" address:@"1020 Bradford Plaza Way" city:@"Cary" state:@"North Carolina" zipcode:@"27519" phoneNumber:@"919-460-2082" longitude:-80.877224 latitude:35.082200];
        
        GrocreyStore *millpondVillage = [[GrocreyStore alloc] initWithNameName:@"Millpond Village" company:@"Publix" address:@"3480 Kildaire Farm Rd" city:@"Cary" state:@"North Carolina" zipcode:@"27518" phoneNumber:@"919-303-4024" longitude:-78.797187 latitude:35.705054];
        
        GrocreyStore *heritageVillage = [[GrocreyStore alloc] initWithNameName:@"The Shoppes at Heritage Village" company:@"Publix" address:@"1030 Forestville Rd" city:@"Wake Forest" state:@"North Carolina" zipcode:@"27587" phoneNumber:@"919-556-6671" longitude:-78.506742 latitude:35.944974];
        
        GrocreyStore *millerStreet = [[GrocreyStore alloc] initWithNameName:@"Miller Street" company:@"Publix" address:@"34 Miller St" city:@"Winston-Salem" state:@"North Carolina" zipcode:@"27104" phoneNumber:@"336-724-3707" longitude:-80.275676 latitude:36.094812];
        
        GrocreyStore *willowOaksCrossing = [[GrocreyStore alloc] initWithNameName:@"Willow Oaks Crossing" company:@"Publix" address:@"5015 Weddington Rd" city:@"Concord" state:@"North Carolina"  zipcode:@"28027" phoneNumber:@"704-795-7127" longitude:-80.661409 latitude:35.396294];
        
        GrocreyStore *mintHillCommons = [[GrocreyStore alloc] initWithNameName:@"Mint Hill Commons" company:@"Publix" address:@"6828 Matthews Mint Hill Rd" city:@"Mint Hill" state:@"North Carolina"  zipcode:@"28227" phoneNumber:@"704-573-0234" longitude:-80.659570 latitude:35.170932];
        
        GrocreyStore *prosperityVillageSquare = [[GrocreyStore alloc] initWithNameName:@"Prosperity Village Square" company:@"Publix" address:@"10110 Benfield Rd" city:@"Charlotte" state:@"North Carolina"  zipcode:@"28269" phoneNumber:@"704-992-6951" longitude:-80.787521 latitude:35.365350];
        
        GrocreyStore *marketSquare = [[GrocreyStore alloc] initWithNameName:@"Market Square" company:@"Publix" address:@"9815 Rose Commons Dr" city:@"Huntersville" state:@"North Carolina"  zipcode:@"28078" phoneNumber:@"704-948-4801" longitude:-80.864341 latitude:35.408543];
        
        GrocreyStore *brawleyCommons = [[GrocreyStore alloc] initWithNameName:@"Brawley Commons" company:@"Publix" address:@"631 Brawley School Rd" city:@"Mooresville" state:@"North Carolina"  zipcode:@"28117" phoneNumber:@"704-660-6800" longitude:-80.875942 latitude:35.581751];
        
        GrocreyStore *mcKeeFarms = [[GrocreyStore alloc] initWithNameName:@"McKee Farms" company:@"Publix" address:@"3110 Fincher Farm Rd" city:@"Matthews" state:@"North Carolina"  zipcode:@"28105" phoneNumber:@"704-814-6001" longitude:-80.730047 latitude:35.082282];
        
        GrocreyStore *magnoliaPlaza = [[GrocreyStore alloc] initWithNameName:@"Magnolia Plaza" company:@"Publix" address:@"8315 Magnolia Estates Dr" city:@"Cornlius" state:@"North Carolina"  zipcode:@"28031" phoneNumber:@"704-895-7057" longitude:-80.888828 latitude:35.475452];
        
        GrocreyStore *shopsAtSouthline = [[GrocreyStore alloc] initWithNameName:@"Shops at Southline" company:@"Publix" address:@"11222 Providence Rd W" city:@"Charlotte" state:@"North Carolina"  zipcode:@"28203" phoneNumber:@"704-373-2122" longitude:-80.862477 latitude:35.206689];
        
        GrocreyStore *ballantyneTownCenter = [[GrocreyStore alloc] initWithNameName:@"Ballantyne Town Center" company:@"Publix" address:@"2222 South Blvd" city:@"Charlotte" state:@"North Carolina"  zipcode:@"28277" phoneNumber:@"704-716-2344" longitude:-80.862477 latitude:35.206689];
        
        grocreyStoreArray = [[NSMutableArray alloc] initWithObjects: bradford, millpondVillage, heritageVillage, millerStreet, willowOaksCrossing, mintHillCommons, prosperityVillageSquare, marketSquare, brawleyCommons, mcKeeFarms, magnoliaPlaza, shopsAtSouthline, ballantyneTownCenter, nil];
    }
    
    return self;
}
@end
