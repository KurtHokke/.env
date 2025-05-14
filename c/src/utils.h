
#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <jansson.h>

#define STR(x) #x
#define e_PRINT(l, fmt, ...) fprintf(stderr, "%s:%d: " fmt "\n", __FILE__, __LINE__ + l, ##__VA_ARGS__)
#define TEAMSIZE 5

/*
->(char*)riotId
->(char*)champName
->(int)teamI
->(int)positionI
->(long long)gold
*/
typedef struct player {
    char *riotId;
    char *champName;
    int teamI;
    int positionI;
    long long gold;
} player;

/*
->(json_t*)root; 
->(json_t*)allPlayers;
->(const char*)activePlayer_riotId;
*/
typedef struct aJSON {
    json_t *root; 
    json_t *allPlayers;
    const char *activePlayer_riotId;
} aJSON;


player **allocate_players();
bool free_players(player **players);

aJSON *get_aJSON(char *data);
bool get_activePlayer(aJSON *json);
bool get_allPlayers(aJSON *json);
bool update_players(aJSON *json, player **players);


#endif