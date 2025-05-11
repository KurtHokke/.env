#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int validateInt(char* str, int* result) {
    for (int i = 0; str[i]; i++) {
        if (!isdigit(str[i])) {
            printf("int invalid\n");
            return 1;
        }
    }
    *result = atoi(str);
    return 0;
}

int main(int argc, char* argv[]) {

    int num;
    char* numstr;
    if (argc == 2) {
        if ((validateInt(argv[1], &num)) == 0) {
            goto end;
        } else {
            goto manual;
        }
    }
    manual:
        do {
            printf("Enter number: ");
            scanf("%s", &numstr);
        } while ((validateInt(numstr, &num)) == 1);
    end:
        printf("Entered number: %d\n", num);
    return 0;
}