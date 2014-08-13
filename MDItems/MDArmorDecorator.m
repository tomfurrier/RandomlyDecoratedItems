//
//  MDArmorDecorator.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDArmorDecorator.h"

@implementation MDArmorDecorator

-(instancetype)initWithArmor:(MDArmor *)armor {
    if (self = [super init]) {
        self.armor = armor;
    }
    return self;
}

-(void)enemy:(MDEnemy *)enemy didKillPlayer:(MDPlayer *)player messageLog:(NSMutableArray *)messageLog {
    [self.armor enemy:enemy didKillPlayer:player messageLog:messageLog];
}

-(void)enemy:(MDEnemy *)enemy didHitPlayer:(MDPlayer *)player forDamage:(int)damage messageLog:(NSMutableArray *)messageLog {
    [self.armor enemy:enemy didHitPlayer:player forDamage:damage messageLog:messageLog];
}

-(int)defense {
    return self.armor.defense;
}

-(NSString *)namePrefix {
    return self.armor.namePrefix;
}

-(NSString *)nameSuffix {
    return self.armor.nameSuffix;
}

-(ArmorType)armorType {
    return self.armor.armorType;
}

-(int)percentDamageReflected {
    return self.armor.percentDamageReflected;
}

-(int)percentDamageAbsorbed {
    return self.armor.percentDamageAbsorbed;
}

-(NSString *)imageName {
    return self.armor.imageName;
}

-(NSString *)baseName {
    return self.armor.baseName;
}

@end
