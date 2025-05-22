/*
Exercise 2: Number Guessing Game (while and break)
Problem: Write a program where the user guesses a hardcoded number (e.g., 42) between 1 and 100. Provide hints ("Too high" or "Too low") until the correct number is guessed or the user enters 0 to quit.
Code Template:
*/
#include <stdio.h>

int main() {
    int secret = 42; // Hardcoded for simplicity
    int guess;
    
    do { // Start do-while loop

        printf("Guess the number (1-100) or enter 0 to quit: ");
        scanf("%d", &guess);

        if (guess < 1 || guess > 100) { //
            printf("Invalid guess\n");  // Check if guess is out of range
            continue;                   //
        }

        if (guess > secret) printf("Too high\n"); // Gives hints
        if (guess < secret) printf("Too low\n");

    } while (guess != secret); // Checks if loop should continue or not
    
    printf("Congratulations, you won!\n");
    
    return 0;
}