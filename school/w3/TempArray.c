#include <stdio.h>
int main()
{
float temp[4] = {7.5, 11.3, 9.2, 6.1};
int n=4;
printf("\n Temps in Celsius: ");
for(int k=0; k<n; k++){
printf(" %4.1f ", temp[k]);
}
for (int j=0; j<n; j++){
temp[j] = temp[j]*9/5+32;
}
printf("\n Temps in Fahrenheit : ");
for(int k=0; k<n; k++){
printf(" %4.1f ", temp[k]);
}
return 0;
}
