#include <jansson.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define STR(x) #x
#define P_LINE(l) printf("%s:%d", __FILE__, __LINE__ + l);
#define TEAMSIZE 5

typedef struct gSTATS {
    char *champName[TEAMSIZE * 2];
    unsigned int *vs[TEAMSIZE * 2];
} gSTATS;

typedef struct aJSON {
    json_t *root;
    json_t *activePlayer; 
    json_t *allPlayers;
} aJSON;


aJSON *get_aJSON(char *data) {

    json_error_t error;
    aJSON *json = malloc(sizeof(aJSON));
    if (json == NULL) {
        P_LINE(-2) fprintf(stderr, "malloc failed\n");
        return NULL;
    }
    
    json->root = json_loads(data, 0, &error);
    if (!json->root) {
        P_LINE(-2) fprintf(stderr, "ERROR: %s\n", error.text);
        P_LINE(-2) fprintf(stderr, "Error while parsing JSON(%d): %s\n", error.line, error.text);
        free(json);
        return NULL;
    }
    if (!json_is_object(json->root)) {
        P_LINE(-6) fprintf(stderr, "error: %s was not a json OBJECT\n", STR(json->root));
        json_decref(json->root);
        free(json);
        return NULL;
    }
    return json;
}

bool tester(gSTATS *ptr) {
    if (strcmp(ptr->champName[0], "init") == 0) {
        puts("is init");
        return true;
    }
    return false;
}


/*
int main() {
    //gSTATS *test = malloc(sizeof(gSTATS));
    gSTATS *test = get_aJSON()
    if (test == NULL) {
        perror("malloc failed");
        return 1;
    }
    test->champName[0] = malloc(strlen("init") + 1);
    if (test->champName[0] == NULL) {
        perror("Failed to allocate memory for champName");
        free(test);
        return 1;
    }
    strcpy(test->champName[0], "init");
    if (tester(test)) {
        free(test->champName[0]);
        free(test);
        return 0;
    }
    free(test->champName[0]);
    free(test);
    return 1;
}
*/