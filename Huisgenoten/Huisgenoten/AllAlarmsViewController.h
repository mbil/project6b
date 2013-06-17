//
//  AllAlarmsViewController.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 16-06-13.
//
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
#import "AlarmsDataModel.h"

@interface AllAlarmsViewController : UITableViewController <ListDetailViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) AlarmsDataModel *dataModel;

- (IBAction)backAction:(id)sender;

@end
