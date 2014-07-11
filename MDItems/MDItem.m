//  MDItem.m

#import "MDItem.h"

@implementation MDItem

-(id)init {
    if (self = [super init]) {
        
        self.sellingPrice = 10;
        self.requiredPlayerLevel = 1;
    }
    return self;
}

-(NSString *)statDescription {
    // Override in subclass to provide description;
    return @"";
}

@end