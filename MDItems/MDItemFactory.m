//  MDItemFactory.m

#import "MDItemFactory.h"
#import "MDWeapon.h"
#import "MDArmor.h"
#import "MDSword.h"
#import "MDDagger.h"
#import "MDClub.h"
#import "MDHammer.h"
#import "MDShirt.h"
#import "MDHat.h"
#import "MDGloves.h"
#import "MDBoots.h"
#import "MDEnhancedDamageWeaponDecorator.h"
#import "MDCritChanceWeaponDecorator.h"
#import "MDPoisonWeaponDecorator.h"
#import "MDLifeLeechWeaponDecorator.h"
#import "MDFullRecoveryWeaponDecorator.h"
#import "MDCritDamageWeaponDecorator.h"
#import "MDDefenseArmorDecorator.h"
#import "MDReflectArmorDecorator.h"
#import "MDAbsorbArmorDecorator.h"
#import "MDDeathArmorDecorator.h"
#import "MDReviveArmorDecorator.h"
#import "NSObject+Random.h"

@implementation MDItemFactory

#pragma mark - Item Setup

+(MDItem*)randomItem {
    
    if (arc4random() % 2 == 0) {
        return [self randomWeapon];
    } else {
        return [self randomArmor];
    }
}

+(MDWeapon*)randomWeapon {
    
    MDWeapon *weapon;
    
    switch (arc4random() % 4) {
        case 0:
            weapon = [[MDSword alloc] init];
            break;
        case 1:
            weapon = [[MDDagger alloc] init];
            break;
        case 2:
            weapon = [[MDClub alloc] init];
            break;
        case 3:
            weapon = [[MDHammer alloc] init];
            break;
        default:
            break;
    }
    
    [self tweakBaseStatsOfItem:weapon byMaxAmount:2];
    
    // Check for rarity
    if (arc4random() % 15 == 0) {
        
        // 1 in 15 chance - item is rare, add two properties
        weapon = [self weaponFromWeapon:weapon withNumberOfDecorators:[self randomFromMin:2 max:3]];
        weapon.rarity = itemRarityRare;
        weapon.hasBeenIdentified = NO;
        
    } else if (arc4random() % 5 == 0) {
        
        // 1 in 5 chance - item is magic, add one property
        weapon = [self weaponFromWeapon:weapon withNumberOfDecorators:1];
        weapon.rarity = itemRarityMagic;
        weapon.hasBeenIdentified = NO;
    }
    
    return weapon;

}

+(MDArmor*)randomArmor {
    
    MDArmor *armor;
    
    switch (arc4random() % 4) {
        case 0:
            armor = [[MDShirt alloc] init];
            break;
        case 1:
            armor = [[MDBoots alloc] init];
            break;
        case 2:
            armor = [[MDGloves alloc] init];
            break;
        case 3:
            armor = [[MDHat alloc] init];
            break;
        default:
            break;
    }
    
    [self tweakBaseStatsOfItem:armor byMaxAmount:2];
    
    // Check for rarity
    if (arc4random() % 15 == 0) {
        
        // 1 in 15 chance - item is rare, add two properties
        armor = [self armorFromArmor:armor withNumberOfDecorators:[self randomFromMin:2 max:3]];
        armor.rarity = itemRarityRare;
        armor.hasBeenIdentified = NO;
        
    } else if (arc4random() % 5 == 0) {
        
        // 1 in 5 chance - item is magic, add one property
        armor = [self armorFromArmor:armor withNumberOfDecorators:1];
        armor.rarity = itemRarityMagic;
        armor.hasBeenIdentified = NO;
    }
    
    return armor;
    
}

