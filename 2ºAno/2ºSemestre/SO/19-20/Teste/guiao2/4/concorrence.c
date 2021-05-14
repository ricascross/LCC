#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

int main(int argc, char* argv[]){
    int status;

    for (int i=0; i < 10; i++){
        if (fork() == 0){
            _exit(i+1);
        }
    }

    for(int i=0; i < 10; i++){
        wait(&status);
        if(WIFEXITED(status)){
            printf("Filho %d terminou.\n", WEXITSTATUS(status));
        }
    }
    return 0;
}