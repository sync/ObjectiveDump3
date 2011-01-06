#import "FacebookServices.h"

@implementation FacebookServices

SYNTHESIZE_SINGLETON_FOR_CLASS(FacebookServices)

@synthesize facebook;

- (Facebook *)facebook
{
	if (!facebook) {
		facebook = [[Facebook alloc] init];
	}
	
	return facebook;
}

- (void)authorizeForPermissions:(NSArray *)permissions
{
	[self.facebook authorize:FacebookApplicationId permissions:permissions delegate:self];
}

#pragma mark -
#pragma mark FBSessionDelegate

- (void)fbDidLoginWithPermissions:(NSArray *)permissions;
{
	DLog(@"Facebook accessToken: %@", self.facebook.accessToken);
	
	[[APIServices sharedAPIServices]setFacebookAuthorizedForPemissions:permissions remove:FALSE];
	
	[[APIServices sharedAPIServices]registerWithAuthority:@"facebook" 
											  deviceToken:nil 
											  accessToken:self.facebook.accessToken
													  key:nil 
												   secret:nil];
	
	if (![APIServices sharedAPIServices].hasUsePictureKey) {
		// Todo
		[self askToSharePictures];
	}
	
	[[NSNotificationCenter defaultCenter]postNotificationName:FacebookNotification object:@"success"];
}

- (void)fbDidNotLogin:(BOOL)cancelled permissions:(NSArray *)permissions;
{
	DLog(@"Facebook did not login");
	
	[[APIServices sharedAPIServices]setFacebookAuthorizedForPemissions:permissions remove:TRUE];
	
	[[NSNotificationCenter defaultCenter]postNotificationName:FacebookNotification object:@"Unable to login to Facebook"];
}

- (void)fbDidLogout
{
	[[APIServices sharedAPIServices]removeAllFacebookAuthorizedPermissions];
	DLog(@"Facebook did logout");
}

#pragma mark -
#pragma mark PictureSharing

- (void)askToSharePictures
{	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook Pictures" 
													message:@"Would you like to submit your Facebook profile picture to be voted on?"
												   delegate:self 
										  cancelButtonTitle:@"No" 
										  otherButtonTitles:@"Yes", nil];
	[alert show];	
	[alert release];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

// TODO 
//For allowing sharing of profile photo:
//offline_access,user_photos

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0: {
			break;
		}
		case 1: {
			[APIServices sharedAPIServices].usePicture = TRUE;
			[[AppDelegate sharedAppDelegate]checkPreferences];
			break;
		}
		default:
			break;
	}
}

#pragma mark -
#pragma mark Deallo

- (void)dealloc {
	[facebook release];
	
    [super dealloc];
}


@end
