#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include <fcntl.h>
#include <unistd.h>

#define e_PRINT(l, fmt, ...)                                                   \
    fprintf(stderr, "%s:%d: " fmt "\n", __FILE__, __LINE__ + l, ##__VA_ARGS__)

int get_random(uint8_t *result)
{
    int fd = open("/dev/urandom", O_RDONLY);
    if (fd < 0)
        return -1;
    ssize_t bytes_read;
    while (*result == 0 || *result > 100)
    {
        bytes_read = read(fd, result, sizeof(uint8_t));
        if (bytes_read != sizeof(uint8_t))
        {
            close(fd);
            return -1; // Read failed
        }
    }
    close(fd);
    return 0;
}

int main()
{
    uint8_t rand_num;

    rand_num = 0;
    if (get_random(&rand_num) != 0)
    {
        e_PRINT(-1, "error");
        return 1;
    }

    int guess;
    int proximity;
Guesser:
    printf("Guess ");

    while (1)
    {
        printf("number(1-255): ");
        if (scanf("%d", &guess) != 1)
        {
            int c;
            while ((c = getchar()) != '\n' && c != EOF)
            {
            }
            printf("Invalid guess!\nGuess again ");
            continue;
        }
        int c;
        while ((c = getchar()) != '\n' && c != EOF)
        {
        }
        if (guess <= 0 || guess > 255)
        {
            printf("Invalid guess!\nGuess again ");
            continue;
        }
        break;
    }

    printf("%d\n", guess);
    printf("%d\n", rand_num);
    proximity = abs(guess - rand_num);
    printf("%d\n", proximity);
    if (proximity == 99)
    {
        printf("can't get worse than this\n");
    }
    else if (proximity >= 90)
    {
        printf("pretty fucking far away\n");
    }
    else if (proximity >= 80)
    {
        printf("pretty frikin far away\n");
    }
    else if (proximity >= 70)
    {
        printf("very far away\n");
    }
    else if (proximity >= 60)
    {
        printf("far away\n");
    }
    else if (proximity >= 50)
    {
        printf("pretty far away\n");
    }
    else if (proximity >= 40)
    {
        printf("getting close but still far away\n");
    }
    else if (proximity >= 30)
    {
        printf("now we are talking\n");
    }
    else if (proximity >= 20)
    {
        printf("it's getting a bit hot\n");
    }
    else if (proximity >= 10)
    {
        printf("blazing\n");
    }
    else if (proximity >= 5)
    {
        printf("AAAAAAAAAAH\n");
    }
    else if (proximity >= 1)
    {
        printf("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH\n");
    }
    else if (proximity == 0)
    {
        printf("you won\n");
    }

    return 0;
}
