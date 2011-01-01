#import "BaseASIServices+Utils.h"

@implementation BaseASIServices (utils)

#pragma mark -
#pragma mark Request Constructors

- (ASIHTTPRequest *)requestWithUrl:(NSString *)url
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	request.numberOfTimesToRetryOnTimeout = 1;
	request.timeOutSeconds = RequestTimeOutSeconds;
	
	request.allowCompressedResponse = TRUE;
	
	return request;
}

- (ASIFormDataRequest *)formRequestWithUrl:(NSString *)url
{
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
	request.numberOfTimesToRetryOnTimeout = 2;
	request.timeOutSeconds = RequestTimeOutSeconds;
	[request setRequestMethod:@"POST"];
	
	request.allowCompressedResponse = TRUE;
	
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
	
	return request;
}

#pragma mark -
#pragma mark Request Status

#define BaseServicesNotificationUnknown @"BaseServicesNotificationUnknown"

- (NSString *)notificationNameForRequest:(ASIHTTPRequest *)request
{
	NSString *notificationName = [request.userInfo valueForKey:@"notificationName"];
	return (notificationName) ? notificationName : BaseServicesNotificationUnknown;
}

- (void)informEmtpy:(BOOL)empty forKey:(NSString *)key
{
	// TODO on main thread
	if (empty) {
		[[BaseLoadingViewCenter sharedBaseLoadingViewCenter]showErrorMsg:@"Empty Content!" forKey:key];
	} else {
		[[BaseLoadingViewCenter sharedBaseLoadingViewCenter]removeErrorMsgForKey:key];
	}
}

- (void)notifyDone:(NSDictionary *)dictionary
{
	NSString *notificationName = [dictionary valueForKey:@"notificationName"];
	id object = [dictionary valueForKey:@"object"];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object];
	[[BaseLoadingViewCenter sharedBaseLoadingViewCenter]didStopLoadingForKey:notificationName];
}

- (void)notifyDone:(ASIHTTPRequest *)request object:(id)object;
{
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
								[self notificationNameForRequest:request], @"notificationName",
								object, @"object",
								nil];
	[self performSelectorOnMainThread:@selector(notifyDone:) withObject:dictionary waitUntilDone:NO];
}

- (void)notifyFailed:(NSDictionary *)dictionary
{
	NSString *notificationName = [dictionary valueForKey:@"notificationName"];
	NSString *errorString = [dictionary valueForKey:@"errorString"];
	
	[[BaseLoadingViewCenter sharedBaseLoadingViewCenter]showErrorMsg:errorString forKey:notificationName];
	[[BaseLoadingViewCenter sharedBaseLoadingViewCenter]didStopLoadingForKey:notificationName];
}

- (void)notifyFailed:(ASIHTTPRequest *)request withError:(NSString *)errorString
{
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
								[self notificationNameForRequest:request], @"notificationName",
								errorString, @"errorString",
								nil];
	[self performSelectorOnMainThread:@selector(notifyFailed:) withObject:dictionary waitUntilDone:NO];
}

@end
