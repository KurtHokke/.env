#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define TEAMSIZE 5

typedef struct gSTATS {
    char *champName[TEAMSIZE * 2];
    unsigned int *vs[TEAMSIZE * 2];
} gSTATS;

bool tester(gSTATS *ptr) {
    if (strcmp(ptr->champName[0], "init") == 0) {
        puts("is init");
        return true;
    }
    return false;
}

int main() {
    gSTATS *test = malloc(sizeof(gSTATS));
    if (test == NULL) {
        perror("malloc failed");
        return 1;
    }
    test->champName[0] = malloc(strlen("init") + 1);
    if (test->champName[0] == NULL) {
        perror("Failed to allocate memory for champName");
        free(test);
        return 1;
    }
    strcpy(test->champName[0], "init");
    if (tester(test)) {
        free(test->champName[0]);
        free(test);
        return 0;
    }
    free(test->champName[0]);
    free(test);
    return 1;
}