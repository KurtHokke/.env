#include <stdio.h>

#define SIZE 10


int main(void)
{
    char found = 'N';
    int i = 0;
    int num;
    int arr[SIZE] = {12, 45, 7, 23, 56, 89, 34, 16, 78, 90};
    do {
        printf("Enter number to search for: ");
        scanf("%d", &num);
        for (i = 0; i < SIZE; i++) {
            if (num == arr[i]) found = 'Y';
        }
    } while (found != 'Y');
    printf("found %d in array!\n", num);
    return 0;
}