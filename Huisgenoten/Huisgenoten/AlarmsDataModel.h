//
//  AlarmsDataModel.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 16-06-13.
//
//

#import <Foundation/Foundation.h>

@interface AlarmsDataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;

-(void)saveAlarms;

@end
