//
//  MobclixDemographicsViewController.m
//  MobclixDemo
//
//  Copyright 2010 Mobclix. All rights reserved.
//

#import "MobclixDemographicsViewController.h"
#import "MobclixDemographics.h"

@interface MobclixDemographicsViewController ()
- (void)showPicker:(BOOL)show animated:(BOOL)animated;
- (void)showDatePicker:(BOOL)show animated:(BOOL)animated;
@end


@implementation MobclixDemographicsViewController
@synthesize tableView=_tableView, datePicker=_datePicker, pickerView=_pickerView, stringTextField=_stringTextField, integerTextField=_integerTextField, pickerComponents, editingIndexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		sections = [[NSArray arrayWithObjects:
					[NSArray arrayWithObjects:
					 [NSMutableDictionary dictionaryWithObjectsAndKeys:
					  @"Birthday",@"title",
					  @"datePicker",@"type",
					 nil],
					 [NSMutableDictionary dictionaryWithObjectsAndKeys:
					  @"Education",@"title",
					  @"education",@"key",
					  @"picker",@"type",
					  [NSArray arrayWithObjects:@"Decline to State",@"High School",@"Some College",@"In College",@"Bachelor",@"Masters",@"Doctoral",nil],@"components",
					  nil],
					 [NSMutableDictionary dictionaryWithObjectsAndKeys:
					  @"Ethnicity",@"title",
					  @"picker",@"type",
					  [NSArray arrayWithObjects:@"Decline to State",@"Mixed",@"Asian",@"Black",@"Hispanic",@"Native American",@"White",nil],@"components",
					  nil],
					 [NSMutableDictionary dictionaryWithObjectsAndKeys:
					  @"Gender",@"title",
					  @"picker",@"type",
					  [NSArray arrayWithObjects:@"Decline to State",@"Male",@"Female",nil],@"components",
					  nil],
					 [NSMutableDictionary dictionaryWithObjectsAndKeys:
					  @"Dating Gender",@"title",
					  @"picker",@"type",
					  [NSArray arrayWithObjects:@"Decline to State",@"Male",@"Female",@"Both",nil],@"components",
					  nil],
					 [NSMutableDictionary dictionaryWithObjectsAndKeys:
					  @"Income",@"title",
					  @"integer",@"type",
					  nil],
					 [NSMutableDictionary dictionaryWithObjectsAndKeys:
					  @"Marital Status",@"title",
					  @"picker",@"type",
					  [NSArray arrayWithObjects:@"Decline to State",@"Single, Available",@"Single, Unavailable",@"Married",nil],@"components",
					  nil],
					 [NSMutableDictionary dictionaryWithObjectsAndKeys:
					  @"Religion",@"title",
					  @"picker",@"type",
					  [NSArray arrayWithObjects:@"Decline to State",@"Buddhism",@"Christianity",@"Hinduism",@"Islam",@"Judaism",@"Unaffiliated",@"Other",nil],@"components",
					  nil],
					 nil],
					 [NSArray arrayWithObjects:
					  [NSMutableDictionary dictionaryWithObjectsAndKeys:
					   @"Area Code",@"title",
					   @"integer",@"type",
					   nil],
					  [NSMutableDictionary dictionaryWithObjectsAndKeys:
					   @"City",@"title",
					   @"string",@"type",
					   nil],
					  [NSMutableDictionary dictionaryWithObjectsAndKeys:
					   @"Country",@"title",
					   @"string",@"type",
					   nil],
					  [NSMutableDictionary dictionaryWithObjectsAndKeys:
					   @"DMA",@"title",
					   @"integer",@"type",
					   nil],
					  [NSMutableDictionary dictionaryWithObjectsAndKeys:
					   @"Metro Code",@"title",
					   @"integer",@"type",
					   nil],
					  [NSMutableDictionary dictionaryWithObjectsAndKeys:
					   @"Postal Code",@"title",
					   @"string",@"type",
					   nil],
					  [NSMutableDictionary dictionaryWithObjectsAndKeys:
					   @"Region",@"title",
					   @"string",@"type",
					   nil],
					  nil],
					 nil] retain];
		
		self.title = @"Demographics";
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveDemographics)] autorelease];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	}
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.tableView.frame = self.view.bounds;

	[self.datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:self.integerTextField];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:self.stringTextField];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self showPicker:NO animated:NO];
	[self showDatePicker:NO animated:NO];
}

- (id)demographicValueForKey:(NSString*)key {
	key = [key lowercaseString];
	
	for(NSArray* section in sections) {
		for(NSDictionary* row in section) {
			if([key isEqualToString:[[[row objectForKey:@"title"] stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString]]) {
				return [row objectForKey:@"value"];
			}
		}
	}
	
	return nil;
}

- (void)saveDemographics {
	MCDemographics demographics;
	demographics.areaCode = [[self demographicValueForKey:@"areaCode"] integerValue];
	demographics.city = [[self demographicValueForKey:@"city"] UTF8String];
	demographics.country = [[self demographicValueForKey:@"country"] UTF8String];
	demographics.datingGender = [[self demographicValueForKey:@"datingGender"] integerValue];
	demographics.dmaCode = [[self demographicValueForKey:@"dma"] integerValue];
	demographics.education = [[self demographicValueForKey:@"education"] integerValue];
	demographics.ethnicity = [[self demographicValueForKey:@"ethnicity"] integerValue];
	demographics.gender = [[self demographicValueForKey:@"gender"] integerValue];
	demographics.income = [[self demographicValueForKey:@"income"] integerValue];
	demographics.maritalStatus = [[self demographicValueForKey:@"maritalStatus"] integerValue];
	demographics.metroCode = [[self demographicValueForKey:@"metroCode"] integerValue];
	demographics.postalCode = [[self demographicValueForKey:@"postalCode"] UTF8String];
	demographics.regionCode = [[self demographicValueForKey:@"region"] UTF8String];
	demographics.religion = [[self demographicValueForKey:@"religion"] integerValue];
	demographics.latitude = 0.0;
	demographics.longitude = 0.0;
	[MobclixDemographics updateDemographics:demographics birthday:dateSet ? self.datePicker.date : nil];
}

- (void)dateChanged {
	dateSet = YES;
	[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)textChanged:(NSNotification*)notification {
	[[[sections objectAtIndex:self.editingIndexPath.section] objectAtIndex:self.editingIndexPath.row] setObject:[[notification object] text] forKey:@"value"];
	[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.editingIndexPath] withRowAnimation:UITableViewRowAnimationNone];
	[self.tableView scrollToRowAtIndexPath:self.editingIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

#pragma mark -
#pragma mark Keyboard Management

- (void)keyboardWillShow:(NSNotification*)notification {
	CGRect keyboardBounds = [[[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
	[self showPicker:NO animated:NO];
	self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, keyboardBounds.size.height, 0.0f);
	self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0f, 0.0f, keyboardBounds.size.height, 0.0f);
	[UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification*)notification {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
	self.tableView.contentInset = UIEdgeInsetsZero;
	self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return sections.count;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [[sections objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString* CellIdentifier = @"CellIdentifier";
	
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cell.textLabel.text = [[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
	
	if(indexPath.section == 0 && indexPath.row == 0) {
		if(dateSet) {
			NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
			[formatter setDateStyle:NSDateFormatterMediumStyle];
			[formatter setTimeStyle:NSDateFormatterNoStyle];
			cell.detailTextLabel.text = [formatter stringFromDate:self.datePicker.date];
			[formatter release];
		}
	} else {
		NSDictionary* rowObj = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		if([[rowObj objectForKey:@"type"] isEqualToString:@"picker"]) {
			if([rowObj objectForKey:@"value"]) {
				cell.detailTextLabel.text = [[rowObj objectForKey:@"components"] objectAtIndex:[[rowObj objectForKey:@"value"] integerValue]];
			} else {
				cell.detailTextLabel.text = @"";
			}
		} else if([[rowObj objectForKey:@"type"] isEqualToString:@"integer"] || [[rowObj objectForKey:@"type"] isEqualToString:@"string"]) {
			if([rowObj objectForKey:@"value"]) {
				cell.detailTextLabel.text = [rowObj objectForKey:@"value"];
			} else {
				cell.detailTextLabel.text = @"";
			}
		}
	}
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(section == 0) {
		return @"Personal";
	} else if(section == 1) {
		return @"Geographic";
	} else {
		return nil;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if([self.editingIndexPath isEqual:indexPath]) {
		[tableView deselectRowAtIndexPath:indexPath animated:NO];
		return;
	}
	
	self.editingIndexPath = indexPath;

	NSMutableDictionary* rowObj = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
	if([[rowObj objectForKey:@"type"] isEqualToString:@"datePicker"]) {
		[self.integerTextField resignFirstResponder];
		[self.stringTextField resignFirstResponder];
		[self showDatePicker:YES animated:YES];
		[self.datePicker sendActionsForControlEvents:UIControlEventValueChanged];
	} else if([[rowObj objectForKey:@"type"] isEqualToString:@"picker"]) {
		self.pickerComponents = [rowObj objectForKey:@"components"];
		
		if(![rowObj objectForKey:@"value"]) {
			[rowObj setObject:[NSNumber numberWithInteger:0] forKey:@"value"];
		}

		[self.pickerView selectRow:[[rowObj objectForKey:@"value"] integerValue] inComponent:0 animated:NO];
		[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.editingIndexPath] withRowAnimation:UITableViewRowAnimationNone];
		
		[self.pickerView reloadAllComponents];
		[self.integerTextField resignFirstResponder];
		[self.stringTextField resignFirstResponder];
		[self showPicker:YES animated:YES];
	} else if([[rowObj objectForKey:@"type"] isEqualToString:@"string"]) {
		self.stringTextField.text = [rowObj objectForKey:@"value"] ? [rowObj objectForKey:@"value"] : @"";
		[self.stringTextField becomeFirstResponder];
	} else if([[rowObj objectForKey:@"type"] isEqualToString:@"integer"]) {
		self.integerTextField.text = [rowObj objectForKey:@"value"] ? [rowObj objectForKey:@"value"] : @"";
		[self.integerTextField becomeFirstResponder];
	}
	
	[tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Picker View

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return self.pickerComponents.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [self.pickerComponents objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	[[[sections objectAtIndex:self.editingIndexPath.section] objectAtIndex:self.editingIndexPath.row] setObject:[NSNumber numberWithInteger:row] forKey:@"value"];
	[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.editingIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -
#pragma mark Drawers

- (void)showPicker:(BOOL)show animated:(BOOL)animated {
	if(animated) [UIView beginAnimations:nil context:NULL];
	
	CGRect bounds = self.view.bounds;

	if(show) {
		self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, self.pickerView.frame.size.height, 0.0f);
		self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0f, 0.0f, self.pickerView.frame.size.height, 0.0f);
		self.pickerView.frame = CGRectMake(0.0f, bounds.size.height-self.pickerView.frame.size.height, bounds.size.width, self.pickerView.frame.size.height);
	} else {
		self.tableView.contentInset = UIEdgeInsetsZero;
		self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
		self.pickerView.frame = CGRectMake(0.0f, bounds.size.height, bounds.size.width, self.pickerView.frame.size.height);
	}

	self.datePicker.frame = CGRectMake(0.0f, bounds.size.height, bounds.size.width, self.datePicker.frame.size.height);
	
	if(animated) [UIView commitAnimations];
}

- (void)showDatePicker:(BOOL)show animated:(BOOL)animated {
	if(animated) [UIView beginAnimations:nil context:NULL];
	
	CGRect bounds = self.view.bounds;
	
	if(show) {
		self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, self.datePicker.frame.size.height, 0.0f);
		self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0f, 0.0f, self.datePicker.frame.size.height, 0.0f);
		self.datePicker.frame = CGRectMake(0.0f, bounds.size.height-self.datePicker.frame.size.height, bounds.size.width, self.datePicker.frame.size.height);
	} else {
		self.tableView.contentInset = UIEdgeInsetsZero;
		self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
		self.datePicker.frame = CGRectMake(0.0f, bounds.size.height, bounds.size.width, self.datePicker.frame.size.height);
	}

	self.pickerView.frame = CGRectMake(0.0f, bounds.size.height, bounds.size.width, self.pickerView.frame.size.height);
	
	if(animated) [UIView commitAnimations];
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[super viewDidUnload];

	self.tableView = nil;
	self.pickerView = nil;
	self.datePicker = nil;
	self.editingIndexPath = nil;
	self.integerTextField = nil;
	self.stringTextField = nil;
}


- (void)dealloc {
	self.tableView = nil;
	self.pickerView = nil;
	self.datePicker = nil;
	self.editingIndexPath = nil;
	self.integerTextField = nil;
	self.stringTextField = nil;
	
	[sections release];

    [super dealloc];
}


@end
