//
//  AppDelegate.m
//  LearnTexture
//
//  Created by cello on 2018/8/2.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    MasterViewController *master = [[MasterViewController alloc] init];
    ASNavigationController *navigationController = [[ASNavigationController alloc] initWithRootViewController:master];
    UIWindow *keyWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    keyWindow.rootViewController = navigationController;
    [keyWindow makeKeyAndVisible];
    self.window = keyWindow;
    return YES;
}



@end
