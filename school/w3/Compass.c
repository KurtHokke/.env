#include <stdio.h>
#include <stdlib.h>
int main()
{
    int angle, rounds, direction;
    setbuf(stdout, NULL);
    do{
        printf("\n Enter total compass swing (degrees >= 0): ");
        scanf("%d", &angle);
        if(angle < 0){
            printf("\n *** Entered value not within range! ***");
        }
    }while(angle < 0);
    
    rounds = angle / 360.00;
    direction = angle % 360;
    printf("\n The compass covered %d complete rounds, final direction %ddegrees\n", rounds, direction);
    return 0;
}
