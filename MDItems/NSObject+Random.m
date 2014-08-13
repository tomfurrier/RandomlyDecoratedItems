//
//  NSObject+Random.m
//  MDItems
//
//  Created by Dickman, Mike on 7/29/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "NSObject+Random.h"

@implementation NSObject (Random)

-(int)randomFromMin:(int)min max:(int)max {
    return arc4random() % (max - min + 1) + min;
}

@end
