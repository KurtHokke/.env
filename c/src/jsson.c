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


bool jsson(char *jsonData, gSTATS *data) {

    int i = 0;
    json_t *root;
    json_error_t error;

    root = json_loads(jsonData, 0, &error);
    if (!root) {
        fprintf(stderr, "ERROR: %s\n", error.text);
        fprintf(stderr, "Error while parsing JSON(%d): %s\n", error.line, error.text);
        return 1;
    }
    if (!json_is_object(root)) {
        fprintf(stderr, "error: root was not a json object\n");
        json_decref(root);
        return 1;
    }
    json_t *allPlayers = json_object_get(root, "allPlayers");
    if (!json_is_array(allPlayers)) {
        fprintf(stderr, "error: root is not an array\n");
        json_decref(allPlayers);
        json_decref(root);
        return 1;
    }
    for (i = 0; i < json_array_size(allPlayers); i++) {
        json_t *data, *championName;
        const char *message_text;

        data = json_array_get(allPlayers, i);
        if (!json_is_object(data)) {
            fprintf(stderr, "error: commit data %d is not an object\n", i + 1);
            json_decref(allPlayers);
            json_decref(root);
            return 1;
        }
        championName = json_object_get(data, "championName");
        if (!json_is_string(championName)) {
            fprintf(stderr, "error: championName %d: is not a string", i);
            json_decref(allPlayers);
            json_decref(root);
            return 1;
        }
        message_text = json_string_value(championName);
        printf("%s\n", message_text);
    }
    json_decref(allPlayers);
    json_decref(root);
    return 0;
    end:
        
}