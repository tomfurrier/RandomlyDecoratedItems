//
//  MDSharedPlayerData.h
//  MDItems
//
//  Created by Dickman, Mike on 7/23/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MDPlayer;
@class MDItem;
@class MDWeapon;
#import "MDArmor.h"

@interface MDSharedPlayerData : NSObject

@property(nonatomic, strong) MDPlayer *player;

+(MDSharedPlayerData*)sharedPlayerData;
-(BOOL)isItemEquipped:(MDItem*)item;
-(void)equipWeapon:(MDWeapon*)weapon;
-(void)equipArmor:(MDArmor*)armor;
-(void)unequipWeapon:(MDWeapon*)weapon;
-(void)unequipArmor:(MDArmor*)armor;
-(NSArray*)allInventoryArmorOfType:(ArmorType)armorType;
-(NSArray*)allInventoryWeapons;

@end
