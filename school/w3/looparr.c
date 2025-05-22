/*
Exercise 4: Write a C program to declare, initialize, 
input elements in array and print array. How to input and 
display elements in an array using for loop in C programming. 
C program to input and print array elements using loop.
*/

#define SIZE_OF_ARRAY 10

#include <stdio.h>

int main(void)
{
    int array[SIZE_OF_ARRAY] = {0};
    for (int i = 0; i < SIZE_OF_ARRAY; i++) {
        array[i] = 10 * (i + 1);
        printf("array[%d] = %d\n", i, array[i]);
    }
    for (int i = SIZE_OF_ARRAY - 1; i >= 0; i--) {
        printf("array[%d] = %d\n", i, array[i]);
    }
    return 0;
}