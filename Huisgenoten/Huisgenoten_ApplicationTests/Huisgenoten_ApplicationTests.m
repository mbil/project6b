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
#import "ShoppinglistViewController.h"
#import "AddItemViewController.h"

@interface Huisgenoten_ApplicationTests ()

//private properties
@property (nonatomic, readwrite, weak) AppDelegate *appDelegate;
@property (strong, nonatomic) AddItemViewController *addItemController;
@property (nonatomic, readwrite, weak) UIWindow *window;

@end

@implementation Huisgenoten_ApplicationTests

@synthesize appDelegate=_appDelegate;
@synthesize addItemController=_addItemController;
@synthesize window=_window;

- (void)setUp
{
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.addItemController = [storyboard instantiateViewControllerWithIdentifier:@"AddItem"];
    [self.addItemController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
}

- (void) testAppDelegate
{
    STAssertNotNil(self.appDelegate, @"Cannot find the application delegate");
}

-(void) testAddItem {
    [self.addItemController.nameField performSelectorOnMainThread:@selector(setText:) withObject:@"foo" waitUntilDone:YES];
    STAssertTrue([[self.addItemController.nameField text] isEqualToString:@"foo"], @"Name should be foo");
}

@end
