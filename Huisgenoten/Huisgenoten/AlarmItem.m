//
//  alarmItem.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 14-06-13.
//
//

#import "AlarmItem.h"

@implementation AlarmItem

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}

- (void)toggleChecked
{
    self.checked = !self.checked;
}

@end
