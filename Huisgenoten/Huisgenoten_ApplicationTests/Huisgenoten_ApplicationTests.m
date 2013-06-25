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
#import "EditItemViewController.h"

@interface Huisgenoten_ApplicationTests ()

//private properties
@property (nonatomic, readwrite, weak) AppDelegate *appDelegate;
@property (strong, nonatomic) AddItemViewController *addItemController;
@property (strong, nonatomic) EditItemViewController *editItemViewController;
@property (strong, nonatomic) ShoppinglistViewController *shoppinglistViewController;
@property (nonatomic, readwrite, weak) UIWindow *window;

@end

@implementation Huisgenoten_ApplicationTests

@synthesize appDelegate=_appDelegate;
@synthesize addItemController=_addItemController;
@synthesize editItemViewController=_editItemViewController;
@synthesize shoppinglistViewController=_shoppinglistViewController;
@synthesize window=_window;

- (void)setUp
{
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.addItemController = [storyboard instantiateViewControllerWithIdentifier:@"AddItem"];
    self.editItemViewController = [storyboard instantiateViewControllerWithIdentifier:@"EditItem"];
    [self.addItemController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
}

- (void) testAppDelegate
{
    STAssertNotNil(self.appDelegate, @"Cannot find the application delegate");
}

- (void) testAddItem {
    [self.addItemController.nameField performSelectorOnMainThread:@selector(setText:) withObject:@"fool" waitUntilDone:YES];
    STAssertFalse([[self.addItemController.nameField text] isEqualToString:@"foo"], @"Name should be fool");
}

- (void) editItem
{
    [self.editItemViewController.boughtSwitch setOn:YES];
    // TODO test of juiste sections worden weergegeven
}

@end
