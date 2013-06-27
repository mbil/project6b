//
//  EditItemViewController.m
//  Huisgenoten
//
//  Created by Myrthe Bil on 6/19/13.
//
//

#import "EditItemViewController.h"

@interface EditItemViewController ()

@end

@implementation EditItemViewController

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.finances = [[Finances alloc] init];
    
    _priceField.delegate = self;
    
    [self.nameField setText:[self.item valueForKey:@"item"]];
    [self.priceField setText:[NSString stringWithFormat:@"%.2f", [[_item valueForKey:@"price"] floatValue]]];
    bool bought = [_item valueForKey:@"bought"];
    [self.boughtSwitch setOn:bought];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
}

- (void) hideKeyboard
{
    [_nameField resignFirstResponder];
    [_priceField resignFirstResponder];
}

#pragma mark - IBActions
- (void)itemDataChanged:(id)sender
{
    [self.item setValue:self.nameField.text forKey:@"item"];
    [self.item setValue:[NSNumber numberWithFloat:[self.priceField.text floatValue]] forKey:@"price"];
}

// Adding item to finance object
- (void)addToFinances:(id)sender
{    
    // set price
    self.price = ([self.priceField.text floatValue] * 100);
    
    // add to balance    
    int sum = self.finances.balance += self.price;
    
    NSInteger myValue = sum; // This is your number
    NSString *key = @"sum"; // This is a string to identify your number
    [[NSUserDefaults standardUserDefaults] setInteger:myValue forKey:key];
    
    [self.item setValue:[NSNumber numberWithBool:YES] forKey:@"inFinances"];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newPurchase = [NSEntityDescription insertNewObjectForEntityForName:@"Purchase" inManagedObjectContext:context];
    [newPurchase setValue:self.nameField.text forKey:@"item"];
    [newPurchase setValue:[NSNumber numberWithFloat:[self.priceField.text floatValue]] forKey:@"price"];
    [newPurchase setValue:[NSDate date] forKey:@"date"];

    [self.navigationController popViewControllerAnimated:YES];
}

// change number of sections in the view to make the pricefield appear
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    bool bought = [_item valueForKey:@"bought"];
    if (bought == NO) {
        self.sections = 2;
        return self.sections;
    } else {
        self.sections = 4;
        return self.sections;
    }
}

// make pricefield appear
- (void)itemBought:(id)sender
{
    bool bought = self.boughtSwitch.isOn;
    if (bought == NO) {
        [self.item setValue:NO forKey:@"bought"];
    } else if (bought == YES) {
        [self.item setValue:[NSNumber numberWithBool:YES] forKey:@"bought"];
    }
    [UIView transitionWithView:self.tableView
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        [self.tableView reloadData];
                    } completion:NULL];
}

// pricefield check
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string length]==0){
        return YES;
    }
    
    //Validate Character Entry
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    for (int i = 0; i < [string length]; i++) {
        unichar c = [string characterAtIndex:i];
        
        if ([myCharSet characterIsMember:c]) {
            
            //now check if string already has 1 decimal mark
            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSArray *sep = [newString componentsSeparatedByString:@"."];
            NSInteger newTextLength = [textField.text length] - range.length + [string length];
            
            if (newTextLength > 5) {
                return NO;
            }
            if([sep count]==2) {
                NSString *sepStr=[NSString stringWithFormat:@"%@",[sep objectAtIndex:1]];
                return !([sepStr length]>2);
            }
            
            return YES;
        }
    }
    
    return NO;
}

// set placeholder for pricefield
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.placeholder = textField.text;
    textField.text = @"";
}

// if pricefield hasnt been changed, set placeholder as text again
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        textField.text = textField.placeholder;
    }
    
    textField.placeholder = @"";
}

@end
