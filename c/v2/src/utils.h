
#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <jansson.h>

#define STR(x) #x
#define Pf(fmt, ...) printf(fmt "\n", ##__VA_ARGS__)
#define TEAMSIZE 5

/*
->(char*)riotId
->(char*)champName
->(int)teamI
->(int)positionI
->(long long)gold
*/
typedef struct aPLAYER {
    char *riotId;
    char *champName;
    char *spacing;
    int teamI;
    int positionI;
    long long gold;
} aPLAYER;

/*
->(json_t*)root; 
->(json_t*)allPlayers;
->(const char*)activePlayer_riotId;
*/
typedef struct aJSON {
    json_t *root; 
    json_t *allPlayers;
    const char *activePlayer_riotId;
    int myTeam;
} aJSON;


aPLAYER **allocate_players();
bool free_players(aPLAYER **players);

aJSON *get_aJSON(char *data);
bool get_activePlayer(aJSON *json);
bool get_allPlayers(aJSON *json);

bool init_players(aJSON *json, aPLAYER **players);
bool update_players(aJSON *json, aPLAYER **players);


#endif