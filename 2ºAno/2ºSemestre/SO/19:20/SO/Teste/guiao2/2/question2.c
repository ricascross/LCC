#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

int main(int argc, char* argv[]){
    int pid;

    if((pid = fork()) == 0){
        //processo filho
        printf("Filho: %d\n", getpid());
        printf("Pai: %d\n", getppid());

    } else {
        //processo pai
        wait(NULL);
        
        printf("Filho: %d\n", pid);
        printf("Presente: %d\n", getpid());
        printf("Pai: %d\n", getppid());
    }
    return 0;
}