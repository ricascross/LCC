#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char* argv[]){
    if (fork() == 0){
        execlp("ls", "ls", "-l", NULL);
    } else {
        wait(NULL);
    }
}