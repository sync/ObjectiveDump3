//
//  MobclixCommentViewController.m
//  Mobclix iOS SDK Demo
//
//  Copyright 2010 Mobclix. All rights reserved.
//

#import "MobclixCommentViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation MobclixCommentViewController
@synthesize textView, sendingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		feedback = [[MobclixFeedback alloc] init];
		feedback.delegate = self;
	}
	
	return self;
}

- (BOOL)isCommentEmpty {
	return [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0;
}

- (void)sendComment:(id)sender {
	if([self isCommentEmpty]) {
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must enter a comment before sending." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Try Again",nil];
		[alertView show];
		[alertView autorelease];
		return;
	}
	
	[self showSendingView:YES];

	[feedback sendComment:self.textView.text];
}

#pragma mark -
#pragma mark View management

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Comment";
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	self.textView.layer.cornerRadius = 6.0f;
	self.textView.layer.borderWidth = 1.0;
	self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;


	self.sendingView.layer.cornerRadius = 6.0f;
	self.sendingView.layer.borderWidth = 1.0;
	self.sendingView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendComment:)] autorelease];
	self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.textView becomeFirstResponder];
}

- (void)showSendingView:(BOOL)shouldShow {
	UIView* fromView = self.textView;
	UIView* toView = self.sendingView;
	UIViewAnimationTransition transition = UIViewAnimationTransitionFlipFromRight;
	
	if(!shouldShow) {
		fromView = self.sendingView;
		toView = self.textView;
		transition = UIViewAnimationTransitionFlipFromLeft;
	}
		
	UIView* parentView = fromView.superview;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationTransition:transition forView:parentView cache:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.6];
	
	[parentView exchangeSubviewAtIndex:[parentView.subviews indexOfObject:fromView] withSubviewAtIndex:[parentView.subviews indexOfObject:toView]];
	
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark MobclixFeedback

- (void)mobclixFeedbackSentComment:(MobclixFeedback*)f {
	self.textView.text = @"";
	[self showSendingView:NO];
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Your comment has been sent!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
	[alertView show];
	[alertView autorelease];
}

- (void)mobclixFeedbackFailedToSendComment:(MobclixFeedback*)f withError:(NSError*)error {
	[self showSendingView:NO];
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Try Again",nil];
	[alertView show];
	[alertView autorelease];
}

#pragma mark -
#pragma mark Text view delegate

- (void)textViewDidChange:(UITextView *)tV {
	// Auto enable send button
	self.navigationItem.rightBarButtonItem.enabled = ![self isCommentEmpty];
}

- (BOOL)textView:(UITextView *)tV shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	return !feedback.sendingComment;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.textView = nil;
	self.sendingView = nil;
}


- (void)dealloc {
	feedback.delegate = nil;
	[feedback release], feedback = nil;
	
    [super dealloc];
}


@end
