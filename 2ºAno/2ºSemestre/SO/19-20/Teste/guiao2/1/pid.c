#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

int main(int argc, char* argv[]){
    int pid = getpid();
    int ppid = getppid();
    printf("Filho: %d\n", pid);
    printf("Pai: %d\n", ppid);

    return 0;
}