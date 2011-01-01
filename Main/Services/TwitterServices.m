#import "TwitterServices.h"
#import "OAuth+UserDefaults.h"

@implementation TwitterServices

SYNTHESIZE_SINGLETON_FOR_CLASS(TwitterServices)

@synthesize oAuth, loginPopup;

- (OAuth *)oAuth
{
	if (!oAuth) {
		oAuth = [[OAuth alloc] initWithConsumerKey:OAUTH_CONSUMER_KEY andConsumerSecret:OAUTH_CONSUMER_SECRET];
	}
	
	return oAuth;
}

- (CustomLoginPopup *)loginPopup
{
	if (!loginPopup) {
		loginPopup = [[CustomLoginPopup alloc] initWithNibName:@"TwitterLoginPopup" bundle:nil];        
		loginPopup.oAuth = self.oAuth;
		loginPopup.delegate = self;
		loginPopup.uiDelegate = self;
	}
	
	return loginPopup;
}

- (BOOL)authorizeInNavController:(UINavigationController *)navController
{
	if (!self.oAuth.oauth_token_authorized) {
		//[self.oAuth	loadOAuthTwitterContextFromUserDefaults];
		UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:self.loginPopup]autorelease];
		[navController presentModalViewController:nav animated:YES];
		return FALSE;
	}
	
	return TRUE;
}

#pragma mark -
#pragma mark TwitterLoginPopupDelegate

- (void)twitterLoginPopupDidCancel:(TwitterLoginPopup *)popup {
    [self.loginPopup dismissModalViewControllerAnimated:YES];        
    [loginPopup release]; loginPopup = nil; // was retained as ivar in "login"
	
	[APIServices sharedAPIServices].twitterAuthorized = FALSE;
	[[NSNotificationCenter defaultCenter]postNotificationName:TwitterNotification object:@"Unable to login to Twitter"];
}

- (void)twitterLoginPopupDidAuthorize:(TwitterLoginPopup *)popup {
    [self.loginPopup dismissModalViewControllerAnimated:YES];        
    [loginPopup release]; 
	loginPopup = nil;
    [oAuth saveOAuthTwitterContextToUserDefaults];
}

#pragma mark -
#pragma mark TwitterLoginUiFeedback

- (void) tokenRequestDidStart:(TwitterLoginPopup *)twitterLogin {
    DLog(@"token request did start");
    [loginPopup.activityIndicator startAnimating];
}

- (void) tokenRequestDidSucceed:(TwitterLoginPopup *)twitterLogin {
    DLog(@"token request did succeed");    
    [loginPopup.activityIndicator stopAnimating];
}

- (void) tokenRequestDidFail:(TwitterLoginPopup *)twitterLogin {
    DLog(@"token request did fail");
    [loginPopup.activityIndicator stopAnimating];
}

- (void) authorizationRequestDidStart:(TwitterLoginPopup *)twitterLogin {
    DLog(@"authorization request did start");    
    [loginPopup.activityIndicator startAnimating];
}

- (void) authorizationRequestDidSucceed:(TwitterLoginPopup *)twitterLogin {
    DLog(@"Twitter oauth_token: %@", self.oAuth.oauth_token);

    [loginPopup.activityIndicator stopAnimating];
	
	[APIServices sharedAPIServices].twitterAuthorized = TRUE;
	
	[[APIServices sharedAPIServices]registerWithAuthority:@"twitter" 
											  deviceToken:nil 
											  accessToken:nil
													  key:self.oAuth.oauth_token 
												   secret:self.oAuth.oauth_token_secret];
	
	[[NSNotificationCenter defaultCenter]postNotificationName:TwitterNotification object:@"success"];
}

- (void) authorizationRequestDidFail:(TwitterLoginPopup *)twitterLogin {
    DLog(@"token request did fail");
    [loginPopup.activityIndicator stopAnimating];
	
	[APIServices sharedAPIServices].twitterAuthorized = FALSE;
	
	[[NSNotificationCenter defaultCenter]postNotificationName:TwitterNotification object:@"Unable to login to Twitter"];
}

- (void)dealloc {
	[loginPopup release];
	[oAuth release];
	
    [super dealloc];
}


@end
