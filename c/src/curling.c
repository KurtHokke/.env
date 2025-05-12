#include "curling.h"
#include <curl/curl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int do_curl(char **curl_response) {
    CURL *curl;
    CURLcode res;
    struct Memory response = {0};

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();
    if (!curl) {
        fprintf(stderr, "curl_easy_init() Failed");
        curl_global_cleanup();
        return 1;
    }
    curl_easy_setopt(curl, CURLOPT_URL, "http://127.0.0.1:2999/liveclientdata/allgamedata");
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);

    res = curl_easy_perform(curl);
    if (res != CURLE_OK) {
        fprintf(stderr, "curl_easy_perform() Failed: %s\n", curl_easy_strerror(res));
        curl_easy_cleanup(curl);
        curl_global_cleanup();
        free(response.data); // Free in case of error
        return 1;
    }

    *curl_response = response.data;

    // Clean up
    curl_easy_cleanup(curl);
    curl_global_cleanup();
    return 0;
}


// Callback function to collect response data
static size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp) {
    size_t realsize = size * nmemb;
    struct Memory *mem = (struct Memory *)userp;

    // Reallocate memory to fit new data
    char *ptr = realloc(mem->data, mem->size + realsize + 1);
    if (!ptr) {
        fprintf(stderr, "realloc() failed\n");
        return 0;
    }

    mem->data = ptr;
    memcpy(&(mem->data[mem->size]), contents, realsize);
    mem->size += realsize;
    mem->data[mem->size] = 0; // Null-terminate

    return realsize;
}