/*
Exercise 3: Count Letters in a String Buffer (for loop with continue)
Problem: Write a program that takes a string (max 19 characters) into a buffer. 
Use a for loop to count the number of alphabetic letters (a–z, A–Z), 
skipping non-letters (e.g., numbers, symbols) with continue. 
Use type casting to calculate the percentage of the buffer used by letters, 
and use the ternary operator to say if the letter count is "Many" (≥ 5) or "Few".
*/

#include <stdio.h>

#define STR_LEN 20

int main() {
    char str[STR_LEN]; // Buffer for 19 chars + null terminator
    int totalLetters = 0;
    float percent = 0;
    printf("Enter 19 char long string: ");
    scanf("%s", &str);
    
    for (int i = 0; i <= STR_LEN; i++) {
        if ((str[i] < 65) || (str[i] > 90) && (str[i] < 97) || (str[i] > 122)) {
            continue; // Check if current characters decimal value fits any of the
        }             // alphabetic characters in the ASCII table
        totalLetters++;
    }
    percent = 100 * (float)totalLetters / (STR_LEN - 1); // Get percent
    (totalLetters >= 5)? printf("Many") : printf("Few"); // Print either based on the condition
    printf(" letters: %d\n", totalLetters);
    printf("%f%c of string buffer consisted of alphabetic characters\n", percent, '%');
    return 0;
}