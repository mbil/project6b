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

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // ****************************************************************************
    // Fill in with your Parse and Twitter credentials. Don't forget to add your
    // Facebook id in Info.plist:
    // ****************************************************************************
    [Parse setApplicationId:@"r2zaUDtxWicSkoo6wBUjFQCprvbGaoyaqICRBTaS" clientKey:@"iLS0xLQQJw1X2mqRHcblBqeQ4BNi5pDhxjeTgxht"];
    
    // Set default ACLs
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];

    SubclassConfigViewController *controller = [[SubclassConfigViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = controller;
    
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[SubclassConfigViewController alloc] init]];
//    self.window.backgroundColor = [UIColor orangeColor];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Handle an interruption during the authorization flow, such as the user clicking the home button.
}

@end
