//
//  alarmItem.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 14-06-13.
//
//

#import "AlarmItem.h"

@implementation AlarmItem

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization
    }
    
    return self;
}

- (void)toggleChecked
{
    self.checked = !self.checked;
}

@end
