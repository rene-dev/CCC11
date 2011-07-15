//
//  ReminderView.m
//  27C3
//
//  Created by Philip Brechler on 08.12.10.
//  Copyright 2010 TimeCoast Communications. All rights reserved.
//

#import "ReminderView.h"
#import "Event.h"

@implementation ReminderView

@synthesize aEvent;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Reminder";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (aEvent != nil) {
        [self setReminder];
    }
}

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

-(void)setReminder{
	NSString *title = @"Add Reminder?";
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:@"Do you want to add a 15 minutes reminder for this event?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
	[alertView show];
	[alertView release];
	 
}	

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 1)
	{
		NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
		
		// Get the current date
		NSString *eventTimeString = [[aEvent.date stringByAppendingString:@" "]stringByAppendingString:aEvent.start];
		NSDateFormatter *df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"yyyy-MM-dd HH:mm"];
		NSDate *theDate = [df dateFromString: eventTimeString];
        [df release];
		//NSDate *pickerDate = [theDate dateByAddingTimeInterval:2700];
		NSDate *pickerDate = [[NSDate alloc] initWithTimeInterval:2700 sinceDate:theDate];
		
		// Break the date up into components
		NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
													   fromDate:pickerDate];
		NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
													   fromDate:pickerDate];
        [pickerDate release];
		// Set up the fire time
		NSDateComponents *dateComps = [[NSDateComponents alloc] init];
		[dateComps setDay:[dateComponents day]];
		[dateComps setMonth:[dateComponents month]];
		[dateComps setYear:[dateComponents year]];
		[dateComps setHour:[timeComponents hour]];
		// Notification will fire in one minute
		[dateComps setMinute:[timeComponents minute]];
		[dateComps setSecond:[timeComponents second]];
		NSDate *itemDate = [calendar dateFromComponents:dateComps];
		[dateComps release];
		
		UILocalNotification *localNotif = [[UILocalNotification alloc] init];
		if (localNotif == nil)
			return;
		localNotif.fireDate = itemDate;
		localNotif.timeZone = [NSTimeZone timeZoneWithName:@"Europe/Berlin"];
		localNotif.hasAction = YES;
		localNotif.alertAction = @"View";
		
		// Notification details
		localNotif.alertBody = [[@"Event #" stringByAppendingFormat:@"%i",aEvent.eventID]stringByAppendingString:@" will beginn in 15 minutes"];
		// Set the action button
		
		localNotif.soundName = @"scifi.caf";
		localNotif.applicationIconBadgeNumber = 1;
		
		// Specify custom data for the notification
		NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"theEvent" forKey:@"eventID"];
		localNotif.userInfo = infoDict;
		
		// Schedule the notification
		[[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
		[localNotif release];
		[self.tableView reloadData];
	}
	
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *notif = [notificationArray objectAtIndex:indexPath.row];
	
    // Display notification info
    [cell.textLabel setText:notif.alertBody];
    [cell.detailTextLabel setText:[notif.fireDate description]];
	cell.detailTextLabel.textColor = [UIColor colorWithWhite:1.000 alpha:1.000];
	cell.textLabel.textColor = [UIColor colorWithRed:0.074 green:1.000 blue:0.001 alpha:1.000];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
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



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
		UILocalNotification *notif = [notificationArray objectAtIndex:indexPath.row];
		[[UIApplication sharedApplication] cancelLocalNotification:notif]; 
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[aEvent release];
    [super dealloc];
}


@end

