#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>
#include <stdlib.h>

int* pid;
int argc2;

void matatodos(){
    for(int j ; j<argc2; j++) 
        kill(pid[j], SIGTERM);
}

int main(int argc, char* argv[]){
    //argv[1] - palavra
    //argv[i] i<argc ficheiros
    int tam = strlen(argv[1]);
    char word[tam+1];
    strcpy(word, argv[1]);

    int found = 0;
    int status;
    
    pid = malloc((argc-2) * sizeof(int));
    argc2 = argc-2;
    

    if(strcmp(argv[1], "") != 0){
        for(int i = 2; i < argc; i++){
            if((pid[i-2] = fork()) == 0){
                execlp("grep", "grep", word, argv[i], NULL);
                perror("grep");
                _exit(i);
            }
        }

        signal(SIGALRM, matatodos);
        alarm(10);

        for(int i = 2;i<argc; i++){
            wait(&status);
            if(WIFEXITED(status) && WEXITSTATUS(status) == 0){
                found = 1;
                //matatodos();
            }
            
        }

        if (found) printf("Encontrou\n");
    }
    return 0;
}