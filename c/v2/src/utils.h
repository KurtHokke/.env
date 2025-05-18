
#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <jansson.h>

#define STR(x) #x
//#define Pf(fmt, ...) printf(fmt "\n", ##__VA_ARGS__)

#define LOL_GAME_URL "https://127.0.0.1:2999/liveclientdata/allgamedata"
#define LOL_VERSIONS_URL "https://ddragon.leagueoflegends.com/api/versions.json"
#define LOL_ITEMS_URL(LOL_VERSION) "https://ddragon.leagueoflegends.com/cdn/%s/data/en_US/item.json", LOL_VERSION

struct Memory {
    char *data;
    size_t size;
};

typedef struct context_t {
    int *playergold;
    struct Memory response;
    struct Memory lolVersions;
    struct Memory lolItems;
    json_t *root;
    json_t *root_v;
    json_t *root_i;
    char **champNames;
    char *lol_V;
    char *items_URL;
    int myTeam;
    bool firstRun;
} context_t;

void set_context(context_t *context);
void free_all_exit(int e, const char *msg);
void handle_sigint(int sig);
void setup_signal_handler(void);

char *get_lol_v(char *data);
void do_job(context_t *ctx);
struct Memory do_curl(const char *url);

#endif