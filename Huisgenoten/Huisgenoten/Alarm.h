//
//  Alarm.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 16-06-13.
//
//

#import <Foundation/Foundation.h>

@interface Alarm : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *items;

-(int)countUncheckedItems;

@end
