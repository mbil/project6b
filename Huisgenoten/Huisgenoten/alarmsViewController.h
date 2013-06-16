//
//  alarmsViewController.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 14-06-13.
//
//

#import <UIKit/UIKit.h>
#import "AlarmDetailViewController.h"

@class Alarm;

@interface alarmsViewController : UITableViewController <AlarmDetailViewControllerDelegate>

@property (nonatomic, strong) Alarm *alarm;

@end
