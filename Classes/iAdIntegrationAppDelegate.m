//
//  iAdIntegrationAppDelegate.m
//  iAdIntegration
//
//  Created by Andreas Katzian on 30.01.11.
//

#import "iAdIntegrationAppDelegate.h"
#import "iAdIntegrationViewController.h"
#import "UIDevice+Utils.h"

@implementation iAdIntegrationAppDelegate

@synthesize window;
@synthesize viewController;

#pragma mark -
#pragma mark iAd setup methods

- (void) setupiAd
{
	if([UIDevice isIAdAvailable] == NO)
		return;
	
	// Initialize a new iAd banner view
	ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
	
	// Set the delegate and hide the view initially
	adView.delegate		= self;
	adView.hidden		= YES;
	
	// Different iOS versions support different view sizes
	// but we just wanna add a portrait ad view
	if(&ADBannerContentSizeIdentifierPortrait != nil) 
		// Size identifier for IPAD + IPHONE
		adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
	else 
		// Size identifier only for IPHONE
		adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
	
	// Move the banner view to the background (across the screen top)
	adView.frame	= CGRectOffset(adView.frame, 0, -adView.frame.size.height);
	adView.hidden	= NO;
	
	// Add the banner to the current view
	[viewController.view addSubview:adView];
	[adView release];
	
	// Set status of iAd banner
	iAdVisible = NO;
}



- (void) hideBannerView:(ADBannerView*)banner
{
	if (!iAdVisible)
		return;
		
	[UIView beginAnimations:@"animateAdBannerHide" context:NULL];
	
	// Assumes the banner view is placed at the top of the screen.
	banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
	[UIView commitAnimations];
	
	// Update visibility state
	iAdVisible = NO;
}

- (void) showBannerView:(ADBannerView*)banner
{
	if (iAdVisible)
		return;
	
	[UIView beginAnimations:@"animateAdBannerShow" context:NULL];
	
	// Assumes the banner view is just across the top of the screen.
	banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
	[UIView commitAnimations];
	
	// Update visibility state
	iAdVisible = YES;
}


#pragma mark -
#pragma mark iAd delegate methods


// This method is invoked each time a banner loads a new advertisement. Once a banner has loaded an ad, 
// it will display that ad until another ad is available. The delegate might implement this method if 
// it wished to defer placing the banner in a view hierarchy until the banner has content to display.
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
	[self showBannerView:banner];
}

// This method will be invoked when an error has occurred attempting to get advertisement content. 
// The ADError enum lists the possible error codes.
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	// In any error case hide the banner
	[self hideBannerView:banner];
	
	NSLog(@"ADBannerView didFailToReceiveAdWithError: %d, %@, %@", 
		  [error code], 
		  [error domain], 
		  [error localizedDescription]);
}

// This message will be sent when the user taps on the banner and some action is to be taken.
// Actions either display full screen content in a modal session or take the user to a different
// application. The delegate may return NO to block the action from taking place, but this
// should be avoided if possible because most advertisements pay significantly more when 
// the action takes place and, over the longer term, repeatedly blocking actions will 
// decrease the ad inventory available to the application. Applications may wish to pause video, 
// audio, or other animated content while the advertisement's action executes.
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
	return YES;
}

// This message is sent when a modal action has completed and control is returned to the application. 
// Games, media playback, and other activities that were paused in response to the beginning
// of the action should resume at this point.
- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
}



#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

	[self setupiAd];
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
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


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
