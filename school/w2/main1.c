#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


int main(int argc, char *argv[]) 
{
    int x;
    char *endptr;
    bool y;

    if (argc < 2) return 1;

    x = strtol(argv[1], &endptr, 10);
    printf("%d,%s\n",x,endptr);
    if (endptr == argv[1] || x == 0) return 1;
  
    (x % 2 == 0)? printf("true\n") : printf("false\n");

    return 0;
}