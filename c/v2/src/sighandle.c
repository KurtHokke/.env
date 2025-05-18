
#include "utils.h"
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

             (ctx->root != NULL)? json_decref(ctx->root)   : (void)printf("ctx->root was NULL\n");
    (ctx->response.data != NULL)? free(ctx->response.data) : (void)printf("ctx->response.data was NULL\n");
       (ctx->playergold != NULL)? free(ctx->playergold)    : (void)printf("ctx->playergold was NULL\n");

    if (ctx->champNames != NULL) {
        for (int i = 0; i < 10; i++) {
            (ctx->champNames[i] != NULL)? free(ctx->champNames[i]) : (void)printf("ctx->champNames[%d] was NULL\n", i);
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
