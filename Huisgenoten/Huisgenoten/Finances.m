//
//  Finances.m
//  Huisgenoten
//
//  Created by Myrthe Bil & Miguel Pruijssers on 6/11/13.
//
//

#import "Finances.h"

@implementation Finances

//@synthesize balance=_balance;

- (id)init
{
    if (self = [super init])
    {
        NSString *key = @"sum";
        
        // zet de eerste balance op 0 of verder de waarde van de UserDefault zoals toegekend in EditItemViewController
        self.balance = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    }
    
    return self;
}

@end
