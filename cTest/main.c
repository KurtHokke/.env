#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct pointing {
    int *pX;
} pointing;

int main() {
    printf("size: %zu\n", sizeof(pointing));
    int ten = 10;
    pointing *p = {0};
    pointing *pp = malloc(sizeof(pointing));
    pp->pX = &ten;
    printf("size: %zu\n", sizeof(p));
    printf("size: %zu\n", sizeof(pp));
    printf("adress of pp->pX: %p\n", &pp->pX);
    printf("adress of ten: %p\n", &ten);
    free(pp);
    pp = NULL;
    return 0;
}