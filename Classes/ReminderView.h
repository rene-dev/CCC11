//
//  ReminderView.h
//  27C3
//
//  Created by Philip Brechler on 08.12.10.
//  Copyright 2010 TimeCoast Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;

@interface ReminderView : UITableViewController <UIAlertViewDelegate> {
	
	Event *aEvent;
	
}

@property (nonatomic,retain) Event *aEvent;

-(void)setReminder;

@end
