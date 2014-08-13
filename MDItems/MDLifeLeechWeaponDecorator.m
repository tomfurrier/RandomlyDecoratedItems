//
//  MDLifeLeechWeaponDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 8/5/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDLifeLeechWeaponDecorator.h"
#import "NSObject+Random.h"
#import "MDBattleMessage.h"

@interface MDLifeLeechWeaponDecorator ()

@property(nonatomic) int percentLifeStolenOnHit;

@end

@implementation MDLifeLeechWeaponDecorator

-(id)initWithWeapon:(MDWeapon *)weapon {
    if (self = [super initWithWeapon:weapon]) {
        self.percentLifeStolenOnHit = [self randomFromMin:10 max:15];
    }
    return self;
}

#pragma mark - UI

-(NSMutableArray *)modifierDescriptions {
    NSMutableArray *descriptions = [NSMutableArray arrayWithArray:[self.weapon modifierDescriptions]];
    [descriptions  addObject:[NSString stringWithFormat:@"Heal %d%% of damage dealt", self.percentLifeStolenOnHit]];
    return descriptions;
}

-(NSString *)namePrefix {
    if (!self.suffixBeingUsed) {
        self.prefixBeingUsed = YES;
        return @"Fanged";
    } else {
        return [super namePrefix];
    }
}

-(NSString *)nameSuffix {
    if (!self.prefixBeingUsed) {
        self.suffixBeingUsed = YES;
        return @"of Fangs";
    } else {
        return [super nameSuffix];
    }
}

#pragma mark - Modifiers

-(void)player:(MDPlayer *)player didHitEnemy:(MDEnemy *)enemy forDamage:(int)damage messageLog:(NSMutableArray *)messageLog {
    
    int damageToHeal = roundf(damage * (self.percentLifeStolenOnHit * .01));
    player.currentHealth += damageToHeal;
    
    MDBattleMessage *message = [MDBattleMessage messageWithMessage:[NSString stringWithFormat:@"Stole %d health!", damageToHeal]
                                             describesPlayerAction:YES];
    [messageLog insertObject:message
                     atIndex:0];
    
    [super player:player didHitEnemy:enemy forDamage:damage messageLog:messageLog];
}

@end
