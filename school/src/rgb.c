#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

inline static void processString(const char *input, char *output) {
    if (input == NULL || input[0] == '\0') {
        output[0] = '\0';
        return;
    }
    static uint8_t i = 0;
    i++;
    if (input[0] == 'r') {
        strcpy(output, input + 1);
    } else {
        strcpy(output, input);
    }
}

// Function to convert RGB to Hex
void rgbToHex(uint8_t r, uint8_t g, uint8_t b, char *hex) {
    // Ensure RGB values are in valid range (0-255)
    r = r < 0 ? 0 : (r > 255 ? 255 : r);
    g = g < 0 ? 0 : (g > 255 ? 255 : g);
    b = b < 0 ? 0 : (b > 255 ? 255 : b);
    
    // Convert to hex and store in string
    sprintf(hex, "#%02X%02X%02X", r, g, b);
}

uint8_t main(uint8_t argc, char* argv[]) {
    
    if (argc < 2) return 1;
    if (argc >= 2) {
        uint8_t r = atoi(argv[1]);
    }
    uint8_t g = atoi(argv[2]);
    uint8_t b = atoi(argv[3]);
    
    char hex[8]; // Buffer for hex string (#RRGGBB + null terminator)
    
    rgbToHex(r, g, b, hex);
    
    printf("RGB(%d, %d, %d) = %s\n", r, g, b, hex);
    
    return 0;
}