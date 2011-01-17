#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"
#import "CustomToolBar.h"

@interface UINavigationController (Custom)

@property (nonatomic, readonly) CustomNavigationBar *customNavigationBar;
@property (nonatomic, readonly) CustomToolBar *customToolBar;

@end
