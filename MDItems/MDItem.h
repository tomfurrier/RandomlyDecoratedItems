//  MDItem.h

#import <Foundation/Foundation.h>

@interface MDItem : NSObject

@property(nonatomic, strong) NSString *baseName, *imageName;
@property(nonatomic) int sellingPrice, requiredPlayerLevel;

-(NSString*)statDescription;

@end