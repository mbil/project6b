//
//  AlarmsDataModel.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 16-06-13.
//
//

#import "AlarmsDataModel.h"
#import "Alarm.h"
#import "AlarmItem.h"

@implementation AlarmsDataModel

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Alarms.plist"];
}

// Save in plist
- (void)saveAlarms
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"Alarms"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

// Load out of plist
- (void)loadAlarms
{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.lists = [unarchiver decodeObjectForKey:@"Alarms"];
        [unarchiver finishDecoding];
    } else {
        self.lists = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

- (void)registerDefaults
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:-1], @"AlarmIndex",
                                [NSNumber numberWithBool:YES], @"FirstTime",
                                [NSNumber numberWithInt:0], @"AlarmItemId",
                                nil];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (void)handleFirstTime
{
    BOOL firstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTime"];
    if (firstTime) {
        
        Alarm *alarmGroup = [[Alarm alloc] init];
        alarmGroup.name = @"Je eerste map";
        alarmGroup.iconName = @"Afspraken";
        [self.lists addObject:alarmGroup];
        [self setIndexOfSelectedAlarm:0];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTime"];
    }
}

-(id)init
{
    if ((self = [super init])) {
        [self loadAlarms];
        [self registerDefaults];
        [self handleFirstTime];
    }
    
    return self;
}

- (int)indexOfSelectedAlarm
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"AlarmIndex"];
}

- (void)setIndexOfSelectedAlarm:(int)index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"AlarmIndex"];
}

- (void)sortAlarms
{
    [self.lists sortUsingSelector:@selector(compare:)];
}

+ (int)nextAlarmItemId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int itemId = [userDefaults integerForKey:@"AlarmItemId"];
    [userDefaults setInteger:itemId + 1 forKey:@"AlarmItemId"];
    [userDefaults synchronize];
    return itemId;
}

@end
