#include <stdio.h>
#include <string.h>


// I forgot to comment this part of the test so I did the test again 
int main(void) {
    enum weekdays {   //create enum for weekdays
        MONDAY = 1,
        TUESDAY,
        WEDNESDAY,
        THURSDAY,
        FRIDAY,
        SATURDAY,
        SUNDAY
    };
    const char *dayNames[] = {   //create an array with weekday-names
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
    };
    const char *suffixes[] = { "st", "nd", "rd", "th", "th", "th", "th" };  //create an array for number suffixes
    char result[100];   //initiate final result with max capacity of 99 characters + '\0'

    for (int i = MONDAY; i < 8; i++) {
        /* start the main loop to construct and display each weekday-name
         * followed by a dynamically long string of underscores
         * and last the weekday-number belonging to current weekday-name 
         */
        int len = strlen(dayNames[i - 1]);         //length of weekday-name
        int spaces_needed = 10 - len;              //calculate amount of underscores to append

        char spacing[11] = "";                     //initiate variable that will hold the underscores

        for (int j = 0; j < spaces_needed; j++) {  //start constructing the final 'spacing' variable
            strcat(spacing, "_");
        }

        //format the final string with snprintf before printing it
        snprintf(result, sizeof(result), "%s:%s%d%s day of the week", dayNames[i - 1], spacing, i, suffixes[i - 1]);

        //display current result
        printf("%s\n", result);
    }
    return 0;
}