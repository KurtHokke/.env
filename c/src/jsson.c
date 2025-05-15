#include "utils.h"
#include <jansson.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

aJSON *get_aJSON(char *data)
{
    aJSON *json = malloc(sizeof(aJSON));
    if (json == NULL)
    {
        e_PRINT(-2, "malloc failed\n");
        return NULL;
    }

    json_error_t error;
    json->activePlayer_riotId = NULL;
    json->allPlayers = NULL;
    json->root = json_loads(data, 0, &error);

    if (!json->root)
    {
        e_PRINT(-2, "ERROR: %s\n", error.text);
        e_PRINT(-2, "Error while parsing JSON(%d): %s\n", error.line,
                error.text);
        free(json);
        return NULL;
    }
    if (!json_is_object(json->root))
    {
        e_PRINT(-6, "error: %s was not a json OBJECT\n", STR(json->root));
        json_decref(json->root);
        free(json);
        return NULL;
    }

    return json;
}

bool get_activePlayer(aJSON *json)
{
    json_t *activePlayer, *riotId;

    if (json == NULL || json->root == NULL)
    {
        e_PRINT(-2, "aJSON *json faulty\n");
        return false;
    }

    activePlayer = json_object_get(json->root, "activePlayer");
    if (!json_is_object(activePlayer))
    {
        e_PRINT(-2, "activePlayer is not a json OBJECT\n");
        return false;
    }
    riotId = json_object_get(activePlayer, "riotId");
    if (!json_is_string(riotId))
    {
        e_PRINT(-2, "riotId is not a json STRING\n");
        return false;
    }
    json->activePlayer_riotId = json_string_value(riotId);
    return true;
}

bool get_allPlayers(aJSON *json)
{
    if (json == NULL || json->root == NULL)
    {
        e_PRINT(-2, "aJSON *json faulty\n");
        return false;
    }
    json->allPlayers = json_object_get(json->root, "allPlayers");
    if (!json_is_array(json->allPlayers))
    {
        e_PRINT(-2, "json->allPlayers is not a json ARRAY\n");
        return false;
    }
    return true;
}

bool update_players(aJSON *json, aPLAYER **players)
{
    if (json == NULL || json->allPlayers == NULL || players == NULL)
    {
        e_PRINT(-3, "begin update_players() failed\n");
        return false;
    }

    int i, j;
    for (i = 0; i < json_array_size(json->allPlayers); i++)
    {
        json_t *player_json,
            *riotId_json; //, *champ_json, *team_json, *position_json;
        json_t *items_json, *gold_json;
        // const char *champName, *teamName, *positionName;
        long long goldValue = 0;

        player_json = json_array_get(json->allPlayers, i);
        if (!json_is_object(player_json))
        {
            e_PRINT(-2, "%s is not a json OBJECT\n", STR(player_json));
            return false;
        }

        riotId_json = json_object_get(player_json, "riotId");
        // champ_json = json_object_get(player_json, "championName");
        // team_json = json_object_get(player_json, "team");
        // position_json = json_object_get(player_json, "position");

        if (!json_is_string(riotId_json))
        {
            e_PRINT(-2, "%s is not a json STRING\n", STR(riotId_json));
            return false;
        }
        /*        if (!json_is_string(champ_json)) {
                    e_PRINT(-2, "%s is not a json STRING\n", STR(champ_json));
                    return false;
                }
                if (!json_is_string(team_json)) {
                    e_PRINT(-2, "%s is not a json STRING\n", STR(team_json));
                    return false;
                }
                if (!json_is_string(position_json)) {
                    e_PRINT(-2, "%s is not a json STRING\n",
           STR(position_json)); return false;
                }
        */
        items_json = json_object_get(player_json, "items");
        if (!json_is_array(items_json))
        {
            e_PRINT(-2, "%s is not a json ARRAY\n", STR(items_json));
            return false;
        }

        for (j = 0; j < json_array_size(items_json); j++)
        {
            json_t *current_item, *current_gold;

            current_item = json_array_get(items_json, j);
            if (!json_is_object(current_item))
            {
                e_PRINT(-2, "%s is not a json OBJECT\n", STR(current_item));
                return false;
            }

            current_gold = json_object_get(current_item, "price");
            if (!json_is_integer(current_gold))
            {
                e_PRINT(-2, "%s is not a json INT\n", STR(current_gold));
                return false;
            }

            goldValue += json_integer_value(current_gold);
        }

        // snprintf(players[i]->champName, 50, "%s",
        // json_string_value(champ_json)); snprintf(players[i]->riotId, 100,
        // "%s", json_string_value(riotId_json));
        players[i]->gold = goldValue;

        /*        teamName = json_string_value(team_json);
                positionName = json_string_value(position_json);
                char t = teamName[0];
                char p = positionName[0];
                switch (t)
                {
                    case 'O': //ORDER
                        players[i]->teamI = 0;
                        break;
                    case 'C': //CHAOS
                        players[i]->teamI = 1;
                        break;
                    default:
                        e_PRINT(-1, "teamName[0] error\n");
                        return false;
                }
                switch (p)
                {
                    case 'T': //TOP
                        players[i]->positionI = 0;
                        break;
                    case 'J': //JUNGLE
                        players[i]->positionI = 1;
                        break;
                    case 'M': //MIDDLE
                        players[i]->positionI = 2;
                        break;
                    case 'B': //BOTTOM
                        players[i]->positionI = 3;
                        break;
                    case 'U': //UTILITY
                        players[i]->positionI = 4;
                        break;
                    default:
                        e_PRINT(-1, "positionName[0] error\n");
                        return false;
                }
        */
#ifdef DEBUG
        printf("rN: %s\n", players[i]->riotId);
        printf("cN: %s\n", players[i]->champName);
        printf("gold: %lld\n\n", players[i]->gold);
#endif
    }

    return true;
}

bool init_players(aJSON *json, aPLAYER **players)
{
    if (json == NULL || json->allPlayers == NULL || players == NULL)
    {
        e_PRINT(-3, "begin init_players() failed\n");
        return false;
    }

    int i, j;
    for (i = 0; i < json_array_size(json->allPlayers); i++)
    {
        json_t *player_json, *riotId_json, *champ_json, *team_json,
            *position_json;
        json_t *items_json, *gold_json;
        const char *champName, *teamName, *positionName;
        long long goldValue = 0;

        player_json = json_array_get(json->allPlayers, i);
        if (!json_is_object(player_json))
        {
            e_PRINT(-2, "%s is not a json OBJECT\n", STR(player_json));
            return false;
        }

        riotId_json = json_object_get(player_json, "riotId");
        champ_json = json_object_get(player_json, "championName");
        team_json = json_object_get(player_json, "team");
        position_json = json_object_get(player_json, "position");

        if (!json_is_string(riotId_json))
        {
            e_PRINT(-2, "%s is not a json STRING\n", STR(riotId_json));
            return false;
        }
        if (!json_is_string(champ_json))
        {
            e_PRINT(-2, "%s is not a json STRING\n", STR(champ_json));
            return false;
        }
        if (!json_is_string(team_json))
        {
            e_PRINT(-2, "%s is not a json STRING\n", STR(team_json));
            return false;
        }
        if (!json_is_string(position_json))
        {
            e_PRINT(-2, "%s is not a json STRING\n", STR(position_json));
            return false;
        }

        items_json = json_object_get(player_json, "items");
        if (!json_is_array(items_json))
        {
            e_PRINT(-2, "%s is not a json ARRAY\n", STR(items_json));
            return false;
        }

        for (j = 0; j < json_array_size(items_json); j++)
        {
            json_t *current_item, *current_gold;

            current_item = json_array_get(items_json, j);
            if (!json_is_object(current_item))
            {
                e_PRINT(-2, "%s is not a json OBJECT\n", STR(current_item));
                return false;
            }

            current_gold = json_object_get(current_item, "price");
            if (!json_is_integer(current_gold))
            {
                e_PRINT(-2, "%s is not a json INT\n", STR(current_gold));
                return false;
            }

            goldValue += json_integer_value(current_gold);
        }

        snprintf(players[i]->champName, 50, "%s", json_string_value(champ_json));
        snprintf(players[i]->riotId, 100, "%s", json_string_value(riotId_json));
        


        int len = strlen(players[i]->champName);
        int spaces_needed = 15 - len;
        
        for (j = 0; j < spaces_needed; j++) {
            strlcat(players[i]->spacing, "_", 20);
        }

        players[i]->gold = goldValue;

        teamName = json_string_value(team_json);
        positionName = json_string_value(position_json);
        char t = teamName[0];
        char p = positionName[0];
        switch (t)
        {
        case 'O': // ORDER
            players[i]->teamI = 0;
            break;
        case 'C': // CHAOS
            players[i]->teamI = 1;
            break;
        default:
            e_PRINT(-1, "teamName[0] error\n");
            return false;
        }
        switch (p)
        {
        case 'T': // TOP
            players[i]->positionI = 0;
            break;
        case 'J': // JUNGLE
            players[i]->positionI = 1;
            break;
        case 'M': // MIDDLE
            players[i]->positionI = 2;
            break;
        case 'B': // BOTTOM
            players[i]->positionI = 3;
            break;
        case 'U': // UTILITY
            players[i]->positionI = 4;
            break;
        default:
            e_PRINT(-1, "positionName[0] error\n");
            return false;
        }
        if (strncmp(json->activePlayer_riotId, players[i]->riotId, 100) == 0) {
#ifdef DEBUG
            printf("found you: %s, %s, %s", (players[i]->teamI == 0)? "ORDER" : "CHAOS", players[i]->champName, players[i]->riotId);
#endif
            json->myTeam = players[i]->teamI;
        }

#ifdef DEBUG
        printf("rN: %s\n", players[i]->riotId);
        printf("cN: %s\n", players[i]->champName);
        printf("gold: %lld\n\n", players[i]->gold);
#endif
    }

    return true;
}

/*
bool update_aJSON(aJSON *ptr, char *data) {
    json_error_t error;

    ptr->root = json_loads(data, 0, &error);
    if (!ptr->root) {
        fprintf(stderr, "ERROR: %s\n", error.text);
        fprintf(stderr, "Error while parsing JSON(%d): %s\n", error.line,
error.text); return false;
    }
    if (!json_is_object(ptr->root)) {
        PRINT_AND_RETURN(ptr->root, OBJECT);
    }

    ptr->allPlayers = json_object_get(ptr->root, "allPlayers");
}

char *get_champNames() {

}


bool jsson(char *jsonData, gSTATS *ptr) {

    bool init = false;
    int i = 0;
    const char *playerName;
    if (*ptr == NULL) {
        init = true;
        *ptr = malloc(sizeof(gSTATS));
        if (*ptr == NULL) {
            fprintf(stderr, "Failed to allocate struct memory\n");
            return false;
        }
    }
    json_t *root, *activePlayer, *playerID;
    json_error_t error;


    root = json_loads(jsonData, 0, &error);
    if (!root) {
        fprintf(stderr, "ERROR: %s\n", error.text);
        fprintf(stderr, "Error while parsing JSON(%d): %s\n", error.line,
error.text); return false;
    }
    if (!json_is_object(root)) {
        PRINT_AND_RETURN(root, OBJECT);
    }
    json_t *allPlayers = json_object_get(root, "allPlayers");
    if (!json_is_array(allPlayers)) {
        PRINT_AND_RETURN(allPlayers, ARRAY);
    }
    if (init) {
        activePlayer = json_object_get(root, "activePlayer");
        if (!json_is_object(activePlayer)) {
            PRINT_AND_RETURN(activePlayer, OBJECT);
        }
        playerID = json_object_get(activePlayer, "riotId");
        if (!json_is_string(playerID)) {
            PRINT_AND_RETURN(playerID, STRING);
        }
        playerName = json_string_value(playerID);
    }
    for (i = 0; i < json_array_size(allPlayers); i++) {
        json_t *alldata, *championName, *position, *team, *riotId;
        const char *riotName;
        const char *championNameText;
        const char *positionText;
        const char *teamText;

        alldata = json_array_get(allPlayers, i);
        if (!json_is_object(alldata)) {
            PRINT_AND_RETURN(alldata, OBJECT);
        }
        if (init) {
            riotId = json_object_get(alldata, "riotId");
            if (!json_is_string(riotId)) {
                PRINT_AND_RETURN(riotId, STRING);
            }
            if (json_equal(playerID, riotId)) {
                goto team;
                after_team:
                    (*ptr)->playerTeam = teamText;
            }
            //riotName = json_string_value(riotId);
        }
        championName = json_object_get(alldata, "championName");
        if (!json_is_string(championName)) {
            PRINT_AND_RETURN(championName, STRING);
        }
        championNameText = json_string_value(championName);

        position = json_object_get(alldata, "position");
        if (!json_is_string(position)) {
            PRINT_AND_RETURN(position, STRING);
        }
        positionText = json_string_value(position);

        team:
            team = json_object_get(alldata, "team");
            if (!json_is_string(team)) {
                PRINT_AND_RETURN(team, STRING);
            }
            teamText = json_string_value(team);
            if (init) goto after_team;




        printf("%s %s\n%s\n%s\n\n", teamText, positionText, championNameText);
    }
    json_decref(root);
    return true;
}
*/