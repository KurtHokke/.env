#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    char text[100][100];
    int lines = 0;
    FILE *fileptr = fopen("text.txt", "r");
    if (fileptr == NULL) {
        printf("error file\n");
        return 1;
    }
    while (fgets(text[lines], sizeof(text[0]), fileptr) != NULL) {
        lines++;
    }
    fclose(fileptr);
    for (int i = lines - 1; i >= 0; i--) {
        if (text[i][0] == '\n') {
            continue;
        }
        printf("sdads%s", text[i]);
    }
    printf("\n");
    return 0;

}