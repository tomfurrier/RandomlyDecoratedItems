//
//  MDItem.m
//  ItemsDecoratorPattern
//
//  Created by Dickman, Mike on 7/24/14.
//  Copyright (c) 2014 Quicken Loans. All rights reserved.
//

#import "MDItem.h"

@implementation MDItem

-(id)init {
    if (self = [super init]) {
        // Items start out as identified
        self.hasBeenIdentified = YES;
    }
    return self;
}

-(NSString *)fullName {
    
    if (!self.hasBeenIdentified) {
        return [NSString stringWithFormat:@"Unidentified %@", self.baseName];
    }
    
    // Add the correct spacing if a prefix has been set
    NSString *prefix = @"";
    if ([self.namePrefix length] > 0) {
        prefix = [NSString stringWithFormat:@"%@ ", self.namePrefix];
    }
    
    // Add the correct spacing if a suffix has been set
    NSString *suffix = @"";
    if ([self.nameSuffix length] > 0) {
        suffix = [NSString stringWithFormat:@" %@", self.nameSuffix];
    }
    
    return [NSString stringWithFormat:@"%@%@%@", prefix, self.baseName, suffix];
}

-(UIImage *)imageToDisplay {
    
    if (self.rarity == itemRarityUnique) {
        // Uniques are not yet implemented
        return [UIImage imageNamed:self.specialImageName];
    } else {
        return [UIImage imageNamed:self.imageName];
    }
}

-(NSMutableArray *)modifierDescriptions {
    return [NSMutableArray array];
}

-(NSString *)statDescription {
    return @"";
}

// The base items don't have a prefix or suffix, the decorators will provide them
-(NSString *)namePrefix {
    return nil;
}

-(NSString *)nameSuffix {
    return nil;
}

@end
