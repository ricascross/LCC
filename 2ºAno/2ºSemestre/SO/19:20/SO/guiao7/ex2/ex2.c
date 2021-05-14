#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>

int main(int argc, char* argv[]){
    //argv[1] - palavra
    //argv[i] i<argc ficheiros
    int tam = strlen(argv[1]);
    char word[tam+1];
    strcpy(word, argv[1]);

    int found = 0;
    int status;
    
    pid_t pid[argc - 2];

    if(strcmp(argv[1], "") != 0){
        for(int i = 2; i < argc; i++){
            if((pid[i-2] = fork()) == 0){
                execlp("grep", "grep", word, argv[i], NULL);
                perror("grep");
                _exit(i);
            }
        }

        for(int i = 2;i<argc; i++){
            wait(&status);
            if(WIFEXITED(status) && WEXITSTATUS(status) == 0){
                found = 1;
                for(int j = i+1; j<argc-2; j++) 
                    kill(pid[j], SIGTERM);
            }
            
        }

        if (found) printf("Encontrou\n");
    }
    return 0;
}