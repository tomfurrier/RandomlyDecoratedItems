//
//  MDArmor.h
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDItem.h"
#import "MDPlayer.h"
#import "MDEnemy.h"

typedef enum {
    armorTypeHead,
    armorTypeBody,
    armorTypeHands,
    armorTypeFeet
}ArmorType;

@interface MDArmor : MDItem

@property (nonatomic) ArmorType armorType;
@property(nonatomic) int defense, percentDamageReflected, percentDamageAbsorbed;

-(void)enemy:(MDEnemy*)enemy didKillPlayer:(MDPlayer*)player messageLog:(NSMutableArray*)messageLog;
-(void)enemy:(MDEnemy*)enemy didHitPlayer:(MDPlayer*)player forDamage:(int)damage messageLog:(NSMutableArray*)messageLog;

@end
