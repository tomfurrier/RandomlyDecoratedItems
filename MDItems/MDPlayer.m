//
//  MDPlayer.m
//  MDItems
//
//  Created by Dickman, Mike on 7/23/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDPlayer.h"
#import "MDSword.h"
#import "MDShirt.h"

@implementation MDPlayer

-(id)init {
    if (self = [super init]) {
        
        self.inventoryItems = [NSMutableArray array];
        self.maxHealth = 250;
        self.currentHealth = self.maxHealth;
        
        // Start the player with a sword and a shirt
        MDWeapon *startingWeapon = [[MDSword alloc] init];
        self.equippedWeapon = startingWeapon;
        [self.inventoryItems addObject:startingWeapon];
        
        MDArmor *startingArmor = [[MDShirt alloc] init];
        self.equippedBody = startingArmor;
        [self.inventoryItems addObject:startingArmor];
    }
    
    return self;
}

-(void)setCurrentHealth:(int)currentHealth {
    
    _currentHealth = currentHealth;
    
    if (_currentHealth < 0) {
        _currentHealth = 0;
    }
    
    if (_currentHealth > self.maxHealth) {
        _currentHealth = self.maxHealth;
    }
}

@end
