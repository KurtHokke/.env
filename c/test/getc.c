
#include <errno.h>
#include <fcntl.h> // For fcntl()
#include <stdio.h>
#include <stdlib.h>
#include <termios.h> // For terminal settings
#include <unistd.h>  // For usleep()

// Example resource
char *buffer = NULL;

// Original terminal settings (to restore on exit)
struct termios orig_termios;

// Cleanup function
void cleanup(void)
{
    printf("\nPerforming cleanup...\n");
    if (buffer != NULL) {
        free(buffer);
        buffer = NULL;
    }
    // Restore terminal settings
    tcsetattr(STDIN_FILENO, TCSANOW, &orig_termios);
    printf("Cleanup complete.\n");
}

// Enable raw mode for terminal
void enable_raw_mode(void)
{
    struct termios raw;

    // Get original terminal settings
    tcgetattr(STDIN_FILENO, &orig_termios);

    // Copy original settings to modify
    raw = orig_termios;

    // Disable canonical mode (line buffering), echo, and signals
    raw.c_lflag &= ~(ICANON | ECHO | ISIG);
    // Minimum number of characters to read (1)
    raw.c_cc[VMIN] = 1;
    // Timeout (0 for non-blocking)
    raw.c_cc[VTIME] = 0;

    // Apply new settings
    tcsetattr(STDIN_FILENO, TCSANOW, &raw);

    // Set stdin to non-blocking
    int flags = fcntl(STDIN_FILENO, F_GETFL, 0);
    fcntl(STDIN_FILENO, F_SETFL, flags | O_NONBLOCK);
}

int main(void)
{
    // Allocate resource
    buffer = (char *)malloc(100 * sizeof(char));
    if (buffer == NULL) {
        perror("Memory allocation failed");
        return 1;
    }

    // Register cleanup function
    if (atexit(cleanup) != 0) {
        fprintf(stderr, "Failed to register cleanup function\n");
        free(buffer);
        return 1;
    }

    // Enable raw mode for terminal
    enable_raw_mode();

    printf("Program running. Type keys (Ctrl+D to quit).\n");

    while (1) {
        // Simulate program work
        printf("sleept\n");
        usleep(1000000); // 1 second

        // Check for input (non-blocking)
        int ch = getchar();
        if (ch == 113) {
            if (errno == EAGAIN) {
                // No input available, continue
                errno = 0; // Clear errno
            } else {
                // Ctrl+D detected (EOF)
                printf("\nCtrl+D detected. Exiting...\n");
                return 0; // Cleanup via atexit()
            }
        } else {
            // Other key pressed, process it (optional)
            printf("You typed: %c\n", ch);
        }
    }

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