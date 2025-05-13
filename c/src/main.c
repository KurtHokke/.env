#include "utils.h"
#include "curling.h"
#include "jsson.h"
#include <jansson.h>
//#include <curl/curl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main() {
    //int i = 0;
    //json_t *root, *activePlayer, *allPlayers;
    aJSON *json = malloc(sizeof(aJSON));
    json_error_t error;

    struct Memory response = do_curl();
    if (response.data == NULL || response.size == 0) {
        fprintf(stderr, "ERROR:'main.c',line(21): 'if (response.data == NULL || response.size == 0)'");
        return 1;
    }
    #ifdef DEBUG
    printf("Response (%zu bytes): %.*s\n", response.size, 500, response.data);
    #endif

    json->root = json_loads(response.data, 0, &error);
    free(response.data);
    if (!json->root) {
        fprintf(stderr, "ERROR: %s\n", error.text);
        fprintf(stderr, "Error while parsing JSON(%d): %s\n", error.line, error.text);
        return 1;
    } 
    if (!json_is_object(json->root)) {
        fprintf(stderr, "error: %s was not a json %s\n", json->root, "object");
        json_decref(json->root);
        return 1;
    }


    gSTATS *test = malloc(sizeof(gSTATS));
    if (test == NULL) {
        fprintf(stderr, "malloc failed\n");
        return 1;
    }



    if (!jsson(response.data, &gold_stats, INIT_TRUE)) {
        msg(stderr, "ERROR:'main.c',line(30): 'if (!jsson(response.data, &gold_s))'");
        return 1;
    }

    //free(gold_stats);
    //gSTATS_handler(&gold_stats, DESTROY);

    return 0;
}
