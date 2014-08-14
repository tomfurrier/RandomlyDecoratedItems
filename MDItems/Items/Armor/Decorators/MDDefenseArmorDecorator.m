//
//  MDDefenseArmorDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDDefenseArmorDecorator.h"

@interface MDDefenseArmorDecorator ()

@property(nonatomic) int extraDefense;

@end

@implementation MDDefenseArmorDecorator

-(instancetype)initWithArmor:(MDArmor *)armor {
    if (self = [super initWithArmor:armor]) {
        self.extraDefense = [self randomFromMin:1 max:4];
    }
    return self;
}

#pragma mark - UI

-(NSMutableArray *)modifierDescriptions {
    NSMutableArray *descriptions = [NSMutableArray arrayWithArray:[self.armor modifierDescriptions]];
    [descriptions  addObject:[NSString stringWithFormat:@"+%d defense", self.extraDefense]];
    return descriptions;
}

-(NSString *)namePrefix {
    if (!self.suffixBeingUsed) {
        self.prefixBeingUsed = YES;
        return @"Solid";
    } else {
        return [super namePrefix];
    }
}

-(NSString *)nameSuffix {
    if (!self.prefixBeingUsed) {
        self.suffixBeingUsed = YES;
        return @"of Stone";
    } else {
        return [super nameSuffix];
    }
}

#pragma mark - Modifiers

-(int)defense {
    return self.extraDefense + [super defense];
}

-(int)sellingPrice {
    return (self.extraDefense * 2) + [super sellingPrice];
}

@end
