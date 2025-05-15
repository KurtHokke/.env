#include <stdio.h>

int main() {
    int choice = 0;
    float num1, num2;
    numbers:
        printf("Enter two numbers: ");
        scanf("%f %f", &num1, &num2);
        if (num1 == 0 && num2 == 0) {
            fprintf(stderr, "\nnum1 and num2 is invalid\n");
            goto numbers;
        }
    menu:
        if (choice < 1 || choice > 4) {
            printf("Menu:\n1. Add\n2. Subtract\n3. Multiply\n4. Divide\nEnter choice (1-4): ");
            scanf("%d", &choice);
        }

    if ((num2 == 0) && choice == 4) {
        fprintf(stderr, "\nCannot divide by 0\n", num1);
        goto numbers;
    }
    switch (choice)
    {
    case 1:
        printf("%f + %f = %f\n", num1, num2, num1 + num2);
        break;
    case 2:
        printf("%f - %f = %f\n", num1, num2, num1 - num2);
        break;
    case 3:
        printf("%f * %f = %f\n", num1, num2, num1 * num2);
        break;
    case 4:
        printf("%f / %f = %f\n", num1, num2, num1 / num2);
        break;
    default:
        fprintf(stderr, "\nChoice: %d does not exist!\n", choice);
        goto menu;
    }
    return 0;
}