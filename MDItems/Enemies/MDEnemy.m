//
//  MDEnemy.m
//  MDItems
//
//  Created by Dickman, Mike on 7/23/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDEnemy.h"

@implementation MDEnemy

+(MDEnemy*)randomEnemy {
    switch (arc4random() % 3) {
        case 0:
            return [self slime];
            break;
        case 1:
            return [self goblin];
            break;
        case 2:
            return [self skeleton];
            break;
        default:
            return [self goblin];
            break;
    }
}

+(MDEnemy*)slime {
    
    MDEnemy *enemy = [[self alloc] init];
    enemy.name = @"Slime";
    enemy.imageName = @"slime";
    enemy.maxHealth = 40;
    enemy.currentHealth = enemy.maxHealth;
    enemy.minDamage = 10;
    enemy.maxDamage = 15;
    enemy.defense = 1;
    
    return enemy;
}

+(MDEnemy*)goblin {
    
    MDEnemy *enemy = [[self alloc] init];
    enemy.name = @"Goblin";
    enemy.imageName = @"goblin";
    enemy.maxHealth = 60;
    enemy.currentHealth = enemy.maxHealth;
    enemy.minDamage = 15;
    enemy.maxDamage = 20;
    enemy.defense = 1;
    
    return enemy;
}

+(MDEnemy*)skeleton {
    
    MDEnemy *enemy = [[self alloc] init];
    enemy.name = @"Skeleton";
    enemy.imageName = @"skeleton";
    enemy.maxHealth = 100;
    enemy.currentHealth = enemy.maxHealth;
    enemy.minDamage = 20;
    enemy.maxDamage = 30;
    enemy.defense = 2;
    
    return enemy;
}

-(void)setCurrentHealth:(int)currentHealth {
    
    _currentHealth = currentHealth;
    
    if (_currentHealth < 0) {
        _currentHealth = 0;
    }
}

@end
