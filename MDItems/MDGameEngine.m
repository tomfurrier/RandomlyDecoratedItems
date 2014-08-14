//
//  MDGameEngine.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDGameEngine.h"
#import "MDEnemy.h"
#import "MDPlayer.h"
#import "MDWeapon.h"
#import "MDArmor.h"
#import "NSObject+Random.h"
#import "MDBattleMessage.h"

@implementation MDGameEngine

+(void)takeTurnWithPlayer:(MDPlayer*)player enemy:(MDEnemy*)enemy messageLog:(NSMutableArray*)messageLog {
    
    [self attackEnemy:enemy withPlayer:player messageLog:messageLog];
    
    if (enemy.currentHealth > 0) {
        [self attackPlayer:player withEnemy:enemy messageLog:messageLog];
    }
}

+(void)attackEnemy:(MDEnemy*)enemy withPlayer:(MDPlayer*)player messageLog:(NSMutableArray*)messageLog {
    
    if (player.equippedWeapon) {
        
        MDWeapon *weapon = player.equippedWeapon;
        
        // Allow the weapon and any decorators to perform actions before hitting the enemy
        [weapon player:player willHitEnemy:enemy messageLog:messageLog];
        
        // Calculate the damage. The damage getters include any weapon decorator wrappers.
        int damage = [self randomFromMin:weapon.minDamage max:weapon.maxDamage];
        
        // Determine if it was a critical hit. critChance includes any decorator wrappers.
        BOOL isCriticalHit = NO;
        int chance = weapon.critChance;
        if (arc4random() % 100 < chance) {
            isCriticalHit = YES;
            // Add the damage bonus. critPercentBonusDamage will include any decorator wrappers
            int bonusDamage = (damage * (.01 * weapon.critPercentBonusDamage));
            damage += bonusDamage;
        }
        
        // Apply the damage to the enemy's health
        enemy.currentHealth -= damage;
        
        // Log what happened to display to the player
        NSMutableString *message = [NSMutableString stringWithFormat:@"Attacked for %d damage", damage];
        if (isCriticalHit) {
            [message appendString:@" - CRITICAL HIT!"];
        }
        [messageLog insertObject:[MDBattleMessage messageWithMessage:message
                                                  describesPlayerAction:YES]
                            atIndex:0];
        
        // Allow the weapon and any decorators to perform actions after hitting the enemy
        [player.equippedWeapon player:player didHitEnemy:enemy forDamage:damage messageLog:messageLog];
        
    } else {
        
        // No weapon was equipped, so only do a couple of damage points
        int unarmedDamage = [self randomFromMin:1 max:2];
        enemy.currentHealth -= unarmedDamage;
        [messageLog insertObject:[MDBattleMessage messageWithMessage:[NSString stringWithFormat:@"Punched for %d damage", unarmedDamage]
                                                  describesPlayerAction:YES]
                         atIndex:0];
    }
    
    [self applyStatusEffectsToEnemy:enemy messageLog:messageLog];
    
    if (enemy.currentHealth <= 0) {
        
        // Trigger the event on the weapon and any decorators
        [player.equippedWeapon player:player didDefeatEnemy:enemy messageLog:messageLog];
    }
}

+(void)applyStatusEffectsToEnemy:(MDEnemy*)enemy messageLog:(NSMutableArray*)messageLog {
    
    // Subtract more health each turn if the enemy is poisoned
    if (enemy.isPoisoned) {
        enemy.currentHealth -= 5;
        NSString *message = [NSString stringWithFormat:@"%@ is poisoned and suffers %d damage!", enemy.name, 5];
        [messageLog insertObject:[MDBattleMessage messageWithMessage:message
                                                  describesPlayerAction:YES]
                         atIndex:0];
    }
}

+(void)attackPlayer:(MDPlayer*)player withEnemy:(MDEnemy*)enemy messageLog:(NSMutableArray*)messageLog {
    
    int damage = [self randomFromMin:enemy.minDamage max:enemy.maxDamage];
    
    // Subtract the player's total defense from the damage
    int defensePoints = 0;
    defensePoints += player.equippedBody.defense;
    defensePoints += player.equippedHead.defense;
    defensePoints += player.equippedHands.defense;
    defensePoints += player.equippedFeet.defense;
    damage -= defensePoints;
    if (damage < 0) {
        damage = 0;
    }
    
    // Absorb damage
    int percentAbsorbed = 0;
    percentAbsorbed += player.equippedBody.percentDamageAbsorbed;
    percentAbsorbed += player.equippedHead.percentDamageAbsorbed;
    percentAbsorbed += player.equippedHands.percentDamageAbsorbed;
    percentAbsorbed += player.equippedFeet.percentDamageAbsorbed;
    int pointsAbsorbed = (percentAbsorbed * .01) * damage;
    damage -= pointsAbsorbed;
    player.currentHealth += pointsAbsorbed;
    
    // Reflect damage
    int percentReflected = 0;
    percentReflected += player.equippedBody.percentDamageReflected;
    percentReflected += player.equippedHead.percentDamageReflected;
    percentReflected += player.equippedHands.percentDamageReflected;
    percentReflected += player.equippedFeet.percentDamageReflected;
    int pointsReflected = (percentReflected * .01) * damage;
    enemy.currentHealth -= pointsReflected;
    
    player.currentHealth -= damage;
    [messageLog insertObject:[MDBattleMessage messageWithMessage:[NSString stringWithFormat:@"Took %d damage!", damage]
                                              describesPlayerAction:NO]
                        atIndex:0];
    
    if (pointsReflected > 0) {
        [messageLog insertObject:[MDBattleMessage messageWithMessage:[NSString stringWithFormat:@"Reflected %d damage!", pointsReflected]
                                               describesPlayerAction:YES]
                         atIndex:0];
    }
    
    if (pointsAbsorbed > 0) {
        [messageLog insertObject:[MDBattleMessage messageWithMessage:[NSString stringWithFormat:@"Absorbed %d damage!", pointsAbsorbed]
                                               describesPlayerAction:YES]
                         atIndex:0];
    }
    
    // Allow the armor and any decorators to perform actions for these events
    [player.equippedBody enemy:enemy didHitPlayer:player forDamage:damage messageLog:messageLog];
    [player.equippedHead enemy:enemy didHitPlayer:player forDamage:damage messageLog:messageLog];
    [player.equippedHands enemy:enemy didHitPlayer:player forDamage:damage messageLog:messageLog];
    [player.equippedFeet enemy:enemy didHitPlayer:player forDamage:damage messageLog:messageLog];
    
    if (player.currentHealth <= 0) {
        [player.equippedBody enemy:enemy didKillPlayer:player messageLog:messageLog];
        [player.equippedHead enemy:enemy didKillPlayer:player messageLog:messageLog];
        [player.equippedHands enemy:enemy didKillPlayer:player messageLog:messageLog];
        [player.equippedFeet enemy:enemy didKillPlayer:player messageLog:messageLog];
    }
}

@end
