//
//  ViewController.m
//  NSCopy Practice
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

#import "BankAccount.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BankAccount *bankAccount = [[BankAccount alloc]init];
    bankAccount.accountNumber = 1;
    bankAccount.balance = 2.5;
    
    BankAccount *bankAccountCopy = [bankAccount copy];
    
    NSLog(@"%@ %@",bankAccount, bankAccountCopy);
    
    NSMutableString *s1 = [NSMutableString stringWithString:@"1"];
    NSMutableString *s2 = [NSMutableString stringWithString:@"2"];
    NSMutableString *s3 = [NSMutableString stringWithString:@"3"];
    
    NSArray *a = @[s1, s2, s3];
    NSArray *b = [[NSArray alloc] initWithArray:a copyItems:YES];
    
    [s1 appendString:@"0"];
    
    NSLog(@"%@ %@", a[0], b[0]);
    
}

@end
