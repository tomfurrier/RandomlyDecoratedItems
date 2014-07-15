//  MDItemFactory.m

#import "MDItemFactory.h"
#import "MDWeapon.h"
#import "MDArmor.h"

@implementation MDItemFactory

#pragma mark - Item Setup

+(MDItem *)randomItem {
    MDItem *item;
    
    int itemRoll = arc4random() % 7; // A number 0 - 6
    switch (itemRoll) {
        case 0:
            item = [self sword];
            break;
        case 1:
            item = [self dagger];
            break;
        case 2:
            item = [self club];
            break;
        case 3:
            item = [self clothShirt];
            break;
        case 4:
            item = [self hat];
            break;
        case 5:
            item = [self gloves];
            break;
        case 6:
            item = [self boots];
            break;
        default:
            NSLog(@"Error! Tried to generate a random item that doesn't exist.");
            break;
    }
    
    [self tweakBaseStatsOfItem:item byMaxAmount:2];
    
    // Check for rarity
    if (arc4random() % 20 == 0) {
        
        // 1 in 20 chance - item is rare, add two properties
        item.rarity = itemRarityRare;
        [self enhanceItem:item withNumberOfProperties:2];
        
    } else if (arc4random() % 5 == 0) {
        
        // 1 in 5 chance - item is magic, add one property
        item.rarity = itemRarityMagic;
        [self enhanceItem:item withNumberOfProperties:1];
    }
    
    return item;
}

+(void)tweakBaseStatsOfItem:(MDItem*)item byMaxAmount:(int)maxAmount {
    
    int amountToAdd = arc4random() % (maxAmount + 1); // Returns 0 - maxAmount
    
    if ([item isKindOfClass:[MDArmor class]]) {
        // Add defense
        MDArmor *armor = (MDArmor*)item;
        armor.baseDefense += amountToAdd;
    } else if ([item isKindOfClass:[MDWeapon class]]) {
        // Add min and max damage
        MDWeapon *weapon = (MDWeapon*)item;
        weapon.baseMinDamage += amountToAdd;
        weapon.baseMaxDamage += amountToAdd;
    }
    
    // Make the item sell for more, too!
    item.sellingPrice += (amountToAdd * 2);
}

+(void)enhanceItem:(MDItem*)item withNumberOfProperties:(int)numOfProperties {
    
    // Choose a random property to add
    for (int i = 0; i < numOfProperties; i++) {
        
        switch (arc4random() % 3) {
            case 0:
                [self addBonusGoldFindToItem:item];
                break;
            case 1:
                [self addBonusXpPerKillToItem:item];
                break;
            case 2:
                [self addHealthRegenPerSecondToItem:item];
                break;
            default:
                break;
        }
    }
}

+(void)addBonusGoldFindToItem:(MDItem*)item {
    
    int max = 10;
    int min = 5;
    int amountToAdd = arc4random() % (max - min + 1) + min; // Returns 5 - 10
    
    // Apply the modifier and add a relevant description
    item.bonusGoldFind += amountToAdd;
    NSString *description = [NSString stringWithFormat:@"Find %d%% more gold", amountToAdd];
    [item.propertyDescriptions addObject:description];
    
    // Add a modifier to the name of the item if none are set
    if (item.namePrefix.length == 0) {
        item.namePrefix = @"Lucky";
    } else if (item.nameSuffix.length == 0) {
        item.nameSuffix = @"of Luck";
    }
}

+(void)addBonusXpPerKillToItem:(MDItem*)item {
    
    int max = 15;
    int min = 5;
    int amountToAdd = arc4random() % (max - min + 1) + min; // Returns 5 - 15
    
    // Apply the modifier and add a relevant description
    item.bonusXpPerKill += amountToAdd;
    NSString *description = [NSString stringWithFormat:@"+%d XP per kill", amountToAdd];
    [item.propertyDescriptions addObject:description];
    
    // Add a modifier to the name of the item if none are set
    if (item.namePrefix.length == 0) {
        item.namePrefix = @"Wise";
    } else if (item.nameSuffix.length == 0) {
        item.nameSuffix = @"of Wisdom";
    }
}

+(void)addHealthRegenPerSecondToItem:(MDItem*)item {
    
    int max = 5;
    int min = 2;
    int amountToAdd = arc4random() % (max - min + 1) + min; // Returns 2 - 5
    
    // Apply the modifier and add a relevant description
    item.healthRegenPerSecond += amountToAdd;
    NSString *description = [NSString stringWithFormat:@"+%d health per second", amountToAdd];
    [item.propertyDescriptions addObject:description];
    
    // Add a modifier to the name of the item if none are set
    if (item.namePrefix.length == 0) {
        item.namePrefix = @"Vital";
    } else if (item.nameSuffix.length == 0) {
        item.nameSuffix = @"of Vitality";
    }
}

#pragma mark - Weapon Templates

+(MDWeapon*)sword {
    MDWeapon *weapon = [[MDWeapon alloc] init];
    weapon.baseName = @"Sword";
    weapon.imageName = @"sword";
    weapon.baseMinDamage = 4;
    weapon.baseMaxDamage = 7;
    return weapon;
}

+(MDWeapon*)dagger {
    MDWeapon *weapon = [[MDWeapon alloc] init];
    weapon.baseName = @"Dagger";
    weapon.imageName = @"dagger";
    weapon.baseMinDamage = 3;
    weapon.baseMaxDamage = 6;
    return weapon;
}

+(MDWeapon*)club {
    MDWeapon *weapon = [[MDWeapon alloc] init];
    weapon.baseName = @"Club";
    weapon.imageName = @"club";
    weapon.baseMinDamage = 1;
    weapon.baseMaxDamage = 9;
    return weapon;
}

#pragma mark - Armor Templates

+(MDArmor*)clothShirt {
    MDArmor *armor = [[MDArmor alloc] init];
    armor.baseName = @"Cloth Shirt";
    armor.imageName = @"clothShirt";
    armor.baseDefense = 3;
    return armor;
}

+(MDArmor*)hat {
    MDArmor *armor = [[MDArmor alloc] init];
    armor.baseName = @"Hat";
    armor.imageName = @"hat";
    armor.baseDefense = 1;
    return armor;
}

+(MDArmor*)gloves {
    MDArmor *armor = [[MDArmor alloc] init];
    armor.baseName = @"Gloves";
    armor.imageName = @"gloves";
    armor.baseDefense = 1;
    return armor;
}

+(MDArmor*)boots {
    MDArmor *armor = [[MDArmor alloc] init];
    armor.baseName = @"Boots";
    armor.imageName = @"boots";
    armor.baseDefense = 2;
    return armor;
}

@end