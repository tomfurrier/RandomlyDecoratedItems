//
//  MDBoots.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDBoots.h"

@implementation MDBoots

-(instancetype)init {
    if (self = [super init]) {
        self.imageName = @"boots";
        self.baseName = @"Boots";
        self.defense = 3;
        self.sellingPrice = 4;
        self.armorType = armorTypeFeet;
    }
    return self;
}

@end
