//
//  MDMessageTableViewCell.m
//  MDItems
//
//  Created by Dickman, Mike on 7/24/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDMessageTableViewCell.h"

@implementation MDMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
