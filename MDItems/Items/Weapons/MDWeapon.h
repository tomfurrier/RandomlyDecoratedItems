//
//  MDWeapon.h
//  ItemsDecoratorPattern
//
//  Created by Dickman, Mike on 7/24/14.
//  Copyright (c) 2014 Quicken Loans. All rights reserved.
//

#import "MDItem.h"
#import "MDPlayer.h"
#import "MDEnemy.h"

@interface MDWeapon : MDItem

@property(nonatomic) int minDamage, maxDamage, critChance, critPercentBonusDamage;

// Events
-(void)player:(MDPlayer*)player willHitEnemy:(MDEnemy*)enemy messageLog:(NSMutableArray*)messageLog;
-(void)player:(MDPlayer*)player didHitEnemy:(MDEnemy *)enemy forDamage:(int)damage messageLog:(NSMutableArray*)messageLog;
-(void)player:(MDPlayer*)player didDefeatEnemy:(MDEnemy *)enemy messageLog:(NSMutableArray*)messageLog;

@end
