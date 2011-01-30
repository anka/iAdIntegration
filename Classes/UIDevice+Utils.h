//
//  UIDevice+Utils.h
//  FirstGame
//
//  Created by Andreas Katzian on 09.09.10.
//

#import <Foundation/Foundation.h>

#define IPAD [UIDevice isIPad]
#define IPHONE [UIDevice isIPhone]

@interface UIDevice(Utils)

+ (BOOL) isIPhone;
+ (BOOL) isIPad;
+ (BOOL) isIAdAvailable;

@end
