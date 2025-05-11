#include <stdio.h>


int main(void) {

    int y = 7;  //Height
    int x = 5;  //Width

    int perimeter = 2 * (x + y);
    int area = x * y;

    printf("Perimeter: %d\n", perimeter);
    printf("Area: %d\n", area);
}