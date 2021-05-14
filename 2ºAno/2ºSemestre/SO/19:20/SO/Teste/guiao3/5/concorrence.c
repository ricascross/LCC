#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <string.h>

int main(int argc, char*argv[]){
    
    for(int i=1; i <= argc - 1; i++){
        char limit[2] = " ";
        char* token;
        int tam = strlen(argv[i]);
        char* args[tam];
        int j = 0;

        token = strtok(argv[i], limit);

        

        args[j++] = token;

        while(token != NULL){
            token = strtok(NULL, limit);
            
            args[j++] = token;
        }
        args[j] = NULL;

        if(fork() == 0){
            execvp(args[0], args);
        }
    }

    for(int i=1; i<=argc-1;i++){
        wait(NULL);
    }
    
    
    return 0;
}