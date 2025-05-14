
#include "utils.h"
#include <stdio.h>
#include <stdlib.h>


int main()
{
    int i;
    player **players = allocate_players();
    if (players == NULL) {
        printf("error\n");
        return 1;
    }
    for (i = 0; i < 10; i++) {
        printf("i==%d: %d", i, players[i]->gold);
        printf("TEAM: %d", players[i]->teamI);
        printf("POS: %d\n", players[i]->positionI);
    }
    return 0;
}


/*
int main()
{
    int i;
    for (i = 0; i < 10; i++) {
        printf("i == %d\n", i);
        if (i == 0) {
            printf("i == 0!!!\n");
            for (--i; i >= 0; i--) {
                printf("-i == %d\n", i);
            }
            return 0;
        }
    }
    return 0;
}
*/