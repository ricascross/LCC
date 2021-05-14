#include <signal.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>

#define MAX 1000

int* pid;
int numberOfProcesses;

void kill_handler(){
    for(int i = 0; i < numberOfProcesses; i++){
        kill(pid[i], SIGKILL);
        printf("%d\n", pid[i]);
    }
}

int main(int argc, char* argv[]){
    int numberOfProcesses = argc - 2;
    char* word = strdup(argv[1]);
    pid = malloc(numberOfProcesses * sizeof(int));

    
    alarm(10);
    

    for(int i=2; i < argc; i++){
        if ((pid[i-2] = fork()) == 0){
            execlp("grep", "grep", word, argv[i], NULL);
            perror("grep");
            _exit(i);
        }
    }

    //sleep(11);

    int status, found;

    for (int i = 2; i < numberOfProcesses; i++)
    {
        wait(&status);
        if(WIFEXITED(status) && WEXITSTATUS(status) == 0){
            found = 1;
            signal(SIGALRM, kill_handler);
        }
    }

    if (found == 1) printf("Encontrou!\n");
    else printf("Não encontrou!\n");

    return 0;
}