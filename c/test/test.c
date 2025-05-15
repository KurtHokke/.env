
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void)
{
    int c;
    c = getchar();
    printf("%d\n", c);
    return 0;
}

/*
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// Example resource (e.g., dynamically allocated memory)
char *buffer = NULL;

// Cleanup function
void cleanup(void) {
    printf("Performing cleanup...\n");
    if (buffer != NULL) {
        free(buffer); // Free allocated memory
        buffer = NULL;
    }
    // Add other cleanup tasks (e.g., close files, sockets, etc.)
    printf("Cleanup complete.\n");
}

int main(void) {
    // Allocate some example resource
    buffer = (char *)malloc(100 * sizeof(char));
    if (buffer == NULL) {
        perror("Memory allocation failed");
        return 1;
    }

    printf("Enter input (Ctrl+D to quit):\n");

    // Read input character by character
    int ch;
    while (1) {
        usleep(1000000);
        printf("sleept\n");
        if ((ch = getchar()) == EOF) {
            // Ctrl+D detected (EOF)
            printf("\nCtrl+D detected. Cleaning up and exiting...\n");

            // Perform cleanup
            cleanup();
            // Exit program
            return 0;
        }
    }
}
*/