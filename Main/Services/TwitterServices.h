#import <Foundation/Foundation.h>
#import "OAuth.h"
#import "CustomLoginPopup.h"

@interface TwitterServices : NSObject <TwitterLoginPopupDelegate, TwitterLoginUiFeedback> {

}

@property (nonatomic, readonly) OAuth *oAuth;
@property (nonatomic, readonly) CustomLoginPopup *loginPopup;

+ (TwitterServices *)sharedTwitterServices;

- (BOOL)authorizeInNavController:(UINavigationController *)navController;

@end
