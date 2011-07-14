//
//  RootViewController.h
//  27C3
//
//  Created by Philip Brechler on 08.12.10.
//  Copyright 2010 TimeCoast Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshTableViewController.h"

@class _7C3AppDelegate, EventDetailView,HelpView;

@interface RootViewController : PullToRefreshTableViewController <UIAlertViewDelegate> {
	
	_7C3AppDelegate *appDelegate;
	EventDetailView *edvController;
	HelpView *hvController;
	
	NSMutableArray *firstDayArray;
	NSMutableArray *secondDayArray;
	NSMutableArray *thirdDayArray;
	NSMutableArray *fourthDayArray;
    NSMutableArray *fifthDayArray;


}

@property (nonatomic,retain) NSMutableArray *firstDayArray;
@property (nonatomic,retain) NSMutableArray *secondDayArray;
@property (nonatomic,retain) NSMutableArray *thirdDayArray;
@property (nonatomic,retain) NSMutableArray *fourthDayArray;
@property (nonatomic,retain) NSMutableArray *fifthDayArray;


-(void)organizeTheData;
- (IBAction)helpButtonPressed:(id)sender;

@end
