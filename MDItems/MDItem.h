//
//  MDItem.h
//  ItemsDecoratorPattern
//
//  Created by Dickman, Mike on 7/24/14.
//  Copyright (c) 2014 Quicken Loans. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    itemRarityCommon,
    itemRarityMagic,
    itemRarityRare,
    itemRarityUnique
} ItemRarity;

@interface MDItem : NSObject

@property(nonatomic, strong) NSString *baseName, *namePrefix, *nameSuffix, *imageName, *specialImageName;
@property(nonatomic) int sellingPrice;
@property(nonatomic) ItemRarity rarity;
@property(nonatomic) BOOL hasBeenIdentified;
@property(nonatomic) BOOL suffixBeingUsed, prefixBeingUsed;

-(NSString*)fullName;
-(NSString*)statDescription;
-(UIImage*)imageToDisplay;
-(NSMutableArray*)modifierDescriptions;

@end
