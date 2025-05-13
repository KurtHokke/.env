
#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include <jansson.h>

#define TEAMSIZE 5


typedef struct gSTATS {
    char *champName[TEAMSIZE * 2];
    unsigned int *vs[TEAMSIZE * 2];
} gSTATS;


typedef struct aJSON {
    json_t *root;
    json_t *activePlayer; 
    json_t *allPlayers;
} aJSON;



#endif