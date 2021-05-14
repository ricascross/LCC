#include<unistd.h>
#include<fcntl.h>
#include<string.h>
#include<stdio.h>
#include <sys/wait.h>

#define MAX 100

int main(int argc, char* argv[]){
    
    if(strcmp(argv[1], "-i") == 0 && strcmp(argv[3], "-o") == 0){
        int fdEntry = open(argv[2], O_CREAT | O_RDWR, 0644);
        dup2(fdEntry, 0);

        int fdOut = open(argv[4], O_CREAT | O_WRONLY, 0644);
        dup2(fdOut, 1);

    } else if(strcmp(argv[1], "-o") == 0 && strcmp(argv[3], "-i") == 0){
        int fdOut = open(argv[2], O_CREAT | O_WRONLY, 0644);
        dup2(fdOut, 1);

        int fdEntry = open(argv[4], O_CREAT | O_RDWR, 0644);
        dup2(fdEntry, 0);

    } else {
        perror("1: Parâmetros incorretos!\nEx: redir -i nome_entrada -o nome saida command arg1 arg2 ...\n");
    }

    char* args[MAX];
    int i=5;
    
    for(int j=0; i<argc; i++,j++){
        args[j] = strdup(argv[i]);
    }
    

    
    if(fork() == 0){
        execvp(args[0], args);
        perror(args[0]);
        _exit(0);
    }else{
        wait(NULL);
    }


    return 0;
}