//
//  DatePickerViewController.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 17-06-13.
//
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController
{
    UILabel *dateLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.datePicker setDate:self.date animated:YES];
}

- (void)updateDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    dateLabel.text = [formatter stringFromDate:self.date];
}

- (IBAction)dateChanged
{
    self.date = [self.datePicker date];
    [self updateDateLabel];
}

- (IBAction)cancel
{
    [self.delegate datePickerDidCancel:self];
}

- (IBAction)done
{
    [self.delegate datePicker:self didPickDate:self.date];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"DateCell"];
    
    dateLabel = (UILabel *)[cell viewWithTag:1000];
    [self updateDateLabel];
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 77;
}

@end
