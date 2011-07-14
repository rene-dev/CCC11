//
//  Book.m
//  XML
//
//  Created by iPhone SDK Articles on 11/23/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import "Event.h"


@implementation Event

@synthesize title, room, abstract, description, eventID, subtitle, start, duration,date,language,track;



- (void) dealloc {
	
	[abstract release];
    [description release];
	[subtitle release];
	[start release];
	[duration release];
	[room release];
	[title release];
	[date release];
	[language release];
	[track release];
	[super dealloc];
	
}

@end
