#include "utils.h"
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>


void log_message(FILE *file, const char *message) {
    char buffer[1024]; // Adjust size as needed
    snprintf(buffer, sizeof(buffer), "Message: %s\n", message);
    fputs(buffer, file);
}

bool gSTATS_handler(gSTATS *data, int I_OR_D) {
    int i = 0;
    if (I_OR_D == INITIATE) {
        for (i = 0; i < TEAMSIZE * 2; i++) {
            data->champName[i] = malloc(20);
            if (data->champName[i] == NULL) {
                fprintf(stderr, "Memory allocation failed\n");
                return false;
            }
#ifdef DEBUG
            printf("Allocated champName[%d] at %p\n", i, (void *)data->champName[i]);
#endif
        }
    } else if (I_OR_D == DESTROY) {
        for (i = 0; i < TEAMSIZE * 2; i++) {
            if (data->champName[i] != NULL) {
#ifdef DEBUG
                printf("Freeing champName[%d] at %p\n", i, (void *)data->champName[i]); 
#endif
                free(data->champName[i]);
                data->champName[i] = NULL;
            }
        }
    } else {
        return false;
    }
    return true;
}

