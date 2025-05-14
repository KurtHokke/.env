
#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <jansson.h>

#define STR(x) #x
#define e_PRINT(l, fmt, ...) fprintf(stderr, "%s:%d: " fmt "\n", __FILE__, __LINE__ + l, ##__VA_ARGS__)
//#define P_LINE(l) printf("%s:%d", __FILE__, __LINE__ + l);
#define TEAMSIZE 5

typedef struct gSTATS {
    char *champName[TEAMSIZE * 2];
    unsigned int *vs[TEAMSIZE * 2];
} gSTATS;


typedef struct aJSON {
    json_t *root; 
    json_t *allPlayers;
    const char *activePlayer;
} aJSON;

aJSON *get_aJSON(char *data);
bool get_activePlayer(aJSON *json);
bool get_allPlayers(aJSON *json);


#endif