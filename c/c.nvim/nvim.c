#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <errno.h>

int main(void) {
 
  while (1) {
    pid_t pid = fork(); // Create a child process
    int status;
   
    if (pid == -1) {
      // Fork failed
      perror("fork failed");
      return 1;
    }
    if (pid == 0) {
      // Child process
      char *program = "nvim"; // Program to run
      char *args[] = {"nvim", NULL}; // Argument list, end with NULL

      execvp(program, args); // Execute the program

      // If execvp fails, it returns here
      perror("execvp failed");
      exit(1);
    } else {
      // Parent process
      waitpid(pid, &status, 0); // Wait for child to finish

      if (WIFEXITED(status)) {
        printf("Child exited with status %d\n", WEXITSTATUS(status));
      }
    }
    int c = getchar();
    switch (c) {
      case 110:
        break;
      default:
        return 0;
    }
    pid = 0;
  }
  return 0;
}
