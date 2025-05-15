#include <stdio.h>
int main()
{
int menu;
setbuf(stdout, NULL);
printf("\n Countries and Currencies\n");
printf("\n 1 - Greece");
printf("\n 2 - Norway");
printf("\n 3 - Denmark");
printf("\n 4 - England");
printf("\n\n Enter choice (1-4) ");
scanf(" %d", &menu);
switch(menu){
case 1 :
printf("\n Currency is Euro");
break;
case 2 :
case 3 :
printf("\n Currency is Kronor");
break;
case 4 :
printf("\n Currency is Pound");
break;
default:
printf("\n Unsupported menu choice!");
break;
}
printf("\n");
return 0;
}
