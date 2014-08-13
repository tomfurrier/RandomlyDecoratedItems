//
//  MDDeathArmorDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDDeathArmorDecorator.h"
#import "MDBattleMessage.h"

@interface MDDeathArmorDecorator ()

@property(nonatomic) int chanceOfDeath;

@end

@implementation MDDeathArmorDecorator

-(instancetype)initWithArmor:(MDArmor *)armor {
    if (self = [super initWithArmor:armor]) {
        self.chanceOfDeath = arc4random() % 3 + 1;
    }
    return self;
}

#pragma mark - UI

-(NSMutableArray *)modifierDescriptions {
    NSMutableArray *descriptions = [NSMutableArray arrayWithArray:[self.armor modifierDescriptions]];
    [descriptions  addObject:[NSString stringWithFormat:@"When hit, %d%% chance to kill enemy", self.chanceOfDeath]];
    return descriptions;
}

-(NSString *)namePrefix {
    if (!self.suffixBeingUsed) {
        self.prefixBeingUsed = YES;
        return @"Reaping";
    } else {
        return [super namePrefix];
    }
}

-(NSString *)nameSuffix {
    if (!self.prefixBeingUsed) {
        self.suffixBeingUsed = YES;
        return @"of Reaping";
    } else {
        return [super nameSuffix];
    }
}

#pragma mark - Modifiers

-(void)enemy:(MDEnemy *)enemy didHitPlayer:(MDPlayer *)player forDamage:(int)damage messageLog:(NSMutableArray *)messageLog {

    if (arc4random() % 100 < self.chanceOfDeath) {
        enemy.currentHealth = 0;
        NSString *message = [NSString stringWithFormat:@"Death has found %@...", enemy.name];
        [messageLog insertObject:[MDBattleMessage messageWithMessage:message
                                               describesPlayerAction:YES]
                         atIndex:0];
    }
}

-(int)sellingPrice {
    return (self.chanceOfDeath * 2) + [super sellingPrice];
}

@end
