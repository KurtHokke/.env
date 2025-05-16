#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define Pf(fmt, ...) printf(fmt "\n", ##__VA_ARGS__)

typedef struct task {
    char *name
} task;

enum index
{
    ADD = 49,
    REMOVE,
    DISPLAY
};

void printmenu(void);
bool addtask();

task **tasks = NULL;
int task_cap = 0;
int cur_total = 0;

int main(void)
{
    task_cap = 3;
    tasks = malloc(task_cap * sizeof(task));
    char choice[2];
    printmenu();
    fgets(choice, sizeof(choice), stdin);
    switch ((int)choice[0]) {
    case ADD:
        Pf("add!");
        break;
    case REMOVE:
        Pf("remove!");
        break;
    case DISPLAY:
        Pf("display!");
        break;
    default:
        break;
    }
    return 0;
}

bool addtask() {
    if (cur_total = task_cap) {
        int new_cap = task_cap + 3;
        task **new_tasks
    }
    char name[101];
    printf("Enter task name: ");
    fgets(name, sizeof(name), stdin);

}

void printmenu(void)
{
    printf("==Task Manager==\n");
    printf("1. Add\n");
    printf("2. Remove\n");
    printf("3. Display\n");
}