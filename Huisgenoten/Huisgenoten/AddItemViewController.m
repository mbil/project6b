//
//  addItemViewController.m
//  Huisgenoten
//
//  Created by Myrthe Bil on 6/18/13.
//
//

#import "AddItemViewController.h"
#import "ShoppinglistViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

@synthesize nameField = _nameField;
@synthesize itemListViewController = _itemListViewController;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // delegate for the pricefield check
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions

- (void)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneButtonPressed:(id)sender {
    // add new item to the shoppinglist
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
    [newDevice setValue:self.nameField.text forKey:@"item"];
    [newDevice setValue:[NSNumber numberWithFloat:0] forKey:@"price"];
    [newDevice setValue:NO forKey:@"bought"];
    
    [newDevice setValue:NO forKey:@"inFinances"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end