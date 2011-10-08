//
//  AppDelegate.h
//  UnkoYoke
//
//  Created by 松前 健太郎 on 11/10/08.
//  Copyright kenmaz.net 2011年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
