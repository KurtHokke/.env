#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#define PTRARR
#ifdef SWAP
#define m_SWAP main
#endif
#ifdef PTRARR
#define m_PTRARR main
#endif


#define ARRAY_SIZE 5

int m_PTRARR() {
    int i = 0;
    const char *suffix[] = { "st", "nd", "rd", "th", "th" };
    int *ptr = malloc(ARRAY_SIZE * sizeof(int));
    if (NULL == ptr) {
        puts("malloc failed");
        return 1;
    }
    for (i = 0; i < ARRAY_SIZE; i++) {
        printf("Enter %d%s number: ", i + 1, suffix[i]);
        scanf("")
    }
}


void swap(int *a, int *b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
}
int m_SWAP() {
    int a = 4, b = 9;
    printf("before: a = %d, b = %d\n", a, b);
    swap(&a, &b);
    printf("after: a = %d, b = %d\n", a, b);
    return 0;
}