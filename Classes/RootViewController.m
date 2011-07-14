//
//  RootViewController.m
//  27C3
//
//  Created by Philip Brechler on 08.12.10.
//  Copyright 2010 TimeCoast Communications. All rights reserved.
//

#import "RootViewController.h"
#import "_7C3AppDelegate.h"
#import "Event.h"
#import "EventDetailView.h"
#import "HelpView.h"

@implementation RootViewController

@synthesize firstDayArray,secondDayArray,thirdDayArray,fourthDayArray,fifthDayArray;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
		
	self.firstDayArray = [NSMutableArray arrayWithCapacity:20];
	self.secondDayArray = [NSMutableArray arrayWithCapacity:20];
	self.thirdDayArray = [NSMutableArray arrayWithCapacity:20];
	self.fourthDayArray = [NSMutableArray arrayWithCapacity:20];
    self.fifthDayArray = [NSMutableArray arrayWithCapacity:20];
	appDelegate = (_7C3AppDelegate *)[[UIApplication sharedApplication] delegate];
	[self organizeTheData];
	self.title = @"27C3";


    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0)
	{
		exit(0);
	}
	
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStyleDone target:nil action:nil];
	
	self.navigationItem.backBarButtonItem = backBar;
	
	[backBar release];
	
	
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

-(void)organizeTheData{

	
	for (int i = 0; i<[appDelegate.events count]; i++) {
		Event *aEvent = [appDelegate.events objectAtIndex:i];
	
		if ([aEvent.date isEqualToString:@"2011-08-10"]){
			[self.firstDayArray addObject:aEvent];
		}
		if ([aEvent.date isEqualToString:@"2011-08-11"]){
			[self.secondDayArray addObject:aEvent];
		}	
		if ([aEvent.date isEqualToString:@"2011-08-12"]){
			[self.thirdDayArray addObject:aEvent];
		}		
		if ([aEvent.date isEqualToString:@"2011-08-13"]){
			[self.fourthDayArray addObject:aEvent];
		}
        if ([aEvent.date isEqualToString:@"2011-08-14"]){
			[self.fifthDayArray addObject:aEvent];
		}
				
		
	}
}

- (IBAction)helpButtonPressed:(id)sender{
	
	if(hvController == nil)
		hvController = [[HelpView alloc] initWithNibName:@"HelpView" bundle:[NSBundle mainBundle]];

	
	[self.navigationController pushViewController:hvController animated:YES];

}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	switch (section) {
		case 0:
			return @"2010-12-27";
			break;
		case 1:
			return @"2010-12-28";
			break;
		case 2:
			return @"2010-12-29";
			break;
		case 3:
			return @"2010-12-30";
			break;
	}
	return @"";
}

#define SectionHeaderHeight 14


- (CGFloat)tableView:(UITableView *)theTableView heightForHeaderInSection:(NSInteger)section {
    if ([self tableView:theTableView titleForHeaderInSection:section] != nil) {
        return SectionHeaderHeight;
    }
    else {
        // If no section header title, no section header needed
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)theTableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:theTableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
	
    // Create label with section title
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.frame = CGRectMake(0, 0, 320, 18);
    label.backgroundColor = [UIColor colorWithWhite:0.504 alpha:1.000];
    label.textColor = [UIColor colorWithRed:0.009 green:0.910 blue:0.059 alpha:1.000];
	label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Courier" size:12];;
    label.text = sectionTitle;
	
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, SectionHeaderHeight)];
    [view autorelease];
    [view addSubview:label];
	
    return view;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return [self.firstDayArray count];
			break;
		case 1:
			return [self.secondDayArray count];
			break;
		case 2:
			return [self.thirdDayArray count];
			break;
		case 3:
			return [self.fourthDayArray count];
			break;
		case 4:
			return [self.fifthDayArray count];
			break;
	}
	return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	Event *aEvent;
	switch (indexPath.section) {
		case 0:
			aEvent = [self.firstDayArray objectAtIndex:indexPath.row];
			break;
		case 1:
			aEvent = [self.secondDayArray objectAtIndex:indexPath.row];
			break;
		case 2:
			aEvent = [self.thirdDayArray objectAtIndex:indexPath.row];
			break;
		case 3:
			aEvent = [self.fourthDayArray objectAtIndex:indexPath.row];
			break;
		case 4:
			aEvent = [self.fifthDayArray objectAtIndex:indexPath.row];
			break;

	}
	UIImage *trackColor = [UIImage imageNamed:@"community.png"];
	if ([aEvent.track isEqualToString:@"Culture"]){
		trackColor = [UIImage imageNamed:@"culture.png"];
	}
	else if ([aEvent.track isEqualToString:@"Society"]){
		trackColor = [UIImage imageNamed:@"society.png"];
	}
	else if ([aEvent.track isEqualToString:@"Hacking"]){
		trackColor = [UIImage imageNamed:@"hacking.png"];
	}
	else if ([aEvent.track isEqualToString:@"Making"]){
		trackColor = [UIImage imageNamed:@"making.png"];
	}
	else if ([aEvent.track isEqualToString:@"Science"]){
		trackColor = [UIImage imageNamed:@"science.png"];
	}
	
	
	
	NSString *detailString = [[[@"Time: " stringByAppendingString:aEvent.start]stringByAppendingString:@" - Room: "]stringByAppendingString:aEvent.room];
	cell.textLabel.text = aEvent.title;
	cell.detailTextLabel.text = detailString;
	cell.imageView.image = trackColor;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.detailTextLabel.textColor = [UIColor colorWithWhite:1.000 alpha:1.000];
	cell.textLabel.textColor = [UIColor colorWithRed:0.074 green:1.000 blue:0.001 alpha:1.000];
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	cell.textLabel.font = [UIFont fontWithName:@"Courier-Bold" size:15];
	cell.detailTextLabel.font = [UIFont fontWithName:@"Courier" size:10];
	
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(edvController == nil)
		edvController = [[EventDetailView alloc] initWithNibName:@"EventDetailView" bundle:[NSBundle mainBundle]];
	
	Event *aEvent;
	
	switch (indexPath.section) {
		case 0:
			aEvent = [self.firstDayArray objectAtIndex:indexPath.row];
			break;
		case 1:
			aEvent = [self.secondDayArray objectAtIndex:indexPath.row];
			break;
		case 2:
			aEvent = [self.thirdDayArray objectAtIndex:indexPath.row];
			break;
		case 3:
			aEvent = [self.fourthDayArray objectAtIndex:indexPath.row];
			break;
		case 4:
			aEvent = [self.fifthDayArray objectAtIndex:indexPath.row];
			break;
			
	}
	
	edvController.aEvent = aEvent;
	
	[self.navigationController pushViewController:edvController animated:YES];
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
	[self.firstDayArray release];
	[self.secondDayArray release];
	[self.thirdDayArray release];
	[self.fourthDayArray release];
    [self.fifthDayArray release];
	[appDelegate release];
    [super dealloc];
}


@end

