#include <stdio.h>
int main()
{
    int k, num, odd=0;
    printf("\nEnter 5 integers \n");
    fflush(stdout);
    for(k=0; k<5; k++){
        scanf(" %d", &num);
        if(num<0 || num>9){
            continue;
        }
        odd=(num%2==1)? odd+1: odd;
    }
    printf("\nEntered odd digits: %d\n", odd);
    return 0;
}
