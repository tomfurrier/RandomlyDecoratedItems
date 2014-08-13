//
//  MDClub.m
//  MDItems
//
//  Created by Dickman, Mike on 8/5/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDClub.h"

@implementation MDClub

-(instancetype)init {
    if (self = [super init]) {
        self.imageName = @"club";
        self.baseName = @"Club";
        self.minDamage = 1;
        self.maxDamage = 12;
        self.sellingPrice = 3;
    }
    return self;
}

@end
