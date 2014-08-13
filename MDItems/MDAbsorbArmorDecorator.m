//
//  MDAbsorbArmorDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDAbsorbArmorDecorator.h"

@interface MDAbsorbArmorDecorator ()

@property(nonatomic) int extraPercentDamageAbsorbed;

@end

@implementation MDAbsorbArmorDecorator

-(instancetype)initWithArmor:(MDArmor *)armor {
    if (self = [super initWithArmor:armor]) {
        self.extraPercentDamageAbsorbed = arc4random() % 40 + 10;
    }
    return self;
}

#pragma mark - UI

-(NSMutableArray *)modifierDescriptions {
    NSMutableArray *descriptions = [NSMutableArray arrayWithArray:[self.armor modifierDescriptions]];
    [descriptions  addObject:[NSString stringWithFormat:@"Absorbs %d%% damage", self.extraPercentDamageAbsorbed]];
    return descriptions;
}

-(NSString *)namePrefix {
    if (!self.suffixBeingUsed) {
        self.prefixBeingUsed = YES;
        return @"Vital";
    } else {
        return [super namePrefix];
    }
}

-(NSString *)nameSuffix {
    if (!self.prefixBeingUsed) {
        self.suffixBeingUsed = YES;
        return @"of Vitality";
    } else {
        return [super nameSuffix];
    }
}

#pragma mark - Modifiers

-(int)percentDamageAbsorbed {
    return self.extraPercentDamageAbsorbed + [super percentDamageAbsorbed];
}

-(int)sellingPrice {
    return (self.extraPercentDamageAbsorbed * .1) + [super sellingPrice];

}

@end
