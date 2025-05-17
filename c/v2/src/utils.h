
#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <jansson.h>

#define STR(x) #x
#define Pf(fmt, ...) printf(fmt "\n", ##__VA_ARGS__)

#define MY_URL_CURL "https://127.0.0.1:2999/liveclientdata/allgamedata"



struct errorbox {
    json_error_t json;
    int e;
};

struct Memory {
    char *data;
    size_t size;
};
static size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp);
struct Memory do_curl(void);

#endif