//
//  MDBattleMessage.h
//  MDItems
//
//  Created by Dickman, Mike on 8/7/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDBattleMessage : NSObject

@property (nonatomic) BOOL describesPlayerAction;
@property (nonatomic, strong) NSString *messageString;

+(MDBattleMessage*)messageWithMessage:(NSString*)messageString describesPlayerAction:(BOOL)describesPlayerAction;

@end
