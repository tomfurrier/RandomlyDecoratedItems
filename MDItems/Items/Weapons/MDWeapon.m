//
//  MDWeapon.m
//  ItemsDecoratorPattern
//
//  Created by Dickman, Mike on 7/24/14.
//  Copyright (c) 2014 Quicken Loans. All rights reserved.
//

#import "MDWeapon.h"

@implementation MDWeapon

-(id)init {
    if (self = [super init]) {
        self.critChance = 10; // Standard weapon critical hit chance is 10 / 100
        self.critPercentBonusDamage = 100; // Standard critical hit does 100% bonus damage
    }
    return self;
}

-(NSString *)statDescription {
    if (self.hasBeenIdentified) {
        return [NSString stringWithFormat:@"Damage: %d - %d", self.minDamage, self.maxDamage];
    } else {
        return @"Damage: ? - ?";
    }
    
}

-(void)player:(MDPlayer *)player willHitEnemy:(MDEnemy *)enemy messageLog:(NSMutableArray *)messageLog {
    
}

-(void)player:(MDPlayer *)player didHitEnemy:(MDEnemy *)enemy forDamage:(int)damage messageLog:(NSMutableArray *)messageLog {
    
}

-(void)player:(MDPlayer *)player didDefeatEnemy:(MDEnemy *)enemy messageLog:(NSMutableArray *)messageLog {
    
}

@end
