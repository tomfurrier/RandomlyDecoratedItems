//  MDItem.h

#import <Foundation/Foundation.h>

typedef enum {
    itemRarityCommon,
    itemRarityMagic,
    itemRarityRare
}ItemRarity;

@interface MDItem : NSObject

@property(nonatomic, strong) NSString *baseName, *imageName;
@property(nonatomic) int sellingPrice, requiredPlayerLevel;
@property(nonatomic) ItemRarity rarity;
@property(nonatomic) int bonusGoldFind, bonusXpPerKill, healthRegenPerSecond;
@property(nonatomic, strong) NSMutableArray *propertyDescriptions;
@property(nonatomic, strong) NSString *namePrefix, *nameSuffix;

-(NSString*)statDescription;
-(NSString*)fullName;

@end