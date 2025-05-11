#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    if (argc < 2 || argc > 2) {
        printf("Usage: %s number\n", argv[0]);
        return 1;
    };
    int num = atoi(argv[1]);
    char *is = (num > 5) ? "yes" : "no";
    printf("%s\n", is);
    return 0;
}