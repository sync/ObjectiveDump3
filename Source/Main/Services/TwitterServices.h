#import <Foundation/Foundation.h>
#import "OAuth.h"
#import "CustomLoginPopup.h"

#define TwitterNotification @"TwitterDidLoginNotification"
#define TwitterAuthorizedUserDefaults @"TwitterAuthorizedUserDefaults"

@interface TwitterServices : NSObject <TwitterLoginPopupDelegate, TwitterLoginUiFeedback> {

}

@property (nonatomic, readonly) OAuth *oAuth;
@property (nonatomic, readonly) CustomLoginPopup *loginPopup;

+ (TwitterServices *)sharedTwitterServices;

- (BOOL)authorizeInNavController:(UINavigationController *)navController;

// defaults
@property (nonatomic) BOOL twitterAuthorized;

@end
