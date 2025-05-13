#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define TEAMSIZE 5
#define INITIATE 1
#define DESTROY 0

typedef struct gSTATS {
    char *champName[TEAMSIZE * 2];
    int vs[TEAMSIZE * 2];
} gSTATS;

bool handle_struct(gSTATS *data, int I_OR_D) {
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

int main() {
    int i;
    gSTATS mystats = {0};

    if (!handle_struct(&mystats, INITIATE)) {
        fprintf(stderr, "failed to initiate struct\n");
        return 1;
    } else {
        if (!handle_struct(&mystats, DESTROY)) {
            fprintf(stderr, "failed to destroy struct\n");
            return 1;
        }
    }
    return 0;
}
/*    
    char *names[TEAMSIZE * 2] = { "ahse", "garen", "darius", "fiora", "fizz", "malph", "urgot", "sona", "mf", "yi" };


    for (i = 0; i < TEAMSIZE * 2; i++) {
        for (j = 0; j < 2; j++) {
            strcpy(mystats.champName[i][j], names[i][j]);
            if (strcmp(mystats.champName[i][j], names[i][j]) == 0) {
                printf("Successfully copied '%s' to mystats.champName[%d][%d]\n", mystats.champName[i][j], i, j);
            } else {
                fprintf(stderr, "failed to copy '%s' to mystats.champName[%d][%d]\n", mystats.champName[i][j], i, j);
                goto end;
            }
        }
    }
    end:
        for (i = 0; i < TEAMSIZE; i++) {
            for (j = 0; j < 2; j++) {
                if (mystats.champName[i][j] != NULL) {
                    free(mystats.champName[i][j]); // Free each allocated string
                    mystats.champName[i][j] = NULL; // Optional: avoid dangling pointers
                    printf("Successfully freed mystats.champName[%d][%d]\n", i, j);
                }
            }
        }
    return 0;

/*
    mystats.vs[2][1] = 15;
    printf("%d %d\n", mystats.vs[0][0], mystats.vs[0][1]);
    printf("%d %d\n", mystats.vs[1][0], mystats.vs[1][1]);
    printf("%d %d\n", mystats.vs[2][0], mystats.vs[2][1]);
    printf("%d %d\n", mystats.vs[3][0], mystats.vs[3][1]);
    printf("%d %d\n", mystats.vs[4][0], mystats.vs[4][1]);
    return 0;

}
*/