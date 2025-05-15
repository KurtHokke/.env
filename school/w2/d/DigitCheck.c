#include <stdio.h>

int main() {
    int newnum = 5, orinum = 5, temp; // Initialize newnum and orinum to 5, temp for input
    int input_error = 0, calc_error = 0; // Flags for input and calculation errors
    setbuf(stdout, NULL); // Disable output buffering for immediate printing
    printf("\n Variable 'newnum' is at start a digit(%d) ", newnum); // Print initial newnum (5)
    printf("\n Enter a digit < 10: "); // Prompt for input
    scanf(" %d", &temp); // Read an integer into temp
    if (temp < 0 || temp > 9) { // Check if input is not a digit (0-9)
        input_error = 1; // Set input error flag
    } else {
        newnum = orinum + temp; // Add input to orinum to get newnum
        calc_error = (newnum > 9) ? 1 : 0; // Set calc_error if newnum > 9
        calc_error = (newnum < 0) ? 1 : calc_error; // Update calc_error if newnum < 0
    }
    if (input_error) { // If input was invalid
        printf("\n Entered number is not a digit (%d)! ", temp); // Print error
    } else { // If input was valid
        printf("\n Variable 'newnum' is "); // Start output
        (calc_error == 1) ? // Ternary: check if newnum is not a digit
            printf("NOT a digit any more (%d) ", newnum) : // If calc_error, print this
            printf("still a digit (%d) ", newnum); // Else, print this
    }
    printf("\n");
    return 0; // Exit program
}
