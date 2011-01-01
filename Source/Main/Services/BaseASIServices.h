#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "BaseLoadingViewCenter.h"
#import "APIServices+Utils.h"
#import "JSON.h"
#import "NSObject+Extensions.h"
#import "NSDataAdditions.h"
#import "NSObject+JSONSerializableSupport.h"
#import "ObjectiveResourceDateFormatter.h"

@interface BaseASIServices : NSObject {
	
}

@property (nonatomic, readonly) ASINetworkQueue *networkQueue;

@end
