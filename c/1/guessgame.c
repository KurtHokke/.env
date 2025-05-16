#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include <fcntl.h>
#include <unistd.h>


#define e_PRINT(l, fmt, ...) fprintf(stderr, "%s:%d: " fmt "\n", __FILE__, __LINE__ + l, ##__VA_ARGS__)


int get_random(uint8_t *result)
{
    int fd = open("/dev/urandom", O_RDONLY);
    if (fd < 0) return -1;

    ssize_t bytes_read = read(fd, result, sizeof(uint8_t));
    close(fd);
    if (bytes_read != sizeof(uint8_t)) {
        return -1; // Read failed
    }
    return 0;
}

int main()
{
    uint8_t rand_num;
    if (get_random(&rand_num) != 0) {
        e_PRINT(-1, "error");
        return 1;
    }
    int guess;
    printf("Guess ");

    while (1) {
        printf("number(0-255): ");
        if (scanf("%d", &guess) != 1) {
            int c;
            while ((c = getchar()) != '\n' && c != EOF) {

            }
            printf("Invalid guess!\n Guess again ");
            continue;
        }
        int c;
        while ((c = getchar()) != '\n' && c != EOF) {
            
        }
        if (guess < 0 || guess > 255) {
            printf("Invalid guess!\n Guess again ");
            continue;
        }
        break;
    }
    

    printf("%d\n", guess);
    printf("%d\n", rand_num);
    return 0;
}
