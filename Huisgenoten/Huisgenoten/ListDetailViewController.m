//
//  ListDetailViewController.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 16-06-13.
//
//

#import "ListDetailViewController.h"
#import "Alarm.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController
{
    NSString *iconName;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        iconName = @"Folder";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.listToEdit != nil) {
        self.title = @"Edit Groep";
        self.textField.text = self.listToEdit.name;
        self.doneBarButton.enabled = YES;
        iconName = self.listToEdit.iconName;
    }
    
    self.iconImageView.image = [UIImage imageNamed:iconName];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel
{
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)done
{
    if (self.listToEdit == nil) {
        Alarm *alarm = [[Alarm alloc] init];
        alarm.name = self.textField.text;
        alarm.iconName = iconName;
        
        [self.delegate listDetailViewController:self didFinishAddingAlarm:alarm];
    } else {
        self.listToEdit.name = self.textField.text;
        self.listToEdit.iconName = iconName;
        
        [self.delegate listDetailViewController:self didFinishEditingAlarm:self.listToEdit];

    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return indexPath;
    } else {
        return nil;
    }
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickIcon"]) {
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)theIconName
{
    iconName = theIconName;
    self.iconImageView.image = [UIImage imageNamed:iconName];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
