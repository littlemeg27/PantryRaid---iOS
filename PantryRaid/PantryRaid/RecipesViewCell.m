//
//  RecipesViewCell.m
//  PantryRaid
//
//  Created by Brenna Pavlinchak on 11/20/16.
//  Copyright © 2016 Brenna Pavlinchak. All rights reserved.
//

#import "RecipesViewCell.h"

@implementation RecipesViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
