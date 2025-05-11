#include <stdio.h>
#include <string.h>

int main(void) {
    enum weekdays {
        MONDAY = 1,
        TUESDAY,
        WEDNESDAY,
        THURSDAY,
        FRIDAY,
        SATURDAY,
        SUNDAY,
    };
    const char *dayNames[] = {
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
    };
    char* suffix;
    char* spacing;
    for (int i = MONDAY; i < 8; i++) {

        if (strlen(dayNames[i - 1]) < 7)       { spacing = "    "; } 
        else if (strlen(dayNames[i - 1]) == 7) { spacing = "   "; }
        else if (strlen(dayNames[i - 1]) == 8) { spacing = "  "; }
        else                                   { spacing = " "; }

        switch (i) {
            case 1: suffix = "st"; break;
            case 2: suffix = "nd"; break;
            case 3: suffix = "rd"; break;
            case 4: suffix = "th"; break;
            case 5: suffix = "th"; break;
            case 6: suffix = "th"; break;
            case 7: suffix = "th"; break;
            default: printf("Too many days\n"); return 1;
        }
        printf("%s:%s%d%s day of the week\n", dayNames[i - 1], spacing, i, suffix);
    }
    return 0;
}