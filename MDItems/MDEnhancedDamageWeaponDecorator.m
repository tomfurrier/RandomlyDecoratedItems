//
//  MDEnhancedDamageWeaponDecorator.m
//  ItemsDecoratorPattern
//
//  Created by Dickman, Mike on 7/24/14.
//  Copyright (c) 2014 Quicken Loans. All rights reserved.
//

#import "MDEnhancedDamageWeaponDecorator.h"

@interface MDEnhancedDamageWeaponDecorator ()

@property(nonatomic) int extraDamage;

@end

@implementation MDEnhancedDamageWeaponDecorator

-(instancetype)initWithWeapon:(MDWeapon *)weapon {
    if (self = [super initWithWeapon:weapon]) {
        self.extraDamage = arc4random() % 5 + 2;
    }
    return self;
}

#pragma mark - UI

-(NSMutableArray *)modifierDescriptions {
    NSMutableArray *descriptions = [NSMutableArray arrayWithArray:[self.weapon modifierDescriptions]];
    [descriptions  addObject:[NSString stringWithFormat:@"+%d damage", self.extraDamage]];
    return descriptions;
}

-(NSString *)namePrefix {
    if (!self.suffixBeingUsed) {
        self.prefixBeingUsed = YES;
        return @"Mighty";
    } else {
        return [super namePrefix];
    }
}

-(NSString *)nameSuffix {
    if (!self.prefixBeingUsed) {
        self.suffixBeingUsed = YES;
        return @"of Might";
    } else {
        return [super nameSuffix];
    }
}

#pragma mark - Modifiers

-(int)minDamage {
    return self.extraDamage + [super minDamage];
}

-(int)maxDamage {
    return self.extraDamage + [super maxDamage];
}

-(int)sellingPrice {
    return self.extraDamage + [super sellingPrice];
}

@end
