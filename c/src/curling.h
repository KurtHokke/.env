
#ifndef CURLING_H
#define CURLING_H



#include <stdio.h>
#include <stdbool.h>


/**
 * @brief memory for curl function
 */
struct Memory {
    char *data;
    size_t size;
};

/**
 * @brief Callback function to collect response data
 */
static size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp);

/**
 * @brief do curl
 */
struct Memory do_curl(void);


#endif