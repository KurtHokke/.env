
#include <stdio.h>

#define TEAMSIZE 5

typedef struct gSTATS {
    char *champName[TEAMSIZE * 2];
    unsigned int *vs[TEAMSIZE * 2];
    char *playerTeam;
} gSTATS;


void main() {
    gSTATS MyStruct;
    printf("Size of MyStruct: %zu bytes\n", sizeof(MyStruct.champName));
    printf("Size of MyStruct: %zu bytes\n", sizeof(MyStruct.vs));
    printf("Size of MyStruct: %zu bytes\n", sizeof(MyStruct.playerTeam));
}

