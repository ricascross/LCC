#include<unistd.h>
#include<sys/wait.h>
#include <stdio.h>

#define MAX 1000

int main(int argc, char* argv[]){
    int pfd[2]; // out - pipe[0]; in - pipe[1]
    pipe(pfd);

    if(fork() == 0){
        close(pfd[0]);
        dup2(pfd[1], 1);

        sleep(5);
        
        write(pfd[1], "olá!\n", 7);

        close(pfd[1]);

        _exit(0);
    } else {
        close(pfd[1]);
        dup2(pfd[0], 0);

        char buffer[MAX];

        int bytesRead = read(pfd[0], buffer, MAX);

        printf("Bytes Lidos: %d\n", bytesRead);

        close(pfd[0]);

        wait(NULL);
    }

    return 0;
}