#include "utils.h"
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <jansson.h>

bool firstRun = true;
json_t *root    = NULL;
int myTeam;
char **champNames = NULL;
int playergold[10];

struct Memory response = {.data = NULL, .size = 0};
struct errorbox err = {.e = 0};


void free_all_exit(int e, const char *msg);
void handle_sigint(int sig);
void setup_signal_handler(void);
void init_job();
void do_job();

int main() 
{
    setup_signal_handler();

    champNames = malloc(10 * sizeof(char *));
    if (champNames == NULL) {
        free_all_exit(1, "first mallocs failed");
    }

    int i;
    for (i = 0; i < 10; i++) {
        champNames[i] = NULL;
    }

    while (true) {
        do_job();
        system("clear");
        for (i = 0; i < 5; i++) {
            if (myTeam == 0) {
                if (playergold[i] - playergold[i + 5] < 0) {
                    printf("\033[1;38;5;33m%s\033[0m\n \033[38;5;196m%d\033[0m\n\033[1;38;5;162m%s\033[0m\n\n", 
                            champNames[i], playergold[i] - playergold[i + 5], champNames[i + 5]);
                } else {
                    printf("\033[1;38;5;33m%s\033[0m\n \033[38;5;40m%d\033[0m\n\033[1;38;5;162m%s\033[0m\n\n", 
                            champNames[i], playergold[i] - playergold[i + 5], champNames[i + 5]);
                }
            } else {
                if (playergold[i + 5] - playergold[i] < 0) {
                    printf("\033[1;38;5;33m%s\033[0m\n \033[38;5;196m%d\033[0m\n\033[1;38;5;162m%s\033[0m\n\n", 
                            champNames[i + 5], playergold[i + 5] - playergold[i], champNames[i]);
                } else {
                    printf("\033[1;38;5;33m%s\033[0m\n \033[38;5;40m%d\033[0m\n\033[1;38;5;162m%s\033[0m\n\n", 
                            champNames[i + 5], playergold[i + 5] - playergold[i], champNames[i]);
                }
            }
        }
        usleep(2500000);
    }
    free_all_exit(err.e, "WORKING!");
}


void do_job()
{
    json_t *myplayer     = NULL;
    json_t *myriotId   = NULL;
    json_t *myplayerTeam = NULL;

    json_t *players = NULL;

    for (int i = 0; i < 10; i++) {
        (champNames[i] != NULL)? free(champNames[i]) : (void)printf("champNames[%d] was NULL\n", i);
        champNames[i] = NULL;
    }
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

    if (firstRun) {
        myplayer = json_object_get(root, "activePlayer");
        if (!json_is_object(myplayer)) {
            free_all_exit(1, "myplayer !object");
        }
        myriotId = json_object_get(myplayer, "riotId");
        if (!json_is_string(myriotId)) {
            free_all_exit(1, "myriotId !string");
        }
    }

    players = json_object_get(root, "allPlayers");
    if (!json_is_array(players)) {
        free_all_exit(1, "players !array");
    }

    
    size_t i, j;
    for (i = 0; i < json_array_size(players); i++)
    {
        json_t *riotId    = NULL;

        json_t *champ     = NULL;
        json_t *champName = NULL;
        json_t *items     = NULL;
        int totalgold = 0;

        champ = json_array_get(players, i);
        if (!json_is_object(champ)) {
            free_all_exit(1, "champ !object");
        }

        if (firstRun) {
            riotId = json_object_get(champ, "riotId");
            if (!json_is_string(riotId)) {
                free_all_exit(1, "riotId !string");
            }
            if (json_equal(riotId, myriotId)) {
                myplayerTeam = json_object_get(champ, "team");
                if (!json_is_string(myplayerTeam)) {
                    free_all_exit(1, "myplayerTeam !string");
                }
                myTeam = (strcmp(json_string_value(myplayerTeam), "ORDER") == 0)? 0 : 1;
            }
        }

        items = json_object_get(champ, "items");
        if (!json_is_array(items)) {
            free_all_exit(1, "items !array");
        }
        for (j = 0; j < json_array_size(items); j++) {
            json_t *item, *itemgold;

            item = json_array_get(items, j);
            if (!json_is_object(item)) {
                free_all_exit(1, "item !object");
            }

            itemgold = json_object_get(item, "price");
            if (!json_is_integer(itemgold)) {
                free_all_exit(1, "itemgold !int");
            }

            totalgold += json_integer_value(itemgold);
        }
        playergold[i] = totalgold;


        champName = json_object_get(champ, "championName");
        if (!json_is_string(champName)) {
            free_all_exit(1, "champName !string");
        }

        champNames[i] = strdup(json_string_value(champName));
    }
    json_decref(root);
    root = NULL;
}


void free_all_exit(int e, const char *msg)
{
    printf("%s\n", msg);
    printf("freeing all\n");

             (root != NULL)? json_decref(root)   : (void)printf("root was NULL\n");
    (response.data != NULL)? free(response.data) : (void)printf("response.data was NULL\n");

    if (champNames != NULL) {
        for (int i = 0; i < 10; i++) {
            (champNames[i] != NULL)? free(champNames[i]) : (void)printf("champNames[%d] was NULL\n", i);
        }
        free(champNames);
    }
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