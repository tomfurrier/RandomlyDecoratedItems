//  UIColor+ItemColors.m

#import "UIColor+ItemColors.h"
#import "MDItem.h"

@implementation UIColor (ItemColors)

+(UIColor*)colorForItem:(MDItem*)item {
    
    switch (item.rarity) {
        case itemRarityMagic:
            return [self blueColor];
        case itemRarityRare:
            return [UIColor orangeColor];
        case itemRarityUnique:
            return [UIColor redColor];
        default:
            return [UIColor blackColor];
    }
}

@end