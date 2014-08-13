//
//  MDReviveArmorDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDReviveArmorDecorator.h"
#import "MDBattleMessage.h"

@interface MDReviveArmorDecorator ()

@property(nonatomic) int chanceOfReviveOnDeath;

@end

@implementation MDReviveArmorDecorator

-(instancetype)initWithArmor:(MDArmor *)armor {
    if (self = [super initWithArmor:armor]) {
        self.chanceOfReviveOnDeath = arc4random() % 15 + 1;
    }
    return self;
}

#pragma mark - UI

-(NSMutableArray *)modifierDescriptions {
    NSMutableArray *descriptions = [NSMutableArray arrayWithArray:[self.armor modifierDescriptions]];
    [descriptions  addObject:[NSString stringWithFormat:@"On death, %d%% chance to revive", self.chanceOfReviveOnDeath]];
    return descriptions;
}

-(NSString *)namePrefix {
    if (!self.suffixBeingUsed) {
        self.prefixBeingUsed = YES;
        return @"Angelic";
    } else {
        return [super namePrefix];
    }
}

-(NSString *)nameSuffix {
    if (!self.prefixBeingUsed) {
        self.suffixBeingUsed = YES;
        return @"of Angels";
    } else {
        return [super nameSuffix];
    }
}

#pragma mark - Modifiers

-(void)enemy:(MDEnemy *)enemy didKillPlayer:(MDPlayer *)player messageLog:(NSMutableArray *)messageLog {
    
    if (arc4random() % 100 < self.chanceOfReviveOnDeath) {
        player.currentHealth = player.maxHealth * .25;
        NSString *message = [NSString stringWithFormat:@"You've been revived!"];
        [messageLog insertObject:[MDBattleMessage messageWithMessage:message
                                               describesPlayerAction:YES]
                         atIndex:0];
    }
}

@end
