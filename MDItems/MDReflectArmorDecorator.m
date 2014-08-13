//
//  MDReflectArmorDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDReflectArmorDecorator.h"

@interface MDReflectArmorDecorator ()

@property(nonatomic) int extraPercentDamageReflected;

@end

@implementation MDReflectArmorDecorator

-(instancetype)initWithArmor:(MDArmor *)armor {
    if (self = [super initWithArmor:armor]) {
        self.extraPercentDamageReflected = arc4random() % 40 + 10;
    }
    return self;
}

#pragma mark - UI

-(NSMutableArray *)modifierDescriptions {
    NSMutableArray *descriptions = [NSMutableArray arrayWithArray:[self.armor modifierDescriptions]];
    [descriptions  addObject:[NSString stringWithFormat:@"Reflects %d%% damage", self.extraPercentDamageReflected]];
    return descriptions;
}

-(NSString *)namePrefix {
    if (!self.suffixBeingUsed) {
        self.prefixBeingUsed = YES;
        return @"Thorned";
    } else {
        return [super namePrefix];
    }
}

-(NSString *)nameSuffix {
    if (!self.prefixBeingUsed) {
        self.suffixBeingUsed = YES;
        return @"of Thorns";
    } else {
        return [super nameSuffix];
    }
}

#pragma mark - Modifiers

-(int)percentDamageReflected {
    return self.extraPercentDamageReflected + [super percentDamageReflected];
}

@end
