/*
Exercise 2: Find Maximum in Array (while loop with break)
Problem: Write a program that takes 5 integers as input into an array. 
Use a while loop to find the largest number in the array, 
using break to stop early if a very large number (≥ 100) is found. 
Use type casting to display the largest number as a float for consistent formatting, 
and use the ternary operator to say if the maximum is "Large" (≥ 50) or "Small".
*/

#include <stdio.h>

#define SIZE_OF_ARRAY 5

int main() {
    int arr[SIZE_OF_ARRAY];
    char *suffixes[] = {"st", "nd", "rd", "th", "th"};

    int max = 0;

    for (int i = 0; i < SIZE_OF_ARRAY; i++) {
        printf("Enter %d%s number of array: ", i + 1, suffixes[i]);
        scanf("%d", &arr[i]);
    }
    int j = 0;
    while (j < SIZE_OF_ARRAY)
    {
        if (arr[j] >= 100) {
            max = 100;
            break;
        }
        max = (arr[j] > max)? arr[j] : max;
        j++;
    }
    (max >= 50)? printf("Large") : printf("Small");
    printf(" max: %f\n", (float)max); 
    return 0;
}