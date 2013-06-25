//
//  Huisgenoten_ApplicationTests.m
//  Huisgenoten_ApplicationTests
//
//  Created by Myrthe Bil on 6/25/13.
//
//

#import "Huisgenoten_ApplicationTests.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface Huisgenoten_ApplicationTests ()

//private properties
@property (nonatomic, readwrite, weak) AppDelegate *appDelegate;
@property (strong, nonatomic) ViewController *controller;
@property (nonatomic, readwrite, weak) UIWindow *window;

@end

@implementation Huisgenoten_ApplicationTests

@synthesize appDelegate=_appDelegate;
@synthesize controller=_controller;
@synthesize window=_window;

- (void)setUp
{
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mainstoryboard" bundle:nil];
    self.controller = [storyboard instantiateViewControllerWithIdentifier:@"Huisgenoten"];
    [self.controller performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
}

@end
