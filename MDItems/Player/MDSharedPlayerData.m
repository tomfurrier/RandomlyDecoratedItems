//
//  MDSharedPlayerData.m
//  MDItems
//
//  Created by Dickman, Mike on 7/23/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDSharedPlayerData.h"
#import "MDPlayer.h"
#import "MDWeapon.h"
#import "MDArmor.h"

@implementation MDSharedPlayerData

+(MDSharedPlayerData *)sharedPlayerData {
    static MDSharedPlayerData *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(instancetype)init {

    if (self = [super init]) {
        self.player = [[MDPlayer alloc] init];
    }
    return self;
}

@end
