#import "UINavigationController+CustomNavigationBar.h"


@implementation UINavigationController (CustomNavigationBar)

#pragma mark -
#pragma mark CustomNavigationBar

- (CustomNavigationBar *)customNavigationBar
{
	if (![self.navigationBar isKindOfClass:[CustomNavigationBar class]]) {
		return nil;
	}
	
	return (CustomNavigationBar *)self.navigationBar;
}

- (void)customBackButtonTouched
{
	[self popViewControllerAnimated:TRUE];
}

@end
