#include "utils.h"
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>


void msg(FILE *file, char *msg) {
    char buffer[LOG_MAXSIZE]; // Adjust size as needed
    if (msg != NULL) {
        snprintf(buffer, sizeof(buffer), "Message: %s\n", msg);
        fputs(buffer, file);
    }
}

bool gSTATS_handler(gSTATS *data, int I_OR_D) {
    int i = 0;
    if (I_OR_D == INITIATE) {
        for (i = 0; i < TEAMSIZE * 2; i++) {

            data->champName[i] = malloc(30);
            data->vs[i] = (unsigned int*)malloc(sizeof(unsigned int));

            if (data->champName[i] == NULL) {
                msg(stderr, "ERROR:'utils.c',line(22): 'if (data->champName[i] == NULL)'");
                return false;
            }
            #ifdef DEBUG
            printf("+champName[%d] at %p\n+vs[%d] at %p\n", i, (void *)data->champName[i], i, (void *)data->vs[i]);
            #endif
        }
    } else if (I_OR_D == DESTROY) {
        for (i = 0; i < TEAMSIZE * 2; i++) {
            if (data->champName[i] != NULL && data->vs[i] != NULL) {
                #ifdef DEBUG
                printf("-champName[%d] at %p\n-vs[%d] at %p\n", i, (void *)data->champName[i], i, (void *)data->vs[i]); 
                #endif
            }
            if (data->champName[i] != NULL) {
                free(data->champName[i]);
                data->champName[i] = NULL;

            }
            if (data->vs[i] != NULL) {
                free(data->vs[i]);
                data->vs[i] = NULL;
            }
        }
    } else {
        return false;
    }
    return true;
}

