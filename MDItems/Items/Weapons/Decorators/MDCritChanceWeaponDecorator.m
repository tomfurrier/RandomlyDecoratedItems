//
//  MDCritChanceWeaponDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 7/29/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDCritChanceWeaponDecorator.h"

@interface MDCritChanceWeaponDecorator ()

@property(nonatomic) int critChanceBonus;

@end

@implementation MDCritChanceWeaponDecorator

-(instancetype)initWithWeapon:(MDWeapon *)weapon {
    if (self = [super initWithWeapon:weapon]) {
        self.critChanceBonus = [self randomFromMin:5 max:10];
    }
    return self;
}

#pragma mark - UI

-(NSMutableArray *)modifierDescriptions {
    NSMutableArray *descriptions = [NSMutableArray arrayWithArray:[self.weapon modifierDescriptions]];
    [descriptions  addObject:[NSString stringWithFormat:@"+%d%% chance of critical hits", self.critChanceBonus]];
    return descriptions;
}

-(NSString *)namePrefix {
    if (!self.suffixBeingUsed) {
        self.prefixBeingUsed = YES;
        return @"Precise";
    } else {
        return [super namePrefix];
    }
}

-(NSString *)nameSuffix {
    if (!self.prefixBeingUsed) {
        self.suffixBeingUsed = YES;
        return @"of Precision";
    } else {
        return [super nameSuffix];
    }
}

#pragma mark - Modifiers

-(int)critChance {
    return self.critChanceBonus + self.weapon.critChance;
}

-(int)sellingPrice {
    return self.critChanceBonus + [super sellingPrice];
}

@end
