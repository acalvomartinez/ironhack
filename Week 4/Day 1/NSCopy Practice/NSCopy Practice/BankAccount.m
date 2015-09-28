//
//  BankAccount.m
//  NSCopy Practice
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount

- (id)copyWithZone:(NSZone *)zone {
    BankAccount *bankAccountCopy = [[[self class] alloc] init];
    
    if (bankAccountCopy) {
        bankAccountCopy.accountNumber = self.accountNumber;
        bankAccountCopy.balance = self.balance;
    }
    
    return bankAccountCopy;
}

@end
