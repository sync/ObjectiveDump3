//
//  MobclixRatingViewController.m
//  Mobclix iOS SDK Demo
//
//  Copyright 2010 Mobclix. All rights reserved.
//

#import "MobclixRatingViewController.h"


@interface MobclixRatingControl : UIControl {
@private
	NSUInteger rating;
}

@property(nonatomic,assign) NSUInteger rating;
@end


@implementation MobclixRatingViewController
@synthesize tableView, sendingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		feedback = [[MobclixFeedback alloc] init];
		feedback.delegate = self;
	}
	
	return self;
}

- (BOOL)hasAllRatings {
	return ratings.categoryA > 0 && ratings.categoryB > 0 && ratings.categoryC > 0 && ratings.categoryD > 0 && ratings.categoryE > 0;
}

- (void)sendRatings:(id)sender {
	if(![self hasAllRatings]) {
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a rating for all categories before sending." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Try Again",nil];
		[alertView show];
		[alertView autorelease];
		return;
	}
	
	[self showSendingView:YES];
	[self performSelector:@selector(reallySend) withObject:nil afterDelay:1.0];
}

- (void)reallySend {
	[feedback sendRatings:ratings];
}

- (void)updateRatings:(MobclixRatingControl*)control {
	switch(control.tag - 1000) {
		case 0:
			ratings.categoryA = control.rating;
			break;
		case 1:
			ratings.categoryB = control.rating;
			break;
		case 2:
			ratings.categoryC = control.rating;
			break;
		case 3:
			ratings.categoryD = control.rating;
			break;
		case 4:
			ratings.categoryE = control.rating;
			break;
	}
	
	self.navigationItem.rightBarButtonItem.enabled = [self hasAllRatings];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Ratings";
	self.tableView.alwaysBounceVertical = NO;
	self.tableView.alwaysBounceHorizontal = NO;
	self.tableView.directionalLockEnabled = YES;
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendRatings:)] autorelease];
	self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)showSendingView:(BOOL)shouldShow {
	self.sendingView.hidden = NO;

	if(shouldShow) {
		self.sendingView.alpha = 0.0f;
	}
	
	[UIView beginAnimations:nil context:NULL];
	
	if(!shouldShow) {
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(makeSendingHidden)];
	}
	
	self.sendingView.alpha = shouldShow ? 1.0f : 0.0f;
	[UIView commitAnimations];
}

- (void)makeSendingHidden {
	self.sendingView.hidden = YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tV cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tV dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Configure the cell...
	MobclixRatingControl* accessoryControl = [[MobclixRatingControl alloc] init];
	[accessoryControl addTarget:self action:@selector(updateRatings:) forControlEvents:UIControlEventValueChanged];
	accessoryControl.tag = indexPath.row + 1000;
	cell.accessoryView = accessoryControl;
	
	switch(indexPath.row) {
		case 0:
			cell.textLabel.text = @"Usability";
			cell.imageView.image = [UIImage imageNamed:@"ratings_usability.png"];
			accessoryControl.rating = ratings.categoryA;
			break;
		case 1:
			cell.textLabel.text = @"Appearance";
			cell.imageView.image = [UIImage imageNamed:@"ratings_appearance.png"];
			accessoryControl.rating = ratings.categoryB;
			break;
		case 2: 
			cell.textLabel.text = @"Recommend";
			cell.imageView.image = [UIImage imageNamed:@"ratings_recommend.png"];
			accessoryControl.rating = ratings.categoryC;
			break;
		case 3:
			cell.textLabel.text = @"Performance";
			cell.imageView.image = [UIImage imageNamed:@"ratings_performance.png"];
			accessoryControl.rating = ratings.categoryD;
			break;
		case 4:
			cell.textLabel.text = @"Overall";
			cell.imageView.image = [UIImage imageNamed:@"ratings_overall.png"];
			accessoryControl.rating = ratings.categoryE;
			break;
	}
    
 	[accessoryControl release];
	return cell;
}

#pragma mark -
#pragma mark MobclixFeedback

- (void)mobclixFeedbackSentRatings:(MobclixFeedback*)f {
	[self showSendingView:NO];
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Your ratings have been sent!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
	[alertView show];
	[alertView autorelease];
}

- (void)mobclixFeedbackFailedToSendRatings:(MobclixFeedback*)f withError:(NSError*)error {
	[self showSendingView:NO];
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Try Again",nil];
	[alertView show];
	[alertView autorelease];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	feedback.delegate = nil;
	[feedback release], feedback = nil;
    [super dealloc];
}


@end

#pragma mark -

@implementation MobclixRatingControl
@synthesize rating;

- (id)init {
	if((self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 125.0f, 24.0f)])) {
		for(NSUInteger index = 0; index < 5; index++) {
			UIImageView* star = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloat)index * 25.0f, 0.0f, 24.0f, 24.0f)];
			star.image = [UIImage imageNamed:@"ratings_off.png"];
			star.highlightedImage = [UIImage imageNamed:@"ratings.png"];
			[self addSubview:star];
			[star release];
		}
	}
	
	return self;
}

- (void)setRating:(NSUInteger)r {
	rating = r;
	
	NSUInteger index = 0;
	for(UIImageView* star in self.subviews) {
		if(![star isKindOfClass:[UIImageView class]]) continue;
		star.highlighted = index < rating;
		index++;
	}
}

- (void)updateWithPoint:(CGPoint)point {
	NSUInteger r = 0;
	
	for(UIView* view in self.subviews) {
		if(view.frame.origin.x > point.x) break;
		r++;
	}
	
	self.rating = r;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self updateWithPoint:[[touches anyObject] locationInView:self]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self updateWithPoint:[[touches anyObject] locationInView:self]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self updateWithPoint:[[touches anyObject] locationInView:self]];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self updateWithPoint:[[touches anyObject] locationInView:self]];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}


@end


