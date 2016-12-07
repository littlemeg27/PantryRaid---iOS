//
//  ApplicationState.h
//  PantryRaid
//
//  Created by Brenna Pavlinchak on 12/4/16.
//  Copyright © 2016 Brenna Pavlinchak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationState : NSObject
{
    NSMutableArray *businessArray;
}

@property (strong)NSMutableArray *grocreyStoreArray;

+(ApplicationState*)sharedApplicationState;

@end
