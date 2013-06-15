//
//  alarmItem.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 14-06-13.
//
//

#import <Foundation/Foundation.h>

@interface AlarmItem : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;

- (void)toggleChecked;

@end
