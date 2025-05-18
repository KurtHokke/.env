
#ifndef TEST_H
#define TEST_H

#include <stdio.h>


typedef struct context_t {
    int playergold[10];
    char **champNames;
    int myTeam;
} context_t;

void set_context(context_t *context);
void diditwork();

#endif