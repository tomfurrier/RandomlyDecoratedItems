//
//  MDSharedPlayerData.m
//  MDItems
//
//  Created by Dickman, Mike on 7/23/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDSharedPlayerData.h"
#import "MDPlayer.h"
#import "MDWeapon.h"
#import "MDArmor.h"

@implementation MDSharedPlayerData

+(MDSharedPlayerData *)sharedPlayerData {
    static MDSharedPlayerData *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(instancetype)init {

    if (self = [super init]) {
        self.player = [[MDPlayer alloc] init];
    }
    return self;
}

#pragma mark - Equipped Item Handling

-(BOOL)isItemEquipped:(id)item {
    
    if ([item isKindOfClass:[MDWeapon class]]) {
        if (item == self.player.equippedWeapon) {
            return YES;
        }
    } else if ([item isKindOfClass:[MDArmor class]]) {
        MDArmor *armor = (MDArmor*)item;
        if (armor == self.player.equippedBody ||
            armor == self.player.equippedFeet ||
            armor == self.player.equippedHands ||
            armor == self.player.equippedHead) {
            return YES;
        }
    }
    
    return NO;
}

-(void)equipWeapon:(MDWeapon*)weapon {
    self.player.equippedWeapon = weapon;
}

-(void)equipArmor:(MDArmor*)armor {
    
    switch (armor.armorType) {
        case armorTypeBody:
            self.player.equippedBody = armor;
            break;
        case armorTypeHead:
            self.player.equippedHead = armor;
            break;
        case armorTypeFeet:
            self.player.equippedFeet = armor;
            break;
        case armorTypeHands:
            self.player.equippedHands = armor;
            break;
        default:
            break;
    }
}

-(void)unequipWeapon:(MDWeapon*)weapon {
    self.player.equippedWeapon = nil;
}

-(void)unequipArmor:(MDArmor*)armor {
    
    switch (armor.armorType) {
        case armorTypeBody:
            self.player.equippedBody = nil;
            break;
        case armorTypeHead:
            self.player.equippedHead = nil;
            break;
        case armorTypeFeet:
            self.player.equippedFeet = nil;
            break;
        case armorTypeHands:
            self.player.equippedHands = nil;
            break;
        default:
            break;
    }
}

#pragma mark - Item Accessors By Type

-(NSArray *)allInventoryArmorOfType:(ArmorType)armorType {
    
    NSMutableArray *armorItems = [NSMutableArray arrayWithCapacity:[self.player.inventoryItems count]];
    for (MDItem *item in self.player.inventoryItems) {
        if ([item isKindOfClass:[MDArmor class]]) {
            MDArmor *armor = (MDArmor*)item;
            if (armor.armorType == armorType) {
                [armorItems addObject:armor];
            }
        }
    }
    
    return armorItems;
}

-(NSArray *)allInventoryWeapons {
    
    NSMutableArray *weaponItems = [NSMutableArray arrayWithCapacity:[self.player.inventoryItems count]];
    for (MDItem *item in self.player.inventoryItems) {
        if ([item isKindOfClass:[MDWeapon class]]) {
            [weaponItems addObject:item];
        }
    }

    return weaponItems;
}

@end
