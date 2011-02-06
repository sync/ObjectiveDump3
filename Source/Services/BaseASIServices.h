#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "BaseLoadingViewCenter.h"


#define RequestTimeOutSeconds 45.0

@interface BaseASIServices : NSObject {
	
}

@property (nonatomic, readonly) ASINetworkQueue *networkQueue;

- (void)applicationWillResignActive;

- (ASIHTTPRequest *)requestWithUrl:(NSString *)url;
- (ASIFormDataRequest *)formRequestWithUrl:(NSString *)url;

- (void)downloadContentForUrl:(NSString *)url withObject:(id)object path:(NSString *)path notificationName:(NSString *)notificationName;

@end
