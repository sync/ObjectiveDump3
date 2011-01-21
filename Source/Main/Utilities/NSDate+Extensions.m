#import "NSDate+Extensions.h"
#import "NSDate-Utilities.h"

@implementation NSDate (Extensions)

// ripoff https://github.com/billymeltdown/nsdate-helper/network but with fixes

+ (NSString *)stringForDisplayFromDate:(NSDate *)date 
{
	return [self stringForDisplayFromDate:date prefixed:NO];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed 
{
	/* 
	 * if the date is in today, display 12-hour time with meridian,
	 * if it is within the last 7 days, display weekday name (Friday)
	 * if within the calendar year, display as Jan 23
	 * else display as Nov 11, 2008
	 */
	
	NSDateFormatter *displayFormatter = [[[NSDateFormatter alloc] init]autorelease];
	NSString *displayString = nil;
	
	// comparing against midnight
	if ([date isToday]) {
		if (prefixed) {
			[displayFormatter setDateFormat:@"'at' h:mma"]; // at 11:30 am
		} else {
			[displayFormatter setDateFormat:@"h:mma"]; // 11:30 am
		}
	} else {
		if ([date isThisWeek]) {
			[displayFormatter setDateFormat:@"EEEE"]; // Tuesday
		} else {
			if ([date isThisYear]) {
				[displayFormatter setDateFormat:@"MMM d"];
			} else {
				[displayFormatter setDateFormat:@"MMM d, yyyy"];
			}
		}
		if (prefixed) {
			NSString *dateFormat = [displayFormatter dateFormat];
			NSString *prefix = @"'on' ";
			[displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
		}
	}
	
	// use display formatter to return formatted date string
	displayString = [displayFormatter stringFromDate:date];
	return displayString;
}

@end
