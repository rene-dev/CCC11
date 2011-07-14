//
//  _7C3AppDelegate.m
//  27C3
//
//  Created by Philip Brechler on 08.12.10.
//  Copyright 2010 TimeCoast Communications. All rights reserved.
//

#import "_7C3AppDelegate.h"
#import "RootViewController.h"
#import "XMLParser.h"


@implementation _7C3AppDelegate

@synthesize window;
@synthesize navigationController, events;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	if([self connectedToNetwork] != NO){
		NSURL *url = [[NSURL alloc] initWithString:@"http://events.ccc.de/camp/2011/Fahrplan/schedule.en.xml"];
		NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
		//Initialize the delegate.
		XMLParser *parser = [[XMLParser alloc] initXMLParser];
	
		//Set delegate
		[xmlParser setDelegate:parser];
	
		//Start parsing the XML file.
		BOOL success = [xmlParser parse];
	
		if(success)
			NSLog(@"No Errors");
		else
			NSLog(@"Error Error Error!!!");
		}
		else {
			NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"scedule.en" ofType:@"xml"];
			NSURL *url = [NSURL fileURLWithPath:urlAddress];
			NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
			
			//Initialize the delegate.
			XMLParser *parser = [[XMLParser alloc] initXMLParser];
			
			//Set delegate
			[xmlParser setDelegate:parser];
			
			//Start parsing the XML file.
			BOOL success = [xmlParser parse];
			
			if(success)
				NSLog(@"No Errors");
			else
				NSLog(@"Error Error Error!!!");
			NSString *title = @"Warning!";
			UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:@"Using offline data." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alertView show];
			[alertView release];
		}
			
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
	
	 application.applicationIconBadgeNumber = 0;

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	application.applicationIconBadgeNumber = 0;

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (BOOL) connectedToNetwork
{
 	return ([NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.brechler-web.de/text.txt"] encoding:NSUTF8StringEncoding error:nil]!=NULL)?YES:NO;
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[events release];
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

