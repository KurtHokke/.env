#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define Pf(fmt, ...) printf(fmt "\n", ##__VA_ARGS__)

// Task structure
struct Task
{
    int id;
    char *name;
};

// Global variables for task list
struct Task **tasks = NULL;
int task_count = 0;
int task_capacity = 0;

void free_all_tasks(void)
{
    for (int i = 0; i < task_count; i++)
    {
        free(tasks[i]->name);
        free(tasks[i]);
    }
    free(tasks);
    tasks = NULL;
    task_count = 0;
    task_capacity = 0;
}

void handle_sigint(int sig)
{
    Pf("%d, calling free_all_tasks", sig);
    free_all_tasks();
    exit(0);
}

// Signal handler setup (to be implemented)
void setup_signal_handler(void)
{
    struct sigaction sa;

    sa.sa_handler = handle_sigint;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;

    if (sigaction(SIGINT, &sa, NULL) == -1)
    {
        perror("failed to set up sigaction\n");
        exit(0);
    }
}

// Function prototypes
void add_task(const char *name)
{
    if (task_capacity == task_count + 1)
    {
        task_capacity += 5;
        realloc(tasks, task_capacity);
    }
    tasks[task_count]->name = malloc(sizeof(name));
    if (tasks[task_count]->name == NULL)
    {
        fprintf(stderr, "malloc failed for tasks[%d]->name\n", task_count);
        free_all_tasks();
        exit(0);
    }
    snprintf(tasks[task_count]->name, sizeof(tasks[task_count]->name), name);
    tasks[task_count]->id = 1001 + task_count;
    task_count += 1;
}
void display_tasks(void);

int main()
{
    // Initialize task array with capacity 5
    task_capacity = 5;
    tasks = malloc(task_capacity * sizeof(struct Task *));
    if (tasks == NULL)
    {
        printf("Memory allocation failed!\n");
        return 1;
    }

    // Set up signal handler
    setup_signal_handler();

    // Main loop
    while (1)
    {
        printf("\nTask Manager\n1. Add Task\n2. Display Tasks\nEnter choice "
               "(1-2): ");
        int choice;
        if (scanf("%d", &choice) != 1)
        {
            while (getchar() != '\n')
                ; // Clear input buffer
            printf("Invalid input.\n");
            continue;
        }
        while (getchar() != '\n')
            ; // Clear newline

        if (choice == 1)
        {
            char name[101];
            printf("Enter task name: ");
            fgets(name, sizeof(name), stdin);
            name[strcspn(name, "\n")] = '\0'; // Remove newline
            if (strlen(name) == 0)
            {
                printf("Task name cannot be empty.\n");
                continue;
            }
            add_task(name);
        }
        else if (choice == 2)
        {
            display_tasks();
        }
        else
        {
            printf("Invalid choice.\n");
        }
    }

    return 0;
}