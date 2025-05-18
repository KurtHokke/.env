#include "utils.h"
#include <stdio.h>
#include <stdlib.h>

#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <jansson.h>
#include <curl/curl.h>
//#include <curses.h>


static context_t *context = NULL;

void get_lol_items(json_t **root_i, char *data)
{
    json_error_t error_i;
    json_t *root_tmp = NULL;
    json_t *data_tmp = NULL;

    root_tmp = json_loads(data, 0, &error_i);

    if (!root_tmp) {
        printf("ERROR: %s\n", error_i.text);
        printf("Error while parsing JSON(%d): %s\n", error_i.line, error_i.text);
        free_all_exit(1, "err");
    }

    if (!json_is_object(root_tmp)) {
        free_all_exit(1, "root_tmp !object");
    }

    data_tmp = json_object_get(root_tmp, "data");
    if (!json_is_object(data_tmp)) {
        free_all_exit(1, "data_tmp !object");
    }

    *root_i = json_deep_copy(data_tmp);
    
    json_decref(root_tmp);

}

int get_price_of(json_t *root_i, int id)
{
    if (root_i == NULL) {
        return -1;
    }
    
    int price;
    json_t *item = NULL;
    json_t *gold = NULL;
    json_t *total = NULL;

    char itemID[6];
    snprintf(itemID, sizeof(itemID), "%d", id);

    item = json_object_get(root_i, itemID);
    if (!json_is_object(item)) {
        return -1;
    }
    gold = json_object_get(item, "gold");
    if (!json_is_object(gold)) {
        return -1;
    }
    total = json_object_get(gold, "total");
    if (!json_is_integer(total)) {
        return -1;
    }

    price = json_integer_value(total);
    return price;
}

int main(void)
{
    setup_signal_handler();
    curl_global_init(CURL_GLOBAL_DEFAULT);

    context_t ctx = {
        .playergold       = NULL,
        .response.data    = NULL,
        .response.size    = 0,
        .lolVersions.data = NULL,
        .lolVersions.size = 0,
        .lolItems.data    = NULL,
        .lolItems.size    = 0,
        .root             = NULL,
        .root_v           = NULL,
        .root_i           = NULL,
        .champNames       = NULL,
        .lol_V            = NULL,
        .items_URL        = NULL,
        .myTeam           = 0,
        .firstRun         = true
    };
    context = &ctx;
    set_context(&ctx);

    ctx.lolVersions = do_curl(LOL_VERSIONS_URL);
    if (ctx.lolVersions.data == NULL || ctx.lolVersions.size == 0) {
        free_all_exit(1, "curl failed");
    }

    ctx.lol_V = get_lol_v(ctx.lolVersions.data);
    free(ctx.lolVersions.data);
    ctx.lolVersions.data = NULL;
    ctx.lolVersions.size = 0;

    ctx.items_URL = malloc(101);
    if (ctx.items_URL == NULL) {
        free_all_exit(1, "items_URL malloc failed");
    }

    snprintf(ctx.items_URL, 101, LOL_ITEMS_URL(ctx.lol_V));
    free(ctx.lol_V);
    ctx.lol_V = NULL;

    ctx.lolItems = do_curl(ctx.items_URL);
    free(ctx.items_URL);
    ctx.items_URL = NULL;
    if (ctx.lolItems.data == NULL || ctx.lolItems.size == 0) {
        free_all_exit(1, "curl failed");
    }

    get_lol_items(&ctx.root_i, ctx.lolItems.data);

    //int priceof = get_price_of(ctx.root_i, 3152);
    //printf("\n\npriceof: %d\n\n", priceof);

    ctx.champNames = malloc(10 * sizeof(char *));
    if (ctx.champNames == NULL) {
        free_all_exit(1, "ctx.champNames malloc failed");
    }
    ctx.playergold = malloc(10 * sizeof(int));
    if (ctx.playergold == NULL) {
        free_all_exit(1, "ctx.playergold malloc failed");
    }

    int i;
    for (i = 0; i < 10; i++) {
        if (ctx.champNames != NULL) {
            ctx.champNames[i] = NULL;
        }
    }

    while (true) {
        do_job(&ctx);
        system("clear");
        for (i = 0; i < 5; i++) {
            if (ctx.myTeam == 0) {
                if (ctx.playergold[i] - ctx.playergold[i + 5] < 0) {
                    printf("\033[1;38;5;33m%s\033[0m\n \033[38;5;196m%d\033[0m\n\033[1;38;5;162m%s\033[0m\n\n", 
                            ctx.champNames[i], ctx.playergold[i] - ctx.playergold[i + 5], ctx.champNames[i + 5]);
                } else {
                    printf("\033[1;38;5;33m%s\033[0m\n \033[38;5;40m%d\033[0m\n\033[1;38;5;162m%s\033[0m\n\n", 
                            ctx.champNames[i], ctx.playergold[i] - ctx.playergold[i + 5], ctx.champNames[i + 5]);
                }
            } else {
                if (ctx.playergold[i + 5] - ctx.playergold[i] < 0) {
                    printf("\033[1;38;5;33m%s\033[0m\n \033[38;5;196m%d\033[0m\n\033[1;38;5;162m%s\033[0m\n\n", 
                            ctx.champNames[i + 5], ctx.playergold[i + 5] - ctx.playergold[i], ctx.champNames[i]);
                } else {
                    printf("\033[1;38;5;33m%s\033[0m\n \033[38;5;40m%d\033[0m\n\033[1;38;5;162m%s\033[0m\n\n", 
                            ctx.champNames[i + 5], ctx.playergold[i + 5] - ctx.playergold[i], ctx.champNames[i]);
                }
            }
        }
        ctx.firstRun = false;
        usleep(2500000);
    }
    free_all_exit(0, "WORKING!");
}



void do_job(context_t *ctx)
{
    json_error_t error;
    json_t *myplayer     = NULL;
    json_t *myriotId   = NULL;
    json_t *myplayerTeam = NULL;

    json_t *players = NULL;

    for (int i = 0; i < 10; i++) {
        (ctx->champNames[i] != NULL)? free(ctx->champNames[i]) : (void)printf("champNames[%d] was NULL\n", i);
        ctx->champNames[i] = NULL;
    }
    ctx->response = do_curl(LOL_GAME_URL);
    if (ctx->response.data == NULL || ctx->response.size == 0) {
        free_all_exit(1, "curl failed");
    }

    ctx->root = json_loads(ctx->response.data, 0, &error);
    free(ctx->response.data);
    ctx->response.data = NULL;

    if (!ctx->root) {
        printf("ERROR: %s\n", error.text);
        printf("Error while parsing JSON(%d): %s\n", error.line, error.text);
        free_all_exit(1, "err");
    }
    if (!json_is_object(ctx->root)) {
        free_all_exit(1, "root !object");
    }

    if (ctx->firstRun) {
        myplayer = json_object_get(ctx->root, "activePlayer");
        if (!json_is_object(myplayer)) {
            free_all_exit(1, "myplayer !object");
        }
        myriotId = json_object_get(myplayer, "riotId");
        if (!json_is_string(myriotId)) {
            free_all_exit(1, "myriotId !string");
        }
    }

    players = json_object_get(ctx->root, "allPlayers");
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

        if (ctx->firstRun) {
            riotId = json_object_get(champ, "riotId");
            if (!json_is_string(riotId)) {
                free_all_exit(1, "riotId !string");
            }
            if (json_equal(riotId, myriotId)) {
                myplayerTeam = json_object_get(champ, "team");
                if (!json_is_string(myplayerTeam)) {
                    free_all_exit(1, "myplayerTeam !string");
                }
                ctx->myTeam = (strcmp(json_string_value(myplayerTeam), "ORDER") == 0)? 0 : 1;
            }
        }

        items = json_object_get(champ, "items");
        if (!json_is_array(items)) {
            free_all_exit(1, "items !array");
        }
        for (j = 0; j < json_array_size(items); j++) {
            json_t *item, *itemID;

            item = json_array_get(items, j);
            if (!json_is_object(item)) {
                free_all_exit(1, "item !object");
            }

            itemID = json_object_get(item, "itemID");
            if (!json_is_integer(itemID)) {
                free_all_exit(1, "itemID !int");
            }
            
            totalgold += get_price_of(ctx->root_i, (int)json_integer_value(itemID));
        }
        ctx->playergold[i] = totalgold;


        champName = json_object_get(champ, "championName");
        if (!json_is_string(champName)) {
            free_all_exit(1, "champName !string");
        }

        ctx->champNames[i] = strdup(json_string_value(champName));
    }
    json_decref(ctx->root);
    ctx->root = NULL;
}


char *get_lol_v(char *data)
{

    json_error_t error_v;
    json_t *root_v    = NULL;
    json_t *current_v = NULL;

    root_v = json_loads(data, 0, &error_v);

    if (!root_v) {
        printf("ERROR: %s\n", error_v.text);
        printf("Error while parsing JSON(%d): %s\n", error_v.line, error_v.text);
        free_all_exit(1, "err");
    }

    if (!json_is_array(root_v)) {
        free_all_exit(1, "root_v !array");
    }

    current_v = json_array_get(root_v, 0);
    if (!json_is_string(current_v)) {
        free_all_exit(1, "current_v !string");
    }

    char *version_string = strdup(json_string_value(current_v));
    
    json_decref(root_v);

    return version_string;
}
