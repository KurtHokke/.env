
#include "utils.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>


player **allocate_players()
{
    int i;
    player **players = malloc(10 * sizeof(player *));

    for (i = 0; i < 10; i++)
    {
        players[i]            = malloc(sizeof(player));
        players[i]->riotId    = malloc(100 * sizeof(char));
        players[i]->champName = malloc(50 * sizeof(char));

        if (players[i] == NULL || players[i]->champName == NULL) {
            e_PRINT(-2, "malloc failed\n");
            for (--i; i >= 0; i--) {
                free(players[i]->riotId);
                free(players[i]->champName);
                free(players[i]);
            }
            free(players);
            return NULL;
        }
        snprintf(players[i]->riotId, 100, "riotId#%d", i);
        snprintf(players[i]->champName, 50, "champName#%d", i);
        players[i]->teamI = (i < 5)? 0 : 1;
        players[i]->positionI = i;
        players[i]->gold = 1000 * (i + 1);
    }
    return players;
}

bool free_players(player **players)
{
    int i;

    if (players == NULL) {
        e_PRINT(-1, "players was unallocated\n");
        return false;
    }

    for (i = 0; i < 10; i++)
    {
        if (players[i]->riotId != NULL) {
            free(players[i]->riotId);
        }
        if (players[i]->champName != NULL) {
            free(players[i]->champName);
        }
        if (players[i] != NULL) {
            free(players[i]);
        }
    }
    return true;
}