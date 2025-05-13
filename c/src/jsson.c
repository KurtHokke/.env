#include "utils.h"
#include "jsson.h"
#include <jansson.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>


char *init_jsson(char *jsonData) {
    char *champNames[TEAMSIZE];
}


bool jsson(char *jsonData, gSTATS *data, bool init) {

    int i = 0;
    json_t *root;
    json_error_t error;
    
    int playerTeam = ORDER;
    json_t *activePlayer, *playerID;
    const char *playerName;
    
    root = json_loads(jsonData, 0, &error);
    if (!root) {
        fprintf(stderr, "ERROR: %s\n", error.text);
        fprintf(stderr, "Error while parsing JSON(%d): %s\n", error.line, error.text);
        return false;
    }
    if (!json_is_object(root)) {
        fprintf(stderr, "error: root was not a json object\n");
        json_decref(root);
        return false;
    }
    json_t *allPlayers = json_object_get(root, "allPlayers");
    if (!json_is_array(allPlayers)) {
        fprintf(stderr, "error: root is not an array\n");
        json_decref(root);
        return false;
    }
    if (init) {
        activePlayer = json_object_get(root, "activePlayer");
        if (!json_is_object(activePlayer)) {
            fprintf(stderr, "error: activePlayer is not a object\n");
            json_decref(root);
        }
        playerID = json_object_get(activePlayer, "riotId");
        if (!json_is_string(playerID)) {
            fprintf(stderr, "error: playerID is not a string\n");
            json_decref(root);
        }
        playerName = json_string_value(playerID);
    }
    for (i = 0; i < json_array_size(allPlayers); i++) {
        json_t *data, *championName, *position, *team, *riotId;

        data = json_array_get(allPlayers, i);
        if (!json_is_object(data)) {
            fprintf(stderr, "error: commit data %d is not an object\n", i + 1);
            json_decref(root);
            return false;
        }
        championName = json_object_get(data, "championName");
        if (!json_is_string(championName)) {
            fprintf(stderr, "error: championName %d: is not a string", i);
            json_decref(root);
            return false;
        }
        position = json_object_get(data, "position");
        if (!json_is_string(position)) {
            fprintf(stderr, "error: position %d: is not a string", i);
            json_decref(root);
            return false;
        }
        team = json_object_get(data, "team");
        if (!json_is_string(team)) {
            fprintf(stderr, "error: team %d: is not a string", i);
            json_decref(root);
            return false;
        }
        const char *championNameText = json_string_value(championName);
        const char *positionText = json_string_value(position);
        const char *teamText = json_string_value(team);
        const char *riotName;
        int is_eq_json;
        if (init) {
            riotId = json_object_get(data, "riotId");
            if (!json_is_string(riotId)) {
                fprintf(stderr, "error: riotId %d: is not a string", i);
                json_decref(root);
                return false;
            }
            is_eq_json = json_equal(playerID, riotId);
            riotName = json_string_value(riotId);
        }

        printf("%s %s\n%s\n%s %s %d\n\n", teamText, positionText, championNameText, playerName, riotName, is_eq_json);
    }
    json_decref(root);
    return true;
}