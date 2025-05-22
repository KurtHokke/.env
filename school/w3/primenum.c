/*
Exercise 3: Prime Number Checker (do-while and continue)
Problem: Write a program that takes a positive integer and checks if it is prime 
(divisible only by 1 and itself). 
Allow the user to check multiple numbers, exiting when they enter 0. 
Skip invalid inputs (e.g., negative numbers or 1).
*/
#include <stdio.h>

int main() {
    int num;
    int isPrime; // for loop changes to false if num is not prime 
    do {
        isPrime = 1; // Initiate as true
        printf("Enter a positive integer (0 to exit): ");
        scanf("%d", &num);
        if (num <= 0) continue; // Continue to while condition to determine if it should exit or skip negative number
        if (num == 2) { // 2 is the only even prime number
            printf("\n%d is a prime number\n", num);
            continue;
        }
        if ((num == 1) || (num % 2 == 0)) { // Check if num is 1 or evenly divisible by 2
            printf("\n%d is not a prime number\n", num);
            continue;
        } 
        for (int i = 3; i * i <= num; i += 2) { // Loop until i is greater than square root of num
            if (num % i == 0) {
                printf("\n%d is not a prime number\n", num);
                isPrime = 0;
                break;
            }
        }
        if (isPrime) {
            printf("\n%d is a prime number\n", num);
        }

    } while (num != 0); // Exit or not
    
    return 0;
}