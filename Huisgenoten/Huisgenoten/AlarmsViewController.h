//
//  AlarmsViewController.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 14-06-13.
//
//

#import <UIKit/UIKit.h>
#import "AlarmDetailViewController.h"
#import "ListDetailViewController.h"
#import "AlarmsDataModel.h"

@class Alarm;

@interface AlarmsViewController : UITableViewController <AlarmDetailViewControllerDelegate>

@property (nonatomic, strong) Alarm *alarm;

@end
