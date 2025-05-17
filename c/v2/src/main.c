#include "utils.h"
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <stdint.h>
#include <stdbool.h>
#include <jansson.h>

json_t *root    = NULL;
json_t *players = NULL;
struct Memory response = {.data = NULL, .size = 0};
struct errorbox err = {.e = 0};

void free_all_exit(int e, const char *msg);
void handle_sigint(int sig);
void setup_signal_handler(void);
void do_job();

int main() 
{
    setup_signal_handler();
    do_job();
    free_all_exit(err.e, "WORKING!");
}


void free_all_exit(int e, const char *msg)
{
    printf("%s\n", msg);
    printf("freeing all\n");
    (root != NULL)?          json_decref(root)   : (void)printf("root was NULL\n");
    (response.data != NULL)? free(response.data) : (void)printf("response.data was NULL\n");
    exit(e);
}

void handle_sigint(int sig)
{
    printf("%d Exiting..\n", sig);
    free_all_exit(0, "Ctrl+C detected");
}

void setup_signal_handler(void)
{
    struct sigaction sa;

    sa.sa_handler = handle_sigint;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;

    if (sigaction(SIGINT, &sa, NULL) == -1) {
        perror("Failed to set up SIGINT handler");
        exit(1); // Exit if handler setup fails
    }
}

void do_job()
{
    response = do_curl();
    if (response.data == NULL || response.size == 0) {
        free_all_exit(1, "curl failed");
    }

    root = json_loads(response.data, 0, &err.json);
    free(response.data);
    response.data = NULL;

    if (!root) {
        printf("ERROR: %s\n", err.json.text);
        printf("Error while parsing JSON(%d): %s\n", err.json.line, err.json.text);
        free_all_exit(1, "err");
    }
    if (!json_is_object(root)) {
        free_all_exit(1, "root !object");
    }

    players = json_object_get(root, "allPlayers");
    if (!json_is_array(players)) {
        free_all_exit(1, "players !array");
    }
    //char *jsondump = json_dumps(players, 0); printf("%.*s\n", 500, jsondump); free(jsondump);

    size_t i;//, j;
    for (i = 0; i < json_array_size(players); i++)
    {
        json_t *champ, *champName;//, *team, *pos;
        //char *name;

        champ = json_array_get(players, i);
        if (!json_is_object(champ)) {
            free_all_exit(1, "champ !object");
        }

        champName = json_object_get(champ, "championName");
        if (!json_is_string(champName)) {
            free_all_exit(1, "champName !string");
        }

        printf("%s\n", json_string_value(champName));
    }
}