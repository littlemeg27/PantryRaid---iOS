//
//  Recipe.h
//  PantryRaid
//
//  Created by Brenna Pavlinchak on 11/29/16.
//  Copyright © 2016 Brenna Pavlinchak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

    @property (strong, nonatomic) NSString *name;
    @property (strong, nonatomic) NSString *description;
    @property (strong, nonatomic) NSString *who;
    @property (strong, nonatomic) NSString *country;
    @property (strong, nonatomic) NSString *city;

@end
