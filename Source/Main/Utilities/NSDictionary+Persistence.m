#import "NSDictionary+Persistence.h"


@implementation NSDictionary (Persistence)

- (NSString *)applicationDocumentsDirectory 
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSDictionary *)dictionaryWithContent:(NSArray *)content date:(NSDate *)date
{
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
						  content, @"content",
						  date, @"date",
						  nil];
	return dict;
}

+ (NSDictionary *)savedDictForKey:(NSString *)key
{
	if (!key) {
		return nil;
	}
	
	key = [key stringByAppendingString:@".plist"];
	
	NSString *applicationDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	
	NSData *data = [NSData dataWithContentsOfFile:[applicationDocumentsDirectory stringByAppendingPathComponent:key]]; 
	if(data.length == 0) {
		return nil; 
	}
	
	return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)saveDictForKey:(NSString *)key
{
	key = [key stringByAppendingString:@".plist"];
	NSString *path = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:key];
	
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
	if(data.length > 0) {
		[data writeToFile:path atomically:NO];
	} else {
		NSFileManager *manager = [NSFileManager defaultManager];
		[manager removeItemAtPath:path error:nil];
	}
}

- (void)setObjectUnderArray:(id)object forKey:(NSString *)key
{
	NSMutableArray *array = [NSMutableArray arrayWithArray:[self valueForKey:key]];
	NSInteger idx = [array indexOfObject:object];
	if (idx != NSNotFound) {
		[array replaceObjectAtIndex:idx withObject:object];
	} else {
		[array addObject:object];
	}
	[self setValue:array forKey:key];
}

- (void)removeObjectUnderArray:(id)object forKey:(NSString *)key
{
	NSMutableArray *array = [NSMutableArray arrayWithArray:[self valueForKey:key]];
	NSInteger idx = [array indexOfObject:object];
	if (idx != NSNotFound) {
		[array removeObjectAtIndex:idx];
	}
	[self setValue:array forKey:key];
}

@end
