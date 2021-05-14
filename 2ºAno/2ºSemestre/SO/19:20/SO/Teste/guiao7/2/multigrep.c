#include <signal.h>
#include <unistd.h>
#include<sys/wait.h>
#include <stdio.h>
#include <signal.h>



#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/wait.h>

#define MAX 1000

void handler();

int main(int argc, char* argv[]){
    int numberOfProcesses = argc - 2;
    char* word = strdup(argv[1]);
    pid_t pid[numberOfProcesses];

    for(int i=2; i < argc; i++){
        if ((pid[i-2] = fork()) == 0){
            execlp("grep", "grep", word, argv[i], NULL);
            perror("grep");
            _exit(i);
        }
    }

    int status, found;

    for (int i = 2; i < numberOfProcesses; i++)
    {
        wait(&status);
        if(WIFEXITED(status) && WEXITSTATUS(status) == 0){
            found = 1;
            for(int j=i+1; j < argc; j++){
               kill(pid[j], SIGKILL);
            }
        }
    }

    if (found ==1) printf("Encontrou!\n");
    else printf("Não encontrou!\n");

    return 0;
}