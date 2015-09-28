//
//  BankAccount.h
//  NSCopy Practice
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;

@interface BankAccount : NSObject <NSCopying>

@property (nonatomic) NSUInteger accountNumber;
@property (nonatomic) CGFloat balance;

@end
