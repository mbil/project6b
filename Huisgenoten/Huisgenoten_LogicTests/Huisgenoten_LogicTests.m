//
//  Huisgenoten_LogicTests.m
//  Huisgenoten_LogicTests
//
//  Created by Myrthe Bil on 6/25/13.
//
//

#import "Huisgenoten_LogicTests.h"
#import "Finances.h"
//#import "AlarmItem.h"

@interface Huisgenoten_LogicTests ()

// private property

@property (nonatomic, readwrite, strong) Finances *finances;
@property (nonatomic, readwrite, strong) AlarmItem *alarmItem;

@end


@implementation Huisgenoten_LogicTests

@synthesize finances=_finances;
@synthesize alarmItem=_alarmItem;

- (void)setUp
{
    [super setUp];
    NSLog(@"setUp");
    self.finances = [[Finances alloc] init];
    self.alarmItem = [[AlarmItem alloc] init];
    STAssertNotNil(self.finances, @"Cannot create Finances instance");
    STAssertNotNil(self.alarmItem, @"Cannot create AlarmItem instance");
}

- (void)testBalance
{
    // balance should be 0 initially
    STAssertTrue(self.finances.balance == 0, @"Balance is not 0");
}

- (void)testReminder
{
    // reminder should be off initially
    STAssertTrue(self.alarmItem.shouldRemind == NO, @"Reminder is not off");
}

- (void)tearDown
{
    // Tear-down code here.
    NSLog(@"tearDown");
    [super tearDown];
}

@end
