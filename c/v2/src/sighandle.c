#include "utils.h"
#include <ncurses.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <jansson.h>
#include <curl/curl.h>

static context_t *ctx = NULL;

void set_context(context_t *context)
{
    ctx = context;
}

void free_all_exit(int e, const char *msg)
{
    printf("%s\n", msg);
    printf("freeing all\n");

             (ctx->root != NULL)? json_decref(ctx->root)      : (void)printf("ctx->root was NULL\n");
           (ctx->root_i != NULL)? json_decref(ctx->root_i)    : (void)printf("ctx->root_i was NULL\n");
          (ctx->mainwin != NULL)? cleanup_tui(ctx->mainwin)   : (void)printf("ctx->mainwin was NULL\n");
    (ctx->response.data != NULL)? free(ctx->response.data)    : (void)printf("ctx->response.data was NULL\n");
 (ctx->lolVersions.data != NULL)? free(ctx->lolVersions.data) : (void)printf("ctx->lolVersions.data was NULL\n");
    (ctx->lolItems.data != NULL)? free(ctx->lolItems.data)    : (void)printf("ctx->lolItems.data was NULL\n");
       (ctx->playergold != NULL)? free(ctx->playergold)       : (void)printf("ctx->playergold was NULL\n");
            (ctx->lol_V != NULL)? free(ctx->lol_V)            : (void)printf("ctx->lol_V was NULL\n");
        (ctx->items_URL != NULL)? free(ctx->items_URL)        : (void)printf("ctx->items_URL was NULL\n");
    
    ctx->root = NULL;
    ctx->root_i = NULL;
    ctx->mainwin = NULL;
    ctx->response.data = NULL;
    ctx->lolVersions.data = NULL;
    ctx->lolItems.data = NULL;
    ctx->playergold = NULL;
    ctx->lol_V = NULL;
    ctx->items_URL = NULL;

    if (ctx->champNames != NULL) {
        for (int i = 0; i < 10; i++) {
            (ctx->champNames[i] != NULL)? free(ctx->champNames[i]) : (void)printf("ctx->champNames[%d] was NULL\n", i);
            ctx->champNames[i] = NULL;
        }
        free(ctx->champNames);
    }
    curl_global_cleanup();
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
