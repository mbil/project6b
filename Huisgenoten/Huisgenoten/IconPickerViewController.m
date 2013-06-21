//
//  IconPickerViewController.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 17-06-13.
//
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController
{
    NSArray *icons;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    icons = [NSArray arrayWithObjects:
             @"Geen Afbeelding",
             @"Afspraken",
             @"Verjaardagen",
             @"Klusjes",
             @"Feestjes",
             @"Folder",
             @"Inbox",
             @"Foto's",
             @"Uitjes",
             nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [icons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
    
    NSString *icon = [icons objectAtIndex:indexPath.row];
    cell.textLabel.text = icon;
    cell.imageView.image = [UIImage imageNamed:icon];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *iconName = [icons objectAtIndex:indexPath.row];
    [self.delegate iconPicker:self didPickIcon:iconName];
}

@end
