#include "curling.h"
#include "utils.h"
#include <jansson.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define DEBUG

int main()
{
    int i = 0;

    struct Memory response = do_curl();
    if (response.data == NULL || response.size == 0) {
        return 1;
    }

    aJSON *json = get_aJSON(response.data);
    free(response.data);
    if (json == NULL) {
        e_PRINT(-2, "get_aJSON failed\n");
        return 1;
    }
    if (!get_activePlayer(json)) {
        e_PRINT(-1, "get_activePlayer failed\n");
        json_decref(json->root);
        free(json);
        return 1;
    }
    if (!get_allPlayers(json)) {
        e_PRINT(-1, "get_allPlayers failed\n");
        json_decref(json->root);
        free(json);
        return 1;
    }

    aPLAYER **players = allocate_players();
    if (players == NULL) {
        e_PRINT(-2, "failed to create player structs\n");
        return 1;
    }

    if (!init_players(json, players)) {
        e_PRINT(-1, "update_players() error\n");
        json_decref(json->root);
        free(json);
        if (!free_players(players)) {
            e_PRINT(-1, "failed to free players struct\n");
        }
        return 1;
    }
    json_decref(json->root);
    free(json);

    //printf("riotId: %s\n\n", json->activePlayer_riotId);

    //char *rootvalue = json_dumps(json->allPlayers, 0);
    //printf("%.*s\n\n", 100, rootvalue);


    bool shouldExit = false;
    system("clear");
    do {
        #ifndef DEBUG
        printf("\033[H");
        fflush(stdout);
        printf("=====ORDER====================CHAOS=====\n");
        for (i = 0; i < 5; i++) {
            printf("%s%s%lld%s%s\n", players[i]->champName, players[i]->spacing,
                                     players[i]->gold - players[i + 1]->gold, 
                                     players[i + 1]->spacing, players[i + 1]->champName);
        }
        #else
        for (i = 0; i < 10; i++)
        {
            (players[i]->teamI == 0) ? printf("ORDER ") 
                                     : printf("CHAOS ");
            printf("%s\t   ", players[i]->champName);
            switch (players[i]->positionI) {
            case 0:
                printf("TOP ");
                break;
            case 1:
                printf("JUNGLE ");
                break;
            case 2:
                printf("MIDDLE ");
                break;
            case 3:
                printf("BOTTOM ");
                break;
            case 4:
                printf("UTILITY ");
                break;
            default:
                printf("INVALID!!!!! ");
                break;
            }
            printf("%lld ", players[i]->gold);
            printf("%s\n", players[i]->riotId);
        }
        shouldExit = true;
        continue;
        #endif
        response = do_curl();
        if (response.data == NULL || response.size == 0) {
            shouldExit = true;
            continue;
        }
        aJSON *json = get_aJSON(response.data);
        free(response.data);
        if (json == NULL)
        {
            e_PRINT(-2, "get_aJSON failed\n");
            shouldExit = true;
            continue;
        }
        if (!get_allPlayers(json))
        {
            e_PRINT(-1, "get_allPlayers failed\n");
            json_decref(json->root);
            free(json);
            shouldExit = true;
            continue;
        }
        if (!update_players(json, players)) {
            e_PRINT(-1, "update_players() error\n");
            json_decref(json->root);
            free(json);
            shouldExit = true;
            continue;
        }
        json_decref(json->root);
        free(json);

        usleep(1000000);
    } while (shouldExit == false);

    if (!free_players(players)) {
        e_PRINT(-1, "failed to free players struct\n");
        return 1;
    }

    printf("working\n");
    return 0;
}

/*
    json->root = json_loads(response.data, 0, &error);
    free(response.data);
    if (!json->root) {
        e_PRINT(-1, "ERROR: %s\n", error.text);
        fprintf(stderr, "Error while parsing JSON(%d): %s\n", error.line,
   error.text); return 1;
    }
    if (!json_is_object(json->root)) {
        e_PRINT(-1, "error: %s was not a json %s\n", json->root, "object");
        json_decref(json->root);
        return 1;
    }


    gSTATS *test = malloc(sizeof(gSTATS));
    if (test == NULL) {
        e_PRINT(-1, "malloc failed\n");
        return 1;
    }



    if (!jsson(response.data, &gold_stats, INIT_TRUE)) {
        msg(stderr, "ERROR:'main.c',line(30): 'if (!jsson(response.data,
   &gold_s))'"); return 1;
    }

    return 0;
*/
