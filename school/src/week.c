#include <stdio.h>


int main(void) {

    enum weekdays {
        MONDAY = 1,
        TUESDAY,
        WEDNESDAY,
        THURSDAY,
        FRIDAY,
        SATURDAY,
        SUNDAY
    };
    for (int i = 0; i < 7; i++) {
        char* day;
        switch (i) {
            case MONDAY: day = "Monday";
            case TUESDAY: day = "Tuesday";
            case WEDNESDAY: day = "Wednesday";
            case THURSDAY: day = "Thursday";
            case FRIDAY: day = "Friday";
            case SATURDAY: day = "Saturday";
            case SUNDAY: day = "Sunday";
            default: day = "Unknown";
        }
        printf("%d : %s\n", i, day);
    }
    return 0;
}