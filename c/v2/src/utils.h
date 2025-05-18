
#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <jansson.h>

#define STR(x) #x
//#define Pf(fmt, ...) printf(fmt "\n", ##__VA_ARGS__)

#define MY_URL_CURL "https://127.0.0.1:2999/liveclientdata/allgamedata"
#define LOL_VERSIONS_LOOKUP "https://ddragon.leagueoflegends.com/api/versions.json"

struct Memory {
    char *data;
    size_t size;
};

typedef struct context_t {
    int *playergold;
    struct Memory response;
    json_t *root;
    char **champNames;
    int myTeam;
    bool firstRun;
} context_t;

void set_context(context_t *context);
void free_all_exit(int e, const char *msg);
void handle_sigint(int sig);
void setup_signal_handler(void);
void do_job(context_t *ctx);
struct Memory do_curl(const char *url);

#endif