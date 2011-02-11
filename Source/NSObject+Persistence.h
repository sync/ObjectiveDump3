#import <Foundation/Foundation.h>


@interface NSArray (Persistence)

+ (NSDictionary *)savedForKey:(NSString *)key;
- (void)saveForKey:(NSString *)key;

@end