//
//  MDPlayer.m
//  MDItems
//
//  Created by Dickman, Mike on 7/23/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDPlayer.h"
#import "MDItem.h"
#import "MDArmor.h"
#import "MDWeapon.h"
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

#pragma mark - Equipped Item Handling

-(BOOL)isItemEquipped:(id)item {
    
    if ([item isKindOfClass:[MDWeapon class]]) {
        if (item == self.equippedWeapon) {
            return YES;
        }
    } else if ([item isKindOfClass:[MDArmor class]]) {
        MDArmor *armor = (MDArmor*)item;
        if (armor == self.equippedBody ||
            armor == self.equippedFeet ||
            armor == self.equippedHands ||
            armor == self.equippedHead) {
            return YES;
        }
    }
    
    return NO;
}

-(void)equipWeapon:(MDWeapon*)weapon {
    self.equippedWeapon = weapon;
}

-(void)equipArmor:(MDArmor*)armor {
    
    switch (armor.armorType) {
        case armorTypeBody:
            self.equippedBody = armor;
            break;
        case armorTypeHead:
            self.equippedHead = armor;
            break;
        case armorTypeFeet:
            self.equippedFeet = armor;
            break;
        case armorTypeHands:
            self.equippedHands = armor;
            break;
        default:
            break;
    }
}

-(void)unequipWeapon:(MDWeapon*)weapon {
    self.equippedWeapon = nil;
}

-(void)unequipArmor:(MDArmor*)armor {
    
    switch (armor.armorType) {
        case armorTypeBody:
            self.equippedBody = nil;
            break;
        case armorTypeHead:
            self.equippedHead = nil;
            break;
        case armorTypeFeet:
            self.equippedFeet = nil;
            break;
        case armorTypeHands:
            self.equippedHands = nil;
            break;
        default:
            break;
    }
}

#pragma mark - Item Accessors By Type

-(NSArray *)allInventoryArmorOfType:(int)armorType {
    
    ArmorType type = (ArmorType)armorType;
    
    NSMutableArray *armorItems = [NSMutableArray arrayWithCapacity:[self.inventoryItems count]];
    for (MDItem *item in self.inventoryItems) {
        if ([item isKindOfClass:[MDArmor class]]) {
            MDArmor *armor = (MDArmor*)item;
            if (armor.armorType == type) {
                [armorItems addObject:armor];
            }
        }
    }
    
    return armorItems;
}

-(NSArray *)allInventoryWeapons {
    
    NSMutableArray *weaponItems = [NSMutableArray arrayWithCapacity:[self.inventoryItems count]];
    for (MDItem *item in self.inventoryItems) {
        if ([item isKindOfClass:[MDWeapon class]]) {
            [weaponItems addObject:item];
        }
    }
    
    return weaponItems;
}

@end
