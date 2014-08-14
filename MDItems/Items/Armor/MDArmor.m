//
//  MDArmor.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDArmor.h"

@implementation MDArmor

-(NSString *)statDescription {
    
    if (self.hasBeenIdentified) {
        return [NSString stringWithFormat:@"Defense: %d", self.defense];
    } else {
        return @"Defense: ?";
    }

}

-(void)enemy:(MDEnemy*)enemy didKillPlayer:(MDPlayer*)player messageLog:(NSMutableArray*)messageLog {
    
}

-(void)enemy:(MDEnemy*)enemy didHitPlayer:(MDPlayer*)player forDamage:(int)damage messageLog:(NSMutableArray*)messageLog {
    
}

@end
