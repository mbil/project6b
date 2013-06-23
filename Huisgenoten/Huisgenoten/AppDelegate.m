//
//  AppDelegate.m
//  Huisgenoten
//
//  Created by Myrthe Bil & Miguel Pruijssers on 6/11/13.
//
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SubclassConfigViewController.h"
#import "ViewController.h"

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Parse setApplicationId:@"r2zaUDtxWicSkoo6wBUjFQCprvbGaoyaqICRBTaS" clientKey:@"iLS0xLQQJw1X2mqRHcblBqeQ4BNi5pDhxjeTgxht"];

    SubclassConfigViewController *controller = [[SubclassConfigViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = controller;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [PFUser logOut];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [PFUser logOut];
}

@end
