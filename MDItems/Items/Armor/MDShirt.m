//
//  MDShirt.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDShirt.h"

@implementation MDShirt

-(instancetype)init {
    if (self = [super init]) {
        self.imageName = @"clothShirt";
        self.baseName = @"Cloth Shirt";
        self.defense = 5;
        self.sellingPrice = 4;
        self.armorType = armorTypeBody;
    }
    return self;
}

@end