+(void)tweakBaseStatsOfItem:(MDItem*)item byMaxAmount:(int)maxAmount {
    
    int amountToAdd = arc4random() % (maxAmount + 1); // Returns 0 - maxAmount
    
    if ([item isKindOfClass:[MDWeapon class]]) {
        // Add min and max damage
        MDWeapon *weapon = (MDWeapon*)item;
        weapon.minDamage += amountToAdd;
        weapon.maxDamage += amountToAdd;
    } else if ([item isKindOfClass:[MDArmor class]]) {
        MDArmor *armor = (MDArmor*)item;
        armor.defense += amountToAdd;
    }
    
    // Make the item sell for more, too!
    item.sellingPrice += (amountToAdd * 2);
}

#pragma mark - Armor

+(MDArmor*)armorFromArmor:(MDArmor*)armor withNumberOfDecorators:(int)amountToAdd {
    
    int numberOfDecorators = 5;
    
    // Possible decorators will be a pool of non-repeating indexes to use in the switch statement below that sets a corresponding decorator for that index
    int possibleDecorators[numberOfDecorators];
    
    // Fill possibleDecorators with their own indexes. If selected, an index will be overwritten and never appear again.
    for (int i = 0; i < numberOfDecorators; i++) {
        possibleDecorators[i] = i;
    }
    
    for (int i = 0; i < amountToAdd; i++) {
        
        // Select a random index, get the value, and prevent it from appearing again
        int randomIndex = arc4random() % numberOfDecorators;
        int rollValue = possibleDecorators[randomIndex];
        possibleDecorators[randomIndex] = possibleDecorators[numberOfDecorators - 1]; // Overwrite it with the index at the end
        numberOfDecorators--; // Decrement to account for the one we "removed"
        
        // Wrap it in the decorator
        switch (rollValue) {
            case 0:
                armor = [[MDDefenseArmorDecorator alloc] initWithArmor:armor];
                break;
            case 1:
                armor = [[MDReflectArmorDecorator alloc] initWithArmor:armor];
                break;
            case 2:
                armor = [[MDAbsorbArmorDecorator alloc] initWithArmor:armor];
                break;
            case 3:
                armor = [[MDDeathArmorDecorator alloc] initWithArmor:armor];
                break;
            case 4:
                armor = [[MDReviveArmorDecorator alloc] initWithArmor:armor];
                break;
            default:
                break;
        }
        
    }
    return armor;
}

#pragma mark - Weapons

+(MDWeapon*)weaponFromWeapon:(MDWeapon*)weapon withNumberOfDecorators:(int)amountToAdd {
    
    int numberOfDecorators = 6;
    
    // Possible decorators will be a pool of non-repeating indexes to use in the switch statement below that sets a corresponding decorator for that index
    int possibleDecorators[numberOfDecorators];
    
    // Fill possibleDecorators with their own indexes. If selected, an index will be overwritten and never appear again.
    for (int i = 0; i < numberOfDecorators; i++) {
        possibleDecorators[i] = i;
    }
    
    for (int i = 0; i < amountToAdd; i++) {
        
        // Select a random index, get the value, and prevent it from appearing again
        int randomIndex = arc4random() % numberOfDecorators;
        int rollValue = possibleDecorators[randomIndex];
        possibleDecorators[randomIndex] = possibleDecorators[numberOfDecorators - 1]; // Overwrite it with the index at the end
        numberOfDecorators--; // Decrement to account for the one we "removed"
        
        // Wrap it in the decorator
        switch (rollValue) {
            case 0:
                weapon = [[MDEnhancedDamageWeaponDecorator alloc] initWithWeapon:weapon];
                break;
            case 1:
                weapon = [[MDCritChanceWeaponDecorator alloc] initWithWeapon:weapon];
                break;
            case 2:
                weapon = [[MDPoisonWeaponDecorator alloc] initWithWeapon:weapon];
                break;
            case 3:
                weapon = [[MDLifeLeechWeaponDecorator alloc] initWithWeapon:weapon];
                break;
            case 4:
                weapon = [[MDFullRecoveryWeaponDecorator alloc] initWithWeapon:weapon];
                break;
            case 5:
                weapon = [[MDCritDamageWeaponDecorator alloc] initWithWeapon:weapon];
            default:
                break;
        }
        
    }
    return weapon;
}

@end