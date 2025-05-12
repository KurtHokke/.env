#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TEAMSIZE 5

typedef struct gold_stats {
    char *champName[TEAMSIZE][2];
    int vs[TEAMSIZE][2];
} gold_stats;



int main() {
    gold_stats mystats = {0};
    int i;
    int j;
    char *names[TEAMSIZE][2] = {
        { "ahse", "garen" },
        { "darius", "fiora" },
        { "fizz", "malph" },
        { "urgot", "sona" },
        { "mf", "yi" }
    };

    for (i = 0; i < TEAMSIZE; i++) {
        for (j = 0; j < 2; j++) {
            mystats.champName[i][j] = malloc(20);
            if (mystats.champName[i][j] == NULL) {
                fprintf(stderr, "Memory allocation failed\n");
                return 1;
            }
        }
    }

    for (i = 0; i < TEAMSIZE; i++) {
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
*/
}