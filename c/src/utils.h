
#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <stdlib.h>

#define TEAMSIZE 5

/**
 * @brief Struct to store values in
 */
typedef struct gSTATS {
    char *champName[TEAMSIZE * 2];
    unsigned int *vs[TEAMSIZE * 2];
} *gSTATS;




#endif