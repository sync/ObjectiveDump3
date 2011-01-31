#import <Foundation/Foundation.h>


@interface NSDictionary (Persistence)

+ (NSDictionary *)dictionaryWithContent:(NSArray *)content date:(NSDate *)date;

+ (NSDictionary *)savedDictForKey:(NSString *)key;
- (void)saveDictForKey:(NSString *)key;

@end
