//
//  alarmsViewController.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 14-06-13.
//
//

#import <UIKit/UIKit.h>
#import "AddAlarmViewController.h"

@interface alarmsViewController : UITableViewController <AddAlarmViewControllerDelegate>

- (IBAction)addAlarm;

@end
