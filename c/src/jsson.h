
#ifndef JSSON_H
#define JSSON_H

#include "utils.h"
#include <stdbool.h>

#define JSSON_FAIL 0
#define JSSON_SUCCESS 1

#define INIT_TRUE  1
#define INIT_FALSE 0

#define ORDER "ORDER"
#define CHAOS "CHAOS"

#define OBJECT "object"
#define ARRAY "array"
#define STRING "string"

#define PRINT_AND_RETURN(x, y) do { \
    fprintf(stderr, "error: %s was not a json %s\n", #x, y); \
    json_decref(root); \
    return false; \
} while (0)

bool jsson(char *jsonData, gSTATS **ptr, bool init);



#endif