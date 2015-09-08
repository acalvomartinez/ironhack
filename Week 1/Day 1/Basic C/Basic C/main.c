//
//  main.c
//  Basic C
//
//  Created by Toni on 07/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#include <stdio.h>

#include "ASCII.h"

#define NEWLINE '\n'

struct Book
{
    char title[50];
    int book_id;
};


int sum(int num1, int num2) {
    return num1 + num2;
}


void swap(int num1, int num2) {
    int temp = num1;
    
    num1 = num2;
    num1 = temp;
    
    
    return;
}

int main(int argc, const char * argv[]) {
//    
//    const int myConst = 42;
//    
//    int variableDos = 2;
//    int variableCuatro = 3;
//    
//    variableCuatro = 4;
//    
//    float miDecimal = 1.4;
//    
//    typedef unsigned char byte;
//    byte myByte = 'A';
//    
//    struct Book myBook;
//    
//    myBook.book_id = 64538;
//    
//    
//    printf("Hello, World! %d %d %.2f %c %d %d", variableDos, variableCuatro, miDecimal, myByte, NEWLINE, myConst);
    
    
//    
//    double balance[5] = {1.0,2.0,3.0,4.0,5.0};
//    
//    double value2 = balance[0];
//    
//    printf("%.1f\n%.1f", balance[3], value2);
//    
//    
//    int value = value2 < 10 ? 3 : 2;
//    
//    
//    
//    printf("\n%d\n",value%3);
//    
//    
//    int age = 90;
//    
//    if (age < 100) {
//        printf("young man!");
//    } else if (age == 100) {
//        printf("Centenario");
//    } else {
//        printf("INSERSO");
//    }
    
//    for (int i = 5; i < 10; i++) {
//        printf("a: %d\n",i);
//    }
    
//    int a = 2;
//    
//    while (a < 320000) {
//        printf("a: %d\n",a);
//        a = a * 2;
//    }
    
    
    //printASCII();
//    
//    int a, b;
//    
//    a = 2; b = 3;
//    
//    swap(a, b);
//    
//    printf("%d", a);
    
    int var = 20;
    int *ip;
    
    ip = &var;
    
    printf("pointer to var: %p\n", &var);
    printf("pointer ip: %p\n", ip);
    printf("value of pointer : %d\n\n", *ip);
    
    
    char str[] = "Hola #Ironhackers";
    
    printf("%s%c%c%c", str, str[16], str[16], str[16]);
    
    return 0;
}







