
#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define TEAMSIZE 5
#define INITIATE 1
#define DESTROY 0
#define LOG_MAXSIZE 1024


/**
 * @brief Struct to store values in
 */
typedef struct gSTATS {
    char *champName[TEAMSIZE * 2];
    unsigned int *vs[TEAMSIZE * 2];
} gSTATS;


/**
 * @brief safely write to file
 * @param file      Ex. 'stderr'
 * @param msg            String
 */
void msg(FILE *file, char *msg);

/**
 * @brief function to handle malloc and freeing of gSTATS
 * @param data      gSTATS var
 * @param I_OR_D    INITIATE | DESTROY = 1 | 0
 * @return boolean
 */
bool gSTATS_handler(gSTATS *data, int I_OR_D);


#endif