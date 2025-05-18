#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

void free_all()
{
    printf("freeing all\n");
}

void handle_sigint(int sig)
{
    printf("%d Exiting..\n", sig);
    free_all();
    exit(0);
}

void setup_signal_handler(void)
{
    struct sigaction sa;

    sa.sa_handler = handle_sigint;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;

    if (sigaction(SIGINT, &sa, NULL) == -1) {
        perror("Failed to set up SIGINT handler");
        exit(1); // Exit if handler setup fails
    }
}

int main()
{
    setup_signal_handler();
    printf("waiting...\n");
    while(1)
    {

    }
    return 0;
}