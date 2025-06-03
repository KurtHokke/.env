#include <stdio.h>


int main(void)
{
  char *str = "..";
  if ((str[0] == '.') && (str[1] == '\0'
                          || (str[1] == '.' && str[2] == '\0'))) {
    printf("yes\n");
  } else {
    printf("no\n");
  }
  return 0;
}
