//  MDArmor.h

#import "MDItem.h"

typedef enum {
    armorTypeHead,
    armorTypeBody,
    armorTypeHands,
    armorTypeFeet
}ArmorType;

@interface MDArmor : MDItem

@property (nonatomic) int baseDefense;
@property (nonatomic) ArmorType type;

@end