
#include <stdio.h>


int main() {
    float temp, result;
    int choice;
    printf("Enter temperature: ");
    scanf("%f", &temp);
    CorF:
        printf("Enter 1 (C to F) or 2 (F to C): ");
        scanf("%d", &choice);

    if (choice == 1) {
        result = (temp * 9/5) + 32;
        printf("%.2f\u00B0C = %.2f\u00B0F\n", temp, result);
    } else if (choice == 2) {
        result = (temp - 32) * 5/9;
        printf("%.2f\u00B0F = %.2f\u00B0C\n", temp, result);
    } else {
        fprintf(stderr, "\nInvalid choice!\n");
        goto CorF;
    }
    return 0;
}