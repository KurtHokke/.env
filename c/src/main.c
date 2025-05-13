#include "utils.h"
#include "curling.h"
#include <jansson.h>
#include <curl/curl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main() {

    int i = 0;
    int j = 0;
    gSTATS gold_s = {0};
    if (!gSTATS_handler(&gold_s, INITIATE)) {
        fprintf(stderr, "(ln16)ERROR: failed to create struct.\n");
        return 1;
    }

    char *response = NULL;
    if (do_curl(&response) == 1) {
        return 1;
    }

    json_t *root;
    json_error_t error;

    root = json_loads(response, 0, &error);
    free(response);
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
            fprintf(stderr, "error: championName %d: is not a string");
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
        for (i = 0; i < TEAMSIZE; i++) {
            for (j = 0; j < 2; j++) {
                if (mystats.champName[i][j] != NULL) {
                    free(mystats.champName[i][j]); // Free each allocated string
                    mystats.champName[i][j] = NULL; // Optional: avoid dangling pointers
                    printf("Successfully freed mystats.champName[%d][%d]\n", i, j);
                }
            }
        }
}
