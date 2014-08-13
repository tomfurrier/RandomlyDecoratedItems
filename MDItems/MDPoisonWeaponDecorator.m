//
//  MDPoisonWeaponDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 7/29/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDPoisonWeaponDecorator.h"
#import "NSObject+Random.h"

@interface MDPoisonWeaponDecorator ()

@property(nonatomic) int poisonChance;

@end

@implementation MDPoisonWeaponDecorator

-(id)initWithWeapon:(MDWeapon *)weapon {
    if (self = [super initWithWeapon:weapon]) {
        self.poisonChance = [self randomFromMin:5 max:10];
    }
    
    return self;
}

#pragma mark - UI

-(NSMutableArray *)modifierDescriptions {
    NSMutableArray *descriptions = [NSMutableArray arrayWithArray:[self.weapon modifierDescriptions]];
    [descriptions  addObject:[NSString stringWithFormat:@"%d%% chance to poison on hit", self.poisonChance]];
    return descriptions;
}

-(NSString *)namePrefix {
    if (!self.suffixBeingUsed) {
        self.prefixBeingUsed = YES;
        return @"Plagued";
    } else {
        return [super namePrefix];
    }
}

-(NSString *)nameSuffix {
    if (!self.prefixBeingUsed) {
        self.suffixBeingUsed = YES;
        return @"of Plagues";
    } else {
        return [super nameSuffix];
    }
}

#pragma mark - Modifiers

-(void)player:(MDPlayer *)player didHitEnemy:(MDEnemy *)enemy forDamage:(int)damage messageLog:(NSMutableArray *)messageLog {
    
    if (arc4random() % 100 < self.poisonChance) {
        enemy.isPoisoned = YES;
    }
    
    [super player:player didHitEnemy:enemy forDamage:damage messageLog:messageLog];
}

@end
