
#include "utils.h"
#include <curl/curl.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Callback function to collect response data
static size_t write_callback(void *contents, size_t size, size_t nmemb,
                             void *userp)
{
    size_t realsize = size * nmemb;
    struct Memory *mem = (struct Memory *)userp;

    // Reallocate memory to fit new data
    char *ptr = realloc(mem->data, mem->size + realsize + 1);
    if (!ptr) {
        Pf("ERROR");
        return 0;
    }

    mem->data = ptr;
    memcpy(&(mem->data[mem->size]), contents, realsize);
    mem->size += realsize;
    mem->data[mem->size] = 0; // Null-terminate

    return realsize;
}

struct Memory do_curl(void)
{
    struct Memory response = {.data = NULL, .size = 0}; // Initialize to safe defaults
    CURL *curl;
    CURLcode res;

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();
    if (!curl) {
        Pf("ERROR");
        curl_global_cleanup();
        return response;
    }
    curl_easy_setopt(curl, CURLOPT_URL, MY_URL_CURL);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);

    curl_easy_setopt(curl, CURLOPT_TIMEOUT, 5L);

    curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
    curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);

    res = curl_easy_perform(curl);

    if (res != CURLE_OK) {
        Pf("ERROR: %s\n", curl_easy_strerror(res));
        free(response.data); // Free in case of error
        response.data = NULL;
        response.size = 0;
        curl_easy_cleanup(curl);
        curl_global_cleanup();
        return response;
    }
    // Clean up
    curl_easy_cleanup(curl);
    curl_global_cleanup();
    return response;
}
