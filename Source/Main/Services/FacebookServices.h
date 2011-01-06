#import <Foundation/Foundation.h>
#import "FBConnect.h"

@interface FacebookServices : NSObject <FBSessionDelegate, UIAlertViewDelegate> {

}

@property (nonatomic, readonly) Facebook *facebook;

+ (FacebookServices *)sharedFacebookServices;

- (void)authorizeForPermissions:(NSArray *)permission;
- (void)askToSharePictures;

@end
