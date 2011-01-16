#import "CustomNavigationBar.h"

@interface CustomNavigationBar () 

@property (nonatomic, readonly) NSMutableDictionary *backgroundImagesDict;
@property (nonatomic, readonly) NSMutableDictionary *backButtonBackgroundImagesDict;
- (void)setupCustomInitialisation;

@end

@implementation CustomNavigationBar

@synthesize backgroundImagesDict, backButtonBackgroundImagesDict;

// The designated initializer. Override to perform setup that is required before the view is loaded.
// Only when xibless (interface buildder)
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Custom initialization
		[self setupCustomInitialisation];
    }
    return self;
}

// The designated initializer. Override to perform setup that is required before the view is loaded.
// Only when using xib (interface buildder)
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super initWithCoder:decoder]) {
		// Custom initialization
		[self setupCustomInitialisation];
	}
	return self;
}

- (void)setupCustomInitialisation
{
	// Initialization code
	// Nothing
}

#pragma mark -
#pragma mark BackgroundImage

- (NSMutableDictionary *)backgroundImagesDict
{
	if (!backgroundImagesDict) {
		backgroundImagesDict = [[NSMutableDictionary alloc]init];
	}
	
	return backgroundImagesDict;
}

- (UIImage *)backgroundImageForStyle:(UIBarStyle)aBarStyle
{
	return [self.backgroundImagesDict objectForKey:[NSNumber numberWithInteger:aBarStyle]];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarStyle:(UIBarStyle)aBarStyle;
{
	if (backgroundImage) {
		[self.backgroundImagesDict setObject:backgroundImage forKey:[NSNumber numberWithInteger:aBarStyle]];
	} else {
		[self.backgroundImagesDict removeObjectForKey:[NSNumber numberWithInteger:aBarStyle]];
	}
	
	[self setNeedsDisplay];
}

- (void)clearBackground
{
	[self.backgroundImagesDict removeAllObjects];
	[self setNeedsDisplay];
}

#pragma mark -
#pragma mark BackButtonBackgroundImage

- (NSMutableDictionary *)backButtonBackgroundImagesDict
{
	if (!backButtonBackgroundImagesDict) {
		backButtonBackgroundImagesDict = [[NSMutableDictionary alloc]init];
	}
	
	return backButtonBackgroundImagesDict;
}

- (UIImage *)backButtonBackgroundImageForStyle:(UIBarStyle)aBarStyle
{
	return [self.backButtonBackgroundImagesDict objectForKey:[NSNumber numberWithInteger:aBarStyle]];
}

- (void)setBackButtonBackgroundImage:(UIImage *)backgroundImage forBarStyle:(UIBarStyle)aBarStyle
{
	if (backgroundImage) {
		[self.backButtonBackgroundImagesDict setObject:backgroundImage forKey:[NSNumber numberWithInteger:aBarStyle]];
	} else {
		[self.backButtonBackgroundImagesDict removeObjectForKey:[NSNumber numberWithInteger:aBarStyle]];
	}
	
	[self setNeedsDisplay];
}

- (void)clearBackButtonBackground
{
	[self.backButtonBackgroundImagesDict removeAllObjects];
	[self setNeedsDisplay];
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    // Drawing code.
	UIImage *backgroundImage = [self backgroundImageForStyle:self.barStyle];
	if (backgroundImage) {
		[backgroundImage drawInRect:rect];
	} else {
		[super drawRect:rect];
	}
}

#pragma mark -
#pragma mark Actions

// Given the prpoer images and cap width, create a variable width back button
- (UIBarButtonItem *)backButtonForBackground:(UIImage*)backgroundImage 
							highlightedImage:(UIImage*)highlightedImage 
								leftCapWidth:(CGFloat)leftCapWidth
									  target:(id)target
									  action:(SEL)action
{
	backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:0.0];
	highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:0.0];

	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	
	button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
	button.titleLabel.textColor = [UIColor whiteColor];
	button.titleLabel.shadowOffset = CGSizeMake(0,-1);
	button.titleLabel.shadowColor = [UIColor darkGrayColor];
	button.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
	button.titleEdgeInsets = UIEdgeInsetsMake(0, leftCapWidth, 0, 3.0);
	button.frame = CGRectMake(0, 0, 0, backgroundImage.size.height);
	[button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
	[button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
	
	CGSize textSize = [self.topItem.title sizeWithFont:button.titleLabel.font];
	button.frame = CGRectMake(button.frame.origin.x, 
							  button.frame.origin.y, 
							  textSize.width + (leftCapWidth * 1.5), 
							  button.frame.size.height);
	
	[button setTitle:self.topItem.title forState:UIControlStateNormal];
	
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem = [[[UIBarButtonItem alloc]initWithCustomView:button]autorelease];
	
	return buttonItem;
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	[backButtonBackgroundImagesDict release];
	[backgroundImagesDict release];
	
    [super dealloc];
}


@end
