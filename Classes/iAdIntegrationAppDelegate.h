//
//  iAdIntegrationAppDelegate.h
//  iAdIntegration
//
//  Created by Andreas Katzian on 30.01.11.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@class iAdIntegrationViewController;

@interface iAdIntegrationAppDelegate : NSObject <UIApplicationDelegate, ADBannerViewDelegate> {
    UIWindow *window;
    iAdIntegrationViewController *viewController;
	BOOL iAdVisible;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iAdIntegrationViewController *viewController;

- (void) setupiAd;

@end

