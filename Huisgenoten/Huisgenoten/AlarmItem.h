//
//  alarmItem.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 14-06-13.
//
//

#import <Foundation/Foundation.h>

@interface AlarmItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, copy) NSDate *dueDate;
@property (nonatomic, assign) BOOL shouldRemind;
@property (nonatomic, assign) int itemId;

- (void)toggleChecked;
- (void)scheduleNotification;

@end
