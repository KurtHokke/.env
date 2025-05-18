
#include "test.h"
#include <stdio.h>

static context_t *ctx = NULL;

void set_context(context_t *context)
{
    ctx = context;
}

void diditwork()
{
    for (int i = 0; i < 10; i++) {
        printf("%d\n", ctx->playergold[i]);
    }
}