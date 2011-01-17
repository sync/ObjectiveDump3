#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"

@interface UINavigationController (CustomNavigationBar)

@property (nonatomic, readonly) CustomNavigationBar *customNavigationBar;

@end
