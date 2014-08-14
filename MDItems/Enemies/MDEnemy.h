//
//  MDEnemy.h
//  MDItems
//
//  Created by Dickman, Mike on 7/23/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDEnemy : NSObject

@property(nonatomic) int maxHealth, currentHealth;
@property(nonatomic) int minDamage, maxDamage;
@property(nonatomic) int defense;
@property(nonatomic) NSString *name, *imageName;
@property(nonatomic) BOOL isPoisoned;

+(MDEnemy*)slime;
+(MDEnemy*)goblin;
+(MDEnemy*)skeleton;
+(MDEnemy*)randomEnemy;

@end
