#include <stdio.h>
#include <string.h>

int main(const int argc, const char* argv[])
{
    if (argc < 2 || strlen(argv[1]) == 0) {
        printf("Usage: %s [string]\n", argv[0]);
        return 1;
    }
    size_t len = strlen(argv[1]);
    int i = len;
    do {
        printf("%c", argv[1][i]);
        i--;
    } while ( i > -1 );
    printf("\n");
    return 0;
}