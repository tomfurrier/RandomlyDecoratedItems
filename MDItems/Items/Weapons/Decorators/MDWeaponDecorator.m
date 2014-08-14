//
//  MDWeaponDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 7/24/14.
//  Copyright (c) 2014 Quicken Loans. All rights reserved.
//

#import "MDWeaponDecorator.h"

@implementation MDWeaponDecorator

-(instancetype)initWithWeapon:(MDWeapon *)weapon {
    if (self = [super init]) {
        self.weapon = weapon;
    }
    return self;
}

-(void)player:(MDPlayer *)player willHitEnemy:(MDEnemy *)enemy messageLog:(NSMutableArray *)messageLog {
    [self.weapon player:player willHitEnemy:enemy messageLog:messageLog];
}

-(void)player:(MDPlayer *)player didHitEnemy:(MDEnemy *)enemy forDamage:(int)damage messageLog:(NSMutableArray *)messageLog {
    [self.weapon player:player didHitEnemy:enemy forDamage:damage messageLog:messageLog];
}

-(void)player:(MDPlayer *)player didDefeatEnemy:(MDEnemy *)enemy messageLog:(NSMutableArray *)messageLog {
    [self.weapon player:player didDefeatEnemy:enemy messageLog:messageLog];
}

-(int)minDamage {
    return self.weapon.minDamage;
}

-(int)maxDamage {
    return self.weapon.maxDamage;
}

-(int)critChance {
    return self.weapon.critChance;
}

-(int)critPercentBonusDamage {
    return self.weapon.critPercentBonusDamage;
}

-(NSString *)namePrefix {
    return self.weapon.namePrefix;
}

-(NSString *)nameSuffix {
    return self.weapon.nameSuffix;
}

-(NSString *)imageName {
    return self.weapon.imageName;
}

-(NSString *)baseName {
    return self.weapon.baseName;
}

-(int)sellingPrice {
    return self.weapon.sellingPrice;
}

@end
