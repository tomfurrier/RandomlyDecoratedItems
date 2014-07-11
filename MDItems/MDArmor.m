//  MDArmor.m

#import "MDArmor.h"

@implementation MDArmor

-(NSString *)statDescription {
    return [NSString stringWithFormat:@"Defense: %d", self.baseDefense];
}

@end