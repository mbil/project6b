//
//  calendarViewController.h
//  Huisgenoten
//
//  Created by Myrthe Bil & Miguel Pruijssers on 6/11/13.
//
//

#import "CalendarKit.h"
#import "CKCalendarViewController.h"

@interface calendarViewController : CKCalendarViewController

- (IBAction)backAction:(id)sender;

@property (nonatomic, assign) id delegate;

@end
