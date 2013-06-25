//
//  Huisgenoten_LogicTests.m
//  Huisgenoten_LogicTests
//
//  Created by Myrthe Bil on 6/25/13.
//
//

#import "Huisgenoten_LogicTests.h"
#import "Finances.h"

@interface Huisgenoten_LogicTests ()

// private property

@property (nonatomic, readwrite, strong) Finances *finances;

@end


@implementation Huisgenoten_LogicTests

@synthesize finances=_finances;

- (void)setUp
{
    [super setUp];
    NSLog(@"setUp");
    self.finances = [[Finances alloc] init];
    STAssertNotNil(self.finances, @"Cannot create Finances instance");
}

- (void)testBalance
{
    // balance should be 0 initially
    STAssertTrue(self.finances.balance == 0, @"Balance is not 0");
}

- (void)tearDown
{
    // Tear-down code here.
    NSLog(@"tearDown");
    [super tearDown];
}

@end
