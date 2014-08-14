//
//  MDGloves.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDGloves.h"

@implementation MDGloves

-(instancetype)init {
    if (self = [super init]) {
        self.imageName = @"gloves";
        self.baseName = @"Gloves";
        self.defense = 3;
        self.sellingPrice = 4;
        self.armorType = armorTypeHands;
    }
    return self;
}

@end
