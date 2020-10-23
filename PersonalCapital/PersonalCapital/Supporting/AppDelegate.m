//
//  AppDelegate.m
//  PersonalCapital
//
//  Created by Jonathan Kopp on 10/21/20.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Add Nav Controller
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: homeVC];
    [navController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName: @"HelveticaNeue-Medium" size: 25]}];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
