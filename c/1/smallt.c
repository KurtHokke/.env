#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>

#define Pf(fmt, ...) printf(fmt "\n", ##__VA_ARGS__)

typedef struct task {
    char *name;
} task;

enum index
{
    ADD = 49,
    REMOVE,
    DISPLAY
};

void printmenu(void);
bool addtask(const char *name);

task **tasks = NULL;
int task_cap = 0;
int cur_total = 0;

int main(void)
{
    task_cap = 3;
    tasks = malloc(task_cap * sizeof(task*));
    char choice[2];
    printmenu();
    fgets(choice, sizeof(choice), stdin);
    switch ((int)choice[0]) {
    case ADD:
        Pf("add!");
        char *name = malloc(100 * sizeof(char));
        printf("Enter task name: ");
        fgets(name, 100 * sizeof(char), stdin);
        if (addtask(name)) {
            printf("added %s to tasks\n", tasks[cur_total]->name);
        }
        free(name);
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

bool addtask(const char *name) {
    if (cur_total == task_cap) {
        int new_cap = task_cap + 3;
        task **new_tasks = realloc(tasks, (new_cap * sizeof(task*)));
        if (new_tasks == NULL) {
            Pf("malloc failed");
            return false;
        }
        tasks = new_tasks;
        task_cap = new_cap;
    }
    task *new_task = malloc(sizeof(task));
    if (new_task == NULL) {
        Pf("malloc failed");
        return false;
    }
    new_task->name = malloc(strlen(name) + 1);
    if (new_task->name == NULL) {
        Pf("malloc failed");
        free(new_task);
        return false;
    }
    strlcpy(new_task->name, name, sizeof(new_task->name));
    tasks[cur_total] = new_task;
    cur_total++;
    return true;
}

void printmenu(void)
{
    printf("==Task Manager==\n");
    printf("1. Add\n");
    printf("2. Remove\n");
    printf("3. Display\n");
}