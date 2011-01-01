#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "BaseLoadingViewCenter.h"

@interface BaseViewController : UIViewController <BaseLoadingViewCenterDelegate, MBProgressHUDDelegate>{
}

- (void)setupCustomInitialisation;

- (void)setupNavigationBar;
- (void)setupToolbar;

- (void)shouldReloadContent:(NSNotification *)notification;

@property (nonatomic, retain) MBProgressHUD *loadingView;
@property (nonatomic, retain) MBProgressHUD *noResultsView;

@property (nonatomic, readonly) BOOL isNetworkReachable;

@end