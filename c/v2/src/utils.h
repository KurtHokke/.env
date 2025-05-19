
#ifndef UTILS_H
#define UTILS_H

#include <ncurses.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <jansson.h>

#define STR(x) #x
//#define Pf(fmt, ...) printf(fmt "\n", ##__VA_ARGS__)

#define LOL_GAME_URL "https://127.0.0.1:2999/liveclientdata/allgamedata"
#define LOL_VERSIONS_URL "https://ddragon.leagueoflegends.com/api/versions.json"
#define LOL_ITEMS_URL(LOL_VERSION) "https://ddragon.leagueoflegends.com/cdn/%s/data/en_US/item.json", LOL_VERSION

#define GOLD_COLOR_RED   "\033[1;38;5;33m%s\033[0m\n \033[38;5;196m%d\033[0m\n\033[1;38;5;162m%s\033[0m\n\n"
#define GOLD_COLOR_GREEN "\033[1;38;5;33m%s\033[0m\n \033[38;5;40m%d\033[0m\n\033[1;38;5;162m%s\033[0m\n\n"

#define JSON_T_OBJECT    (1 << 0)
#define JSON_T_ARRAY     (1 << 1)
#define JSON_T_STRING    (1 << 2)
#define JSON_T_INTEGER   (1 << 3)
#define JSON_T_DO_DECREF (1 << 4)

#define ASSERT_JSON_TYPE(data, type, should_decref) \
do { \
    switch (type) { \
    case JSON_T_OBJECT:  if (!json_is_object(data))  { \
                             if (should_decref == JSON_T_DO_DECREF) { json_decref(data); printf("did decref\n"); } free_all_exit(1, ""#data" !object"); break; } else { break; } \
    case JSON_T_ARRAY:   if (!json_is_array(data))   { \
                             if (should_decref == JSON_T_DO_DECREF) { json_decref(data); printf("did decref\n"); } free_all_exit(1, ""#data" !array"); break;  } else { break; } \
    case JSON_T_STRING:  if (!json_is_string(data))  { \
                             if (should_decref == JSON_T_DO_DECREF) { json_decref(data); printf("did decref\n"); } free_all_exit(1, ""#data" !string"); break; } else { break; } \
    case JSON_T_INTEGER: if (!json_is_integer(data)) { \
                             if (should_decref == JSON_T_DO_DECREF) { json_decref(data); printf("did decref\n"); } free_all_exit(1, ""#data" !integer"); break;} else { break; } \
    default: free_all_exit(1, "ASSERT_JSON_TYPE macro fail"); \
    } \
} while (0)

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
    json_t *root_i;
    WINDOW *mainwin;
    char **champNames;
    char *lol_V;
    char *items_URL;
    int myTeam;
    bool firstRun;
} context_t;

enum colors {
    ORDER=1,
    CHAOS,
    GREEN_GOLD,
    RED_GOLD
};

void set_context(context_t *context);
void free_all_exit(int e, const char *msg);
void handle_sigint(int sig);
void setup_signal_handler(void);

void get_lol_items(json_t **root_i, char *data);
int get_price_of(json_t *root_i, int id);
char *get_lol_v(char *data);
void do_job(context_t *ctx);
struct Memory do_curl(const char *url);

void cleanup_tui(WINDOW *mainwin);
void ncurses_tui(WINDOW *mainwin);
void redraw_screen(WINDOW *win);

#endif