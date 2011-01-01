#import <Foundation/Foundation.h>
#import "BaseASIServices+Utils.h"

@interface BaseASIServices (utils)

- (ASIHTTPRequest *)requestWithUrl:(NSString *)url;
- (ASIFormDataRequest *)formRequestWithUrl:(NSString *)url;

- (NSString *)notificationNameForRequest:(ASIHTTPRequest *)request;
- (void)informEmtpy:(BOOL)empty forKey:(NSString *)key;
- (void)notifyDone:(ASIHTTPRequest *)request object:(id)object;
- (void)notifyFailed:(ASIHTTPRequest *)request withError:(NSString *)errorString;

@end
