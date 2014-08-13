//
//  MDBattleMessage.m
//  MDItems
//
//  Created by Dickman, Mike on 8/7/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDBattleMessage.h"

@implementation MDBattleMessage

+(MDBattleMessage*)messageWithMessage:(NSString*)message describesPlayerAction:(BOOL)describesPlayerAction {
    
    MDBattleMessage *battleMessage = [[MDBattleMessage alloc] init];
    battleMessage.messageString = message;
    battleMessage.describesPlayerAction = describesPlayerAction;
    return battleMessage;
}

@end
