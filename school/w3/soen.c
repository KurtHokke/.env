/*
Exercise 1: Sum of Even Numbers (for loop)
Problem: Calculate the sum of all even numbers between 1 and a user-provided number n (inclusive). For example, if n = 10, the sum is 2 + 4 + 6 + 8 + 10 = 30.

Code Template:
*/
#include <stdio.h>

int main() {
    int n, sum = 0;
    printf("Enter a positive integer n: ");
    scanf("%d", &n);

    for (int i = 2; i <= n; i += 2) {
        sum += i;
    }
    printf("Sum of even numbers from 1 to %d is: %d\n", n, sum);
    return 0;
}