
#ifndef JSSON_H
#define JSSON_H

#include "utils.h"
#include <stdbool.h>

#define JSSON_FAIL 0
#define JSSON_SUCCESS 1

#define INIT_TRUE  1
#define INIT_FALSE 0

#define ORDER 1
#define CHAOS 0


bool jsson(char *jsonData, gSTATS *data, bool init);



#endif