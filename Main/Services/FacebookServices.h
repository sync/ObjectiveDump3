#import <Foundation/Foundation.h>
#import "FBConnect.h"

@interface FacebookServices : NSObject <FBSessionDelegate, UIAlertViewDelegate> {

}

@property (nonatomic, readonly) Facebook *facebook;

+ (FacebookServices *)sharedFacebookServices;

- (BOOL)authorize;
- (void)askToSharePictures;

@end
