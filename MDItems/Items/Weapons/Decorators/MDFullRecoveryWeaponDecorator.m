//
//  MDFullRecoveryWeaponDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 8/5/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDFullRecoveryWeaponDecorator.h"
#import "MDBattleMessage.h"

@interface MDFullRecoveryWeaponDecorator ()

@property(nonatomic) int chanceForFullRecoveryOnEnemyDefeated;

@end

@implementation MDFullRecoveryWeaponDecorator

-(instancetype)initWithWeapon:(MDWeapon *)weapon {
    if (self = [super initWithWeapon:weapon]) {
        self.chanceForFullRecoveryOnEnemyDefeated = [self randomFromMin:1 max:5];
    }
    return self;
}

#pragma mark - UI

-(NSMutableArray *)modifierDescriptions {
    NSMutableArray *descriptions = [NSMutableArray arrayWithArray:[self.weapon modifierDescriptions]];
    [descriptions  addObject:[NSString stringWithFormat:@"%d%% chance to fully heal on victory", self.chanceForFullRecoveryOnEnemyDefeated]];
    return descriptions;
}

-(NSString *)namePrefix {
    if (!self.suffixBeingUsed) {
        self.prefixBeingUsed = YES;
        return @"Miracle";
    } else {
        return [super namePrefix];
    }
}

-(NSString *)nameSuffix {
    if (!self.prefixBeingUsed) {
        self.suffixBeingUsed = YES;
        return @"of Miracles";
    } else {
        return [super nameSuffix];
    }
}

#pragma mark - Modifiers

-(void)player:(MDPlayer *)player didDefeatEnemy:(MDEnemy *)enemy messageLog:(NSMutableArray *)messageLog {
    if ((arc4random() % 100) < self.chanceForFullRecoveryOnEnemyDefeated) {
        player.currentHealth = player.maxHealth;
        
        MDBattleMessage *message = [MDBattleMessage messageWithMessage:@"Full heal triggered!" describesPlayerAction:YES];
        [messageLog insertObject:message
                         atIndex:0];
    }
    
    [super player:player didDefeatEnemy:enemy messageLog:messageLog];
}

-(int)sellingPrice {
    return (self.chanceForFullRecoveryOnEnemyDefeated * 2) + [super sellingPrice];
}

@end
