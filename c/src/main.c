#include "curling.h"
#include "utils.h"
#include <jansson.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

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
        // Move cursor to top-left (ANSI escape code)
        printf("\033[H");
        // Ensure the output is flushed immediately
        fflush(stdout);
        printf("=====ORDER====================CHAOS=====\n");
        for (i = 0; i < 5; i++) {
            printf("%s%s%lld%s%s\n", players[i]->champName, players[i]->spacing,
                                     players[i]->gold - players[i + 1]->gold, 
                                     players[i + 1]->spacing, players[i + 1]->champName);
        }
        /*
        for (i = 0; i < 10; i++)
        {

            //printf("riotId=%s\n", players[i]->riotId);
            printf("champName=%s\n", players[i]->champName);
            (players[i]->teamI == 0) ? printf("team: ORDER\n")
                                    : printf("team: CHAOS\n");
            switch (players[i]->positionI) {
            case 0:
                printf("position: TOP\n");
                break;
            case 1:
                printf("position: JUNGLE\n");
                break;
            case 2:
                printf("position: MIDDLE\n");
                break;
            case 3:
                printf("position: BOTTOM\n");
                break;
            case 4:
                printf("position: UTILITY\n");
                break;
            default:
                printf("position: INVALID!!!!!\n");
                break;
            }
            printf("%lld\n\n", players[i]->gold);
        }*/

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
