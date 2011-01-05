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

- (BOOL)authorize
{
	if (![self.facebook isSessionValid]) {
		[self.facebook authorize:FacebookApplicationId permissions:[NSArray arrayWithObjects:@"publish_stream", @"offline_access", @"user_about_me", @"user_photos", nil] delegate:self];
		return FALSE;
	}
	
	return TRUE;
}

#pragma mark -
#pragma mark FBSessionDelegate

- (void)fbDidLogin;
{
	DLog(@"Facebook accessToken: %@", self.facebook.accessToken);
	
	[APIServices sharedAPIServices].facbookAuthorized = TRUE;
	
	[[APIServices sharedAPIServices]registerWithAuthority:@"facebook" 
											  deviceToken:nil 
											  accessToken:self.facebook.accessToken
													  key:nil 
												   secret:nil];
	
	if (![APIServices sharedAPIServices].hasUsePictureKey) {
		[self askToSharePictures];
	}
	
	[[NSNotificationCenter defaultCenter]postNotificationName:FacebookNotification object:@"success"];
}

- (void)fbDidNotLogin:(BOOL)cancelled;
{
	DLog(@"Facebook did not login");
	
	[APIServices sharedAPIServices].facbookAuthorized = FALSE;
	
	[[NSNotificationCenter defaultCenter]postNotificationName:FacebookNotification object:@"Unable to login to Facebook"];
}

- (void)fbDidLogout
{
	[APIServices sharedAPIServices].facbookAuthorized = FALSE;
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
