#ifndef UTILS_H
#define UTILS_H

#define __TYPES_NAMES[] { "int", \
                        "float", \
                        "double", \
                        "string", \
                        "unknown" }

#define PRINT_tnv(x) 
/*
printf("(%s)%s: %d\n", \
                        _Generic((x), \
                        int: "int", \
                        float: "float", \
                        double: "double", \
                        char*: "string", \
                        default: "unknown"), \
                        #x, \
                        x \
                      )

*/
#endif