//  MDItem.m

#import "MDItem.h"

@implementation MDItem

-(id)init {
    if (self = [super init]) {
        
        self.sellingPrice = 10;
        self.requiredPlayerLevel = 1;
        self.rarity = itemRarityCommon;
        self.propertyDescriptions = [NSMutableArray array];
        self.namePrefix = @"";
        self.nameSuffix = @"";
    }
    return self;
}

-(NSString *)statDescription {
    // Override in subclass to provide description;
    return @"";
}

-(NSString *)fullName {
    
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

@end