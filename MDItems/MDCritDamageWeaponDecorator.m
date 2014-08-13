//
//  MDCritDamageWeaponDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 8/7/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDCritDamageWeaponDecorator.h"

@interface MDCritDamageWeaponDecorator ()

@property(nonatomic) int extraCritDamagePercentage;

@end

@implementation MDCritDamageWeaponDecorator

-(instancetype)initWithWeapon:(MDWeapon *)weapon {
    if (self = [super initWithWeapon:weapon]) {
        self.extraCritDamagePercentage = arc4random() % 50 + 25;
    }
    return self;
}

#pragma mark - UI

-(NSMutableArray *)modifierDescriptions {
    NSMutableArray *descriptions = [NSMutableArray arrayWithArray:[self.weapon modifierDescriptions]];
    [descriptions  addObject:[NSString stringWithFormat:@"+%d%% critical hit damage", self.extraCritDamagePercentage]];
    return descriptions;
}

-(NSString *)namePrefix {
    if (!self.suffixBeingUsed) {
        self.prefixBeingUsed = YES;
        return @"Beastly";
    } else {
        return [super namePrefix];
    }
}

-(NSString *)nameSuffix {
    if (!self.prefixBeingUsed) {
        self.suffixBeingUsed = YES;
        return @"of the Beast";
    } else {
        return [super nameSuffix];
    }
}

#pragma mark - Modifiers

-(int)critPercentBonusDamage {
    return self.extraCritDamagePercentage + self.weapon.critPercentBonusDamage;
}

@end