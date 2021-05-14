#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

int main(int argc, char*argv[]){
    int status;

    for(int i =0; i < 10; i++){
        if (fork() == 0){
            printf("Meu PID: %d\n", getpid());
            printf("Pai: %d\n", getppid());

            _exit(i+1);
        } else {
            wait(&status);
            if(WIFEXITED(status)){
                printf("Processo %d terminou!\n", WEXITSTATUS(status));
            }
        }
    }
    return 0;
}