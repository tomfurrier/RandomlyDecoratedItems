//
//  MDPlayer.h
//  MDItems
//
//  Created by Dickman, Mike on 7/23/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MDWeapon;
@class MDArmor;
@class MDItem;

@interface MDPlayer : NSObject

@property(nonatomic, strong) MDWeapon *equippedWeapon;
@property(nonatomic, strong) MDArmor *equippedHead, *equippedBody, *equippedHands, *equippedFeet;
@property(nonatomic, strong) NSMutableArray *inventoryItems;
@property(nonatomic) int maxHealth, currentHealth;

-(BOOL)isItemEquipped:(MDItem*)item;
-(void)equipWeapon:(MDWeapon*)weapon;
-(void)equipArmor:(MDArmor*)armor;
-(void)unequipWeapon:(MDWeapon*)weapon;
-(void)unequipArmor:(MDArmor*)armor;
-(NSArray*)allInventoryArmorOfType:(int)armorType;
-(NSArray*)allInventoryWeapons;

@end
