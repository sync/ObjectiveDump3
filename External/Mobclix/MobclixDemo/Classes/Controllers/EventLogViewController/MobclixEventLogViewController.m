#import "Mobclix.h"
#import "MobclixEventLogViewController.h"

#define DEFAULT_PROCESS_NAME		@"Default Process"
#define DEFAULT_EVENT_NAME			@"Some Event"
#define DEFAULT_EVENT_DESCRIPTION	@"Event Occurred"

@implementation MobclixEventLogViewController


#pragma mark MobclixEventLogViewController Methods

- (void) ClickLog{
	MobclixLogLevel logLevel = 1;
	switch ([pickerLog selectedRowInComponent: 0]) {
		case 0:		logLevel = LOG_LEVEL_DEBUG; break;
		case 1:		logLevel = LOG_LEVEL_INFO;	break;
		case 2:		logLevel = LOG_LEVEL_WARN; 	break;
		case 3:		logLevel = LOG_LEVEL_ERROR; break;
		case 4:		logLevel = LOG_LEVEL_FATAL; break;

	}
	
	NSString *processName = ([textProcessName.text length] != 0) ? textProcessName.text : DEFAULT_PROCESS_NAME;
	NSString *eventName = ([textEventName.text length] != 0) ? textEventName.text : DEFAULT_EVENT_NAME;
	NSString *description = ([textDescription.text length] != 0) ? textDescription.text : DEFAULT_EVENT_DESCRIPTION;
	
	//MOBCLIX! Log an event.
	[Mobclix logEventWithLevel: logLevel
				   processName: processName
					 eventName: eventName
				   description: description
						  stop: [swStop isOn]
	 ];
}


#pragma mark UIViewController Methods

- (void) viewDidLoad {
	self.title = @"Logging";
	self.navigationItem.prompt = @"Enter Event Information";
	
	UIBarButtonItem* btnLog = [[UIBarButtonItem alloc] initWithTitle: @"Log Event"
															   style: UIBarButtonItemStylePlain
															  target: self 
															  action: @selector(ClickLog)];
	[self.navigationItem setRightBarButtonItem:btnLog animated: NO];
	[btnLog release];
	
	textProcessName.text = DEFAULT_PROCESS_NAME;
	textEventName.text = DEFAULT_EVENT_NAME;
	textDescription.text = DEFAULT_EVENT_DESCRIPTION;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textProcessName resignFirstResponder];
	[textEventName resignFirstResponder];
	[textDescription resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}

- (void)dealloc {
	[textDescription release];
	[textEventName release];
	[textProcessName release];
	[pickerLog release];
	[super dealloc];
}


#pragma mark UIPickerViewDataSource Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return 5;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
	return 300;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	NSString *title = nil;
	
	switch (row) {
		case 0:		title = @"DEBUG";	break;
		case 1:		title = @"INFO";	break;
		case 2:		title = @"WARN";	break;
		case 3:		title = @"ERROR";	break;
		case 4:		title = @"FATAL";	break;
	} 
	
	return title;
}

@end
