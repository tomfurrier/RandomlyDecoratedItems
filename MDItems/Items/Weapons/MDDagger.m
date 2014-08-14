//
//  MDDagger.m
//  MDItems
//
//  Created by Dickman, Mike on 8/5/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDDagger.h"

@implementation MDDagger

-(instancetype)init {
    if (self = [super init]) {
        self.imageName = @"dagger";
        self.baseName = @"Dagger";
        self.minDamage = 2;
        self.maxDamage = 6;
        self.sellingPrice = 3;
    }
    return self;
}

@end
