/*
Exercise 1: Sum of Array Elements (for loop with continue)
Problem: Write a program that takes 5 integers as input into an array. 
Use a for loop to calculate the sum of all positive numbers in the array, 
skipping negative numbers with continue. Use type casting to display 
the average of positive numbers as a decimal number, and use the ternary 
operator to say if the sum is "Big" (≥ 50) or "Small".
*/

#define SIZE_OF_ARRAY 5

#include <stdio.h>

int main() {
    int arr[SIZE_OF_ARRAY];
    char *suffixes[] = {"st", "nd", "rd", "th", "th"};

    int sum = 0;
    float average = 0;

    for (int i = 0; i < SIZE_OF_ARRAY; i++) {
        printf("Enter %d%s number of array: ", i + 1, suffixes[i]);
        scanf("%d", &arr[i]);
    }
    for (int i = 0; i < SIZE_OF_ARRAY; i++) {
        sum = (arr[i] > 0)? sum + arr[i] : sum;
    }
    average = (float)sum / (float)SIZE_OF_ARRAY;
    (sum >= 50)? printf("Big") : printf("Small");
    printf(" sum: %d\n", sum);
    printf("average: %.2f\n", average);
    return 0;
}