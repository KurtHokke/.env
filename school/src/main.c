#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

inline static void processString(const char *input, char *output) {
    if (input == NULL || input[0] == '\0') {
        output[0] = '\0';
        return;
    }
    char *endptr;
    long value = strtol(input + 1, &endptr, 10); // Parse number after 'r', 'g', 'b'
    if (*endptr != '\0' && *endptr != ' ') {
        return; // Invalid number, leave output unchanged
    }

    if (value < 0 || value > 255) {
        return; // Out of RGB range
    }
    if (input[0] == 'r') {
        snprintf(output, 4, "%03ld", value);
    } else if (input[0] == 'g') {
        snprintf(output + 4, 4, "%03ld", value);
    } else if (input[0] == 'b') {
        snprintf(output + 8, 4, "%03ld", value);
    } else {
        strcpy(output, input);
    }
}

int main(void) {
    char rgb[] = "g50";
    char output[12] = "000 000 000";
    processString(rgb, output);
    printf("%s\n", output);
    return 0;
}

