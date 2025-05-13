#include "utils.h"
#include "jsson.h"
#include <jansson.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

bool update_aJSON(aJSON *ptr, char *data) {
    json_error_t error;

    ptr->root = json_loads(data, 0, &error);
    if (!ptr->root) {
        fprintf(stderr, "ERROR: %s\n", error.text);
        fprintf(stderr, "Error while parsing JSON(%d): %s\n", error.line, error.text);
        return false;
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
        fprintf(stderr, "Error while parsing JSON(%d): %s\n", error.line, error.text);
        return false;
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