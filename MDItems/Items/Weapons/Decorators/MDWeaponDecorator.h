//
//  MDWeaponDecorator.h
//  ItemsDecoratorPattern
//
//  Created by Dickman, Mike on 7/24/14.
//  Copyright (c) 2014 Quicken Loans. All rights reserved.
//

#import "MDWeapon.h"

@interface MDWeaponDecorator : MDWeapon

@property(nonatomic, strong) MDWeapon *weapon;

-(instancetype)initWithWeapon:(MDWeapon*)weapon;

@end
