#include "utils.h"
#include "curling.h"
#include <jansson.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INTERACTIV

#ifdef INTERACTIVE
int main(int argc, char *argv[]) {
#else
int main() {
#endif
    #ifdef INTERACTIVE
    if (argc < 2) {
        e_PRINT(-1, "compiled with #define INTERACTIVE\n");
        return 1;
    }
    if
    #endif

    struct Memory response = do_curl();
    if (response.data == NULL || response.size == 0) {
        e_PRINT(-1, "ERROR");
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

    printf("riotId: %s\n\n", json->activePlayer);

    char *rootvalue = json_dumps(json->allPlayers, 0);
    printf("%.*s", 100, rootvalue);

    json_decref(json->root);
    free(json);
    printf("working\n");
    return 0;
}
/*
    json->root = json_loads(response.data, 0, &error);
    free(response.data);
    if (!json->root) {
        e_PRINT(-1, "ERROR: %s\n", error.text);
        fprintf(stderr, "Error while parsing JSON(%d): %s\n", error.line, error.text);
        return 1;
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
        msg(stderr, "ERROR:'main.c',line(30): 'if (!jsson(response.data, &gold_s))'");
        return 1;
    }

    return 0;
*/

