//
//  Finances.m
//  Huisgenoten
//
//  Created by Myrthe Bil & Miguel Pruijssers on 6/11/13.
//
//

#import "Finances.h"

@implementation Finances

@synthesize balance=_balance;

// TODO use this model

- (id)init
{
    if (self = [super init])
    {
        NSString *key = @"sum";
        self.balance = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    }
    return self;
}

@end
