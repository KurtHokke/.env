#include <stdio.h>

int main()
{
    int day;
    const char *dayNames[] = {"Monday", "Tuesday",  "Wednesday", "Thursday",
                              "Friday", "Saturday", "Sunday"};
enterDay:
    printf("Enter day of week (1-7): ");
    scanf("%d", &day);

    if (day >= 1 && day <= 7) {
        printf("%s\n", dayNames[day - 1]);
    } else {
        fprintf(stderr, "Invalid day! ");
        goto enterDay;
    }
    return 0;
}