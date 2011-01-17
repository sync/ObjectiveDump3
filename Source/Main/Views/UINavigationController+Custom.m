#import "UINavigationController+Custom.h"


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

#pragma mark -
#pragma mark CustomToolBar

- (CustomToolBar *)customToolBar
{
	if (![self.toolbar isKindOfClass:[CustomToolBar class]]) {
		return nil;
	}
	
	return (CustomToolBar *)self.toolbar;
}

@end
