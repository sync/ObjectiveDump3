#import <Foundation/Foundation.h>
#import "OAuth.h"
#import "TwitterLoginPopupDelegate.h"
#import "TwitterLoginUiFeedback.h"
#import "CustomLoginPopup.h"

#define TwitterNotification @"TwitterDidLoginNotification"
#define TwitterAuthorizedUserDefaults @"TwitterAuthorizedUserDefaults"

#define OAUTH_CONSUMER_KEY @"your_key_here"
#define OAUTH_CONSUMER_SECRET @"you_sercred_here"

@interface TwitterServices : NSObject <TwitterLoginPopupDelegate, TwitterLoginUiFeedback> {

}

@property (nonatomic, readonly) OAuth *oAuth;
@property (nonatomic, readonly) CustomLoginPopup *loginPopup;

+ (TwitterServices *)sharedTwitterServices;

- (BOOL)authorizeInNavController:(UINavigationController *)navController;

// defaults
@property (nonatomic) BOOL twitterAuthorized;

@end
