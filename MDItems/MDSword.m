//
//  MDSword.m
//  ItemsDecoratorPattern
//
//  Created by Dickman, Mike on 7/24/14.
//  Copyright (c) 2014 Quicken Loans. All rights reserved.
//

#import "MDSword.h"

@implementation MDSword

-(instancetype)init {
    if (self = [super init]) {
        self.imageName = @"sword";
        self.baseName = @"Sword";
        self.minDamage = 5;
        self.maxDamage = 8;
        self.sellingPrice = 4;
    }
    return self;
}

@end
