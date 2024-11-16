#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define NUM_EXCHANGES 100

void error(const char *msg) {
    printf("%s\n", msg);
    exit(1);
}

int main() {
    int pipe1[2], pipe2[2];
    char byte = 'A';
    int pid;
    int i;
    int start_ticks, end_ticks;
    int duration;
    int exchanges_per_second;

    // Create the pipes
    if (pipe(pipe1) == -1) error("pipe1 creation failed");
    if (pipe(pipe2) == -1) error("pipe2 creation failed");

    // Fork the process
    if ((pid = fork()) < 0) {
        error("fork failed");
    }

    if (pid > 0) {  // Parent process
        close(pipe1[0]);  // Close unused read end of pipe1
        close(pipe2[1]);  // Close unused write end of pipe2

        start_ticks = uptime();  // Start timing

        for (i = 0; i < NUM_EXCHANGES; i++) {
            write(pipe1[1], &byte, 1);  // Send byte to child
            read(pipe2[0], &byte, 1);   // Receive byte from child
        }

        end_ticks = uptime();  // End timing

        close(pipe1[1]);
        close(pipe2[0]);

        // Wait for child process to finish
        wait(0);

        // Calculate and print the performance
        duration = end_ticks - start_ticks;  // Duration in ticks
        exchanges_per_second = (NUM_EXCHANGES * 10) / duration;  // Convert to exchanges per second (assuming 10 ticks per second)
        printf("Parent: Done\n");
        printf("Exchanges per second: %d\n", exchanges_per_second);
    } else {  // Child process
        close(pipe1[1]);  // Close unused write end of pipe1
        close(pipe2[0]);  // Close unused read end of pipe2

        for (i = 0; i < NUM_EXCHANGES; i++) {
            read(pipe1[0], &byte, 1);   // Receive byte from parent
            write(pipe2[1], &byte, 1);  // Send byte to parent
        }

        close(pipe1[0]);
        close(pipe2[1]);

        printf("Child: Done\n");
    }

    exit(0);
}

