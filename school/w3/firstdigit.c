/*
Exercise 4: Find First Digit in a String Buffer (while loop with break)
Problem: Write a program that takes a string (max 19 characters) into a buffer. 
Use a while loop to find the first digit (0–9) in the string, stopping with break when found. 
Use type casting to display the digit’s numeric value as a float for consistent formatting, 
and use the ternary operator to say if the digit is "High" (≥ 5) or "Low". If no digit is found, 
display a message.
*/

#include <stdio.h>

#define STR_LEN 20

int main() {
    char str[STR_LEN]; // Buffer for 19 chars + null terminator
    float digit = 0;
    int foundDigit = 0; // For knowing if for loop breaked or not

    printf("Enter 19 char long string: ");
    scanf("%s", &str);
    
    for (int i = 0; i <= STR_LEN; i++) {
        if ((str[i] >= 48) && (str[i] <= 57)) { // ASCII 48 - ASCII 57 (0-9)
            digit = (float)str[i] - 48; // Convenient way of converting from ASCII
            foundDigit = 1;
            break;
        }
    }
    if (foundDigit) {
        (digit >= 5)? printf("High") : printf("Low"); // Print either based on the condition
        printf(" digit: %f\n", digit);
    } else {
        printf("No digit found\n");
    }
    return 0;
}