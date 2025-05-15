
#include <stdio.h>

int main()
{
    int i;
    char vowels[10] = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'};
    char consonants[42] = {
        'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r',
        's', 't', 'v', 'w', 'x', 'y', 'z', 'B', 'C', 'D', 'F', 'G', 'H', 'J',
        'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'V', 'W', 'X', 'Y', 'Z'};

    char c;
    printf("Enter any character of [a-zA-Z]: ");
    scanf("%c", &c);
    for (i = 0; i < 10; i++) {
        if (c == vowels[i]) {
            printf("Vowel\n");
            return 0;
        }
    }
    for (i = 0; i < 42; i++) {
        if (c == consonants[i]) {
            printf("Consonant\n");
            return 0;
        }
    }
    fprintf(stderr, "Not a letter\n");
    return 1;
}
