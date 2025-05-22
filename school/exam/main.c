/**
 * @file main.c
 * @author Erik Johansson (rednoxsafeg@gmail.com)
 * @brief 
 * @version 0.1
 * @date 2025-05-22
 * 
 * @copyright Copyright (c) 2025
 * 
 */
#include <stdio.h>
#include <stdlib.h>

#define SECRET 64

int main(void)
{
    int attempts = 0;  // Track attempts
    int proximity;     // For calculating absolute difference of guess and SECRET with abs() from stdlib.h
    int guess;         // Variable to store user input

    printf("Game of 'Guess My Number'\n");

    do {  // Start a do-while loop to enable user to keep guessing until correct

        attempts++; // Increment attempts each time by 1

        printf("Enter your guess (1-100): ");
        scanf("%d", &guess);                  // Prompt user for a guess between 1-100

        if (guess == SECRET) {
            continue;          // Effectivly breaking from loop
        }

        if ((guess < 1) || (guess > 100)) {
            printf("Invalid range!\n");     // Check for invalid input
          //attempts--;  // Optional: don't count invalid guesses
            continue;
        }

        proximity = abs(guess - SECRET);  // Calculate absolute difference (returns inverted value if result becomes negative)

        if (proximity <= 15) {
            printf("Hot\n");     // Let user know guess was close to being correct
        }
        if ((proximity > 15) && (proximity <= 40)) { 
            printf("Medium\n");  // Let user know guess was neither close or far away
        }
        if (proximity > 40) {
            printf("Cold\n");    // Let user know guess was far away
        }

    } while (guess != SECRET);   // Only breaks when guess == SECRET

    printf("Correct: %d == %d,\nAttempts: %d\n", 
                  guess, SECRET, attempts);      // Print that guess == SECRET and how many attempts it took
    return 0;
}