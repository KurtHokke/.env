
#ifndef CURLING_H
#define CURLING_H

#include <stdio.h>

// Structure to hold response data
struct Memory {
    char *data;
    size_t size;
};

static size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp);
int do_curl(char **curl_response);

#endif