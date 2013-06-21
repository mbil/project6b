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
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // ****************************************************************************
    // Fill in with your Parse credentials.
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
    //ViewController *viewController = [[ViewController alloc] init];
    //[self  presentViewController:viewController animated:YES completion:nil];
}

@end
