#include <stdio.h>

/*
90–100: A
80–89: B
70–79: C
60–69: D
Below 60: F
*/

int main() {
    int score;
    printf("Enter the student's score (0-100): ");
    scanf("%d", &score);
    
    if (score <= 100 && score >= 90) {
        printf("Grade: A\n");
    } else if (score < 90 && score >= 80) {
        printf("Grade: B\n");
    } else if (score < 80 && score >= 70) {
        printf("Grade: C\n");
    } else if (score < 70 && score >= 60) {
        printf("Grade: D\n");
    } else if (score < 60) {
        printf("Grade: F !!!\n");
    } else {
        printf("Score is out of range!\n");
        return 1;
    }
    return 0;
}