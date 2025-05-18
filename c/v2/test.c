#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    char **names = malloc(3 * sizeof(char *));
    if (names == NULL) {
        fprintf(stderr, "malloc error\n");
        return 1;
    }

    names[0] = strdup("jocke");
    names[1] = strdup("anna");
    names[2] = strdup("felix");

    printf("%s\n", names[0]);
    printf("%s\n", names[1]);
    printf("%s\n", names[2]);

    free(names[0]);
    free(names[1]);
    free(names[2]);
    free(names);
    return 0;
}