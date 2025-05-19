#include "utils.h"
#include <ncurses.h>
#include <stdio.h>
#include <stdlib.h>

#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <jansson.h>
#include <curl/curl.h>
#include <assert.h>

//for sharing with sighandle.c
static context_t *context = NULL;

int main(void)
{
    setup_signal_handler();
    context_t ctx = {
        .playergold       = NULL,
        .response.data    = NULL,
        .response.size    = 0,
        .lolVersions.data = NULL,
        .lolVersions.size = 0,
        .lolItems.data    = NULL,
        .lolItems.size    = 0,
        .root             = NULL,
        .root_i           = NULL,
        .mainwin          = NULL,
        .champNames       = NULL,
        .lol_V            = NULL,
        .items_URL        = NULL,
        .myTeam           = 0,
        .firstRun         = true
    };
    context = &ctx;
    set_context(&ctx); //shares ctx with sighandle.c
    curl_global_init(CURL_GLOBAL_DEFAULT);

    ctx.lolVersions = do_curl(LOL_VERSIONS_URL);
    if (ctx.lolVersions.data == NULL || ctx.lolVersions.size == 0) {
        free_all_exit(1, "curl failed");
    }

    //extract latest game version by parsing json data
    ctx.lol_V = get_lol_v(ctx.lolVersions.data);
    free(ctx.lolVersions.data);   //
    ctx.lolVersions.data = NULL;  //  instantly free leftover data
    ctx.lolVersions.size = 0;     //

    ctx.items_URL = malloc(101);
    if (ctx.items_URL == NULL) {
        free_all_exit(1, "items_URL malloc failed");
    }
    //construct the final items.json url
    snprintf(ctx.items_URL, 101, LOL_ITEMS_URL(ctx.lol_V));
    free(ctx.lol_V);   //
    ctx.lol_V = NULL;  //  instantly free leftover data

    //request items.json from url and store it temporarily in char*
    ctx.lolItems = do_curl(ctx.items_URL);
    free(ctx.items_URL);   //
    ctx.items_URL = NULL;  //  instantly free leftover data

    if (ctx.lolItems.data == NULL || ctx.lolItems.size == 0) {
        free_all_exit(1, "curl failed");
    }

    //convert char* items.json to (jansson.h)json_t type
    get_lol_items(&ctx.root_i, ctx.lolItems.data);
    free(ctx.lolItems.data);   //
    ctx.lolItems.data = NULL;  //  instantly free leftover data
    ctx.lolItems.size = 0;     //

    //allocate size for 10 pointers
    ctx.champNames = calloc(10, sizeof(char *));
    if (ctx.champNames == NULL) {
        free_all_exit(1, "ctx.champNames malloc failed");
    }
    ctx.playergold = calloc(10, sizeof(int));
    if (ctx.playergold == NULL) {
        free_all_exit(1, "ctx.playergold malloc failed");
    }

    //explicity set all array to NULL
    //for (size_t i = 0; i < 10; i++) {
    //    if (ctx.champNames != NULL) {
    //        ctx.champNames[i] = NULL;
    //    }
    //}

    while (true) {
        do_job(&ctx);
        system("clear");
        for (size_t i = 0; i < 5; i++) {
            if (ctx.myTeam == 0) {
                if (ctx.playergold[i] - ctx.playergold[i + 5] < 0) {
                    printf(GOLD_COLOR_RED, 
                           ctx.champNames[i], ctx.playergold[i] - ctx.playergold[i + 5], ctx.champNames[i + 5]);
                } else {
                    printf(GOLD_COLOR_GREEN, 
                           ctx.champNames[i], ctx.playergold[i] - ctx.playergold[i + 5], ctx.champNames[i + 5]);
                }
            } else {
                if (ctx.playergold[i + 5] - ctx.playergold[i] < 0) {
                    printf(GOLD_COLOR_RED, 
                           ctx.champNames[i + 5], ctx.playergold[i + 5] - ctx.playergold[i], ctx.champNames[i]);
                } else {
                    printf(GOLD_COLOR_GREEN, 
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

    //for (int i = 0; i < 10; i++) {
    //    (ctx->champNames[i] != NULL)? free(ctx->champNames[i]) : (void)printf("champNames[%d] was NULL\n", i);
    //    ctx->champNames[i] = NULL;
    //}
    ctx->response = do_curl(LOL_GAME_URL);
    if (ctx->response.data == NULL || ctx->response.size == 0) {
        free_all_exit(1, "curl failed");
    }

    ctx->root = json_loads(ctx->response.data, 0, &error);
    free(ctx->response.data);
    ctx->response.data = NULL;
    ctx->response.size = 0;

    if (!ctx->root) {
        printf("ERROR: %s\n", error.text);
        printf("Error while parsing JSON(%d): %s\n", error.line, error.text);
        free_all_exit(1, "err");
    }
    ASSERT_JSON_TYPE(ctx->root, JSON_T_OBJECT, 0);

    if (ctx->firstRun) {
        myplayer = json_object_get(ctx->root, "activePlayer");
        ASSERT_JSON_TYPE(myplayer, JSON_T_OBJECT, 0);

        myriotId = json_object_get(myplayer, "riotId");
        ASSERT_JSON_TYPE(myriotId, JSON_T_STRING, 0);
    }

    players = json_object_get(ctx->root, "allPlayers");
    ASSERT_JSON_TYPE(players, JSON_T_ARRAY, 0);

    for (size_t i = 0; i < json_array_size(players); i++)
    {
        json_t *riotId    = NULL;

        json_t *champ     = NULL;
        json_t *champName = NULL;
        json_t *items     = NULL;
        int totalgold = 0;

        champ = json_array_get(players, i);
        ASSERT_JSON_TYPE(champ, JSON_T_OBJECT, 0);

        if (ctx->firstRun) {
            riotId = json_object_get(champ, "riotId");
            ASSERT_JSON_TYPE(riotId, JSON_T_STRING, 0);

            if (json_equal(riotId, myriotId)) {
                myplayerTeam = json_object_get(champ, "team");
                ASSERT_JSON_TYPE(myplayerTeam, JSON_T_STRING, 0);

                ctx->myTeam = (strcmp(json_string_value(myplayerTeam), "ORDER") == 0)? 0 : 1;
            }
        }

        items = json_object_get(champ, "items");
        ASSERT_JSON_TYPE(items, JSON_T_ARRAY, 0);

        for (size_t j = 0; j < json_array_size(items); j++) {
            json_t *item   = NULL; 
            json_t *itemID = NULL;
            json_t *count  = NULL;

            uint8_t itemstack = 1;

            item = json_array_get(items, j);
            ASSERT_JSON_TYPE(item, JSON_T_OBJECT, 0);

            itemID = json_object_get(item, "itemID");
            ASSERT_JSON_TYPE(itemID, JSON_T_INTEGER, 0);

            count = json_object_get(item, "count");
            if ((json_is_integer(count)) && (json_integer_value(count) > itemstack)) {
                itemstack = json_integer_value(count);
            }

            ASSERT_JSON_TYPE(count, JSON_T_INTEGER, 0);

            totalgold += ( itemstack * get_price_of(ctx->root_i, (int)json_integer_value(itemID)) );
        }
        ctx->playergold[i] = totalgold;


        champName = json_object_get(champ, "championName");
        ASSERT_JSON_TYPE(champName, JSON_T_STRING, 0);

        if ((ctx->champNames[i] != NULL) || (ctx->firstRun))
        {
            if (ctx->firstRun)
            {
                ctx->champNames[i] = strdup(json_string_value(champName));
            } 
            else if (strcmp(ctx->champNames[i], 
                       json_string_value(champName)) != 0)
            {
                free(ctx->champNames[i]);
                ctx->champNames[i] = NULL;

                ctx->champNames[i] = strdup(json_string_value(champName));
            }
        }
        
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
        json_decref(root_v);
        free_all_exit(1, "err");
    }
    ASSERT_JSON_TYPE(root_v, JSON_T_ARRAY, JSON_T_DO_DECREF);

    current_v = json_array_get(root_v, 0);
    ASSERT_JSON_TYPE(current_v, JSON_T_STRING, JSON_T_DO_DECREF);

    char *version_string = strdup(json_string_value(current_v));
    json_decref(root_v);

    return version_string;
}


//retrieve items json database
void get_lol_items(json_t **root_i, char *data)
{

    json_error_t error_i;
    json_t *root_tmp = NULL;
    json_t *data_tmp = NULL;
    root_tmp = json_loads(data, 0, &error_i);

    if (!root_tmp) {
        printf("ERROR: %s\n", error_i.text);
        printf("Error while parsing JSON(%d): %s\n", error_i.line, error_i.text);
        json_decref(root_tmp);
        free_all_exit(1, "err");
    }
    ASSERT_JSON_TYPE(root_tmp, JSON_T_OBJECT, JSON_T_DO_DECREF);

    data_tmp = json_object_get(root_tmp, "data");
    ASSERT_JSON_TYPE(root_tmp, JSON_T_OBJECT, JSON_T_DO_DECREF);

    *root_i = json_deep_copy(data_tmp); //make a deep copy of items database so layers above it can be freed
    json_decref(root_tmp);
}

//get total price of given itemID
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
    ASSERT_JSON_TYPE(item, JSON_T_OBJECT, 0);

    gold = json_object_get(item, "gold");
    ASSERT_JSON_TYPE(gold, JSON_T_OBJECT, 0);

    total = json_object_get(gold, "total");
    ASSERT_JSON_TYPE(total, JSON_T_INTEGER, 0);

    price = json_integer_value(total);
    return price;
}