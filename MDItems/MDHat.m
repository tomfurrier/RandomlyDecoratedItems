//
//  MDHat.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDHat.h"

@implementation MDHat

-(instancetype)init {
    if (self = [super init]) {
        self.imageName = @"hat";
        self.baseName = @"Hat";
        self.defense = 2;
        self.sellingPrice = 4;
        self.armorType = armorTypeHead;
    }
    return self;
}

@end
