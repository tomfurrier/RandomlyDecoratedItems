//
//  MDHammer.m
//  MDItems
//
//  Created by Dickman, Mike on 8/5/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDHammer.h"

@implementation MDHammer

-(instancetype)init {
    if (self = [super init]) {
        self.imageName = @"hammer";
        self.baseName = @"Hammer";
        self.minDamage = 4;
        self.maxDamage = 14;
        self.sellingPrice = 5;
    }
    return self;
}

@end
