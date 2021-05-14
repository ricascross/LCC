#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>
#include <stdlib.h>

void my_system(char* aux){
    char *token;
    const char delim[2] = " ";

    int tam = strlen(aux);

    int i=1; //vai ser usado no while

    char* args[tam];

    token = strtok(aux, delim); //Recebe o primeiro argumento

    args[0] = token;
    
    
    while(token != NULL){
        token = strtok(NULL, delim);
        args[i++] = token;
    }
    args[i] = NULL;

    if(fork()==0){
        execvp(args[0], args);
        perror(args[0]);
        _exit(1);
    }else{
        wait(NULL);
    }
}


int main(int argc, char* argv[]){
    char* aux;
    

    if (argc == 2){
        aux = strdup(argv[1]);
        my_system(aux);
    }

    
    
    system(argv[1]);

    return 0;
}