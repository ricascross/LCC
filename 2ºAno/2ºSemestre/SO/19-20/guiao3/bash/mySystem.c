#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

void my_system(char* aux){
    char *token;
    const char* delim = " \n";
 
    int tam = 1+strlen(aux); //tamanho do aux que vai ser utilizado para o tamanho do args
 
    int i=1; //vai ser usado no while

    char* args[tam];
 
    token = strtok(aux, delim); //Recebe o primeiro argumento
 
    args[0] = token;
   
    while(token != NULL){
        
        token = strtok(NULL, delim);
        args[i] = token;
        i++;
    }
 
    if(fork()==0){
        execvp(args[0], args);
        perror(args[0]);
        _exit(0);
    }else{
        wait(NULL);
    }
}