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

@interface MDSharedPlayerData : NSObject

@property(nonatomic, strong) MDPlayer *player;

+(MDSharedPlayerData*)sharedPlayerData;

@end
