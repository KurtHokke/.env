#include <stdio.h>
#define SIZE 10
int main(void)
{
    int i = 0;
    int array[SIZE] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    while (i < SIZE)
    {
        printf("%d\n",array[i++]);

    }

    return 0;
}