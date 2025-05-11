#include <stdio.h>


int main(void) {

    int x;
    int y;
    int sum;


    printf("Enter 'x' in 'x + y': ");
    scanf("%d", &x);    //Take first integer input

    printf("Enter 'y' in '%d + y': ", x);
    scanf("%d", &y);    //Take second integer input

    sum = x + y;    //Calculate sum of x and y


    printf("\nResult: %d + %d = %d\n", x, y, sum);
    return 0;
}