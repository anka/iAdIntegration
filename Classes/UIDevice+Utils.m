//
//  UIDevice+Utils.m
//  FirstGame
//
//  Created by Andreas Katzian on 09.09.10.
//

#import "UIDevice+Utils.h"
#import <iAd/iAd.h>


@implementation UIDevice(Utils)

+ (BOOL) isIPhone
{
	if([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)])
		return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;

	return YES;
}

+ (BOOL) isIPad
{
	if([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)])
		return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;

	return NO;
}


+ (BOOL) isIAdAvailable
{
	if([UIDevice isIPad] == YES && &ADBannerContentSizeIdentifierPortrait == nil)
	{
		NSLog(@"iAd is not supported for this iPad version!");
		return NO;
	}
	else if(NSClassFromString(@"ADBannerView") == nil) 
	{
		NSLog(@"iAd is not supported for this iOS version");
		return NO;
	}
	
	return YES;
}


@end
