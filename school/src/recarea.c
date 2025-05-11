#include <stdio.h>

#define PROMPT_LENGTH "Enter length: "
#define PROMPT_WIDTH "Enter width: "
#define AREA(l, w) (l * w)
#define CALC_TYPE "Area"

int main(void) {

    double l;
    double w;
    double area;

    printf(PROMPT_LENGTH);
    scanf("%lf", &l);

    printf(PROMPT_WIDTH);
    scanf("%lf", &w);

    area = AREA(l, w);

    printf("Calculation Type : %s\n", CALC_TYPE);
    printf("Value : %.02lf\n", area);

    return 0;
}