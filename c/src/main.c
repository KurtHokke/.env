#include "utils.h"
#include "curling.h"
#include "jsson.h"
#include <jansson.h>
//#include <curl/curl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main() {

    //int i = 0;

    gSTATS gold_s = {0};
    if (!gSTATS_handler(&gold_s, INITIATE)) {
        msg(stderr, "(ln16)ERROR: 'if (!gSTATS_handler(&gold_s, INITIATE))'");
        return 1;
    }
    struct Memory response = do_curl();
    
    if (response.data == NULL || response.size == 0) {
        msg(stderr, "ERROR:'main.c',line(21): 'if (response.data == NULL || response.size == 0)'");
        return 1;
    }
    #ifdef DEBUG
    printf("Response (%zu bytes): %.*s\n", response.size, 500, response.data);
    #endif

    if (!jsson(response.data, &gold_s, INIT_TRUE)) {
        msg(stderr, "ERROR:'main.c',line(30): 'if (!jsson(response.data, &gold_s))'");
        return 1;
    }
    free(response.data);
    gSTATS_handler(&gold_s, DESTROY);

    return 0;
}
