#include <stdio.h>
int main()
{
    int y, x;
    for(y=1, x=5; y<=5; y++, x--){
        printf("\n %d*%d = %d", x, y, x*y);
    }
    return 0;
}