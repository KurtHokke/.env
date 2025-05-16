#include <stdio.h>
#include <stdlib.h>
#include <time.h>

static inline int get_RandomNumber(int min, int max)
{
    int i;
    unsigned int seed = time(NULL);
    int rand_num = rand_r(&seed) % (max - min + 1) + min;

    return rand_num;
}

int main()
{
    // int num;
    // srand(time(NULL));
    // num = (int)((float)100 * rand() / (RAND_MAX + 1.0));
    //  int guess;
    // printf("%d\n", num);
    int num = get_RandomNumber(0, 100);
    printf("%d\n", num);
    return 0;
}