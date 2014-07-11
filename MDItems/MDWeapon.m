//  MDWeapon.m

#import "MDWeapon.h"

@implementation MDWeapon

-(NSString *)statDescription {
    return [NSString stringWithFormat:@"Damage: %d - %d", self.baseMinDamage, self.baseMaxDamage];
}

@end