//
//  MDGameEngine.h
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MDPlayer;
@class MDEnemy;

@interface MDGameEngine : NSObject

+(void)takeTurnWithPlayer:(MDPlayer*)player enemy:(MDEnemy*)enemy messageLog:(NSMutableArray*)messageLog;

@end
