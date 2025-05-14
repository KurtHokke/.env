#include <stdio.h>
#define P_LINE(l) printf("%s:%d", __FILE__, __LINE__ + l);
int main() {
    P_LINE(-1) printf("\n");
    return 0;
}