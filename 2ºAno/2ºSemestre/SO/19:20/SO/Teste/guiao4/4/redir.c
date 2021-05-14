#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <string.h>
#include <stdio.h>

void fork_function(char* args[]){
    if(fork() < 0){
        write(2, "Error on Creating process\n", 27);
        _exit(-2);
    }

    if (fork() == 0){
        execvp(args[0], args);
        perror(args[0]);
        _exit(0);
    } else{
        wait(NULL);
    }
}

void parse(int argc, char* argv[]){
    int i = 5;
    int tam = argc - 5;
    char* args[tam];
    
    for(int j=0; j < tam; j++){
        args[j] =  strdup(argv[i++]);
    }

    fork_function(args);
}

int main(int argc, char* argv[]){
    int fdError = open("error.txt", O_CREAT | O_WRONLY, 0666);
    dup2(fdError, 2);

    int fdInput;
    int fdOut;

        if (argc < 5)
    {
        write(2, "Insuficient arguments\n", 23);
        return -1;
    }

    if ((strcmp("-o", argv[1]) == 0) && (strcmp("-i", argv[3]) == 0)){
        fdOut = open(argv[2], O_CREAT | O_WRONLY, 0666);
        dup2(fdOut, 1);

        fdInput = open(argv[4], O_CREAT | O_WRONLY, 0666);
        dup2(fdInput, 0);
    }

    if ((strcmp("-i", argv[1]) == 0) && (strcmp("-o", argv[3]) == 0))
    {
        fdInput = open(argv[2], O_CREAT | O_WRONLY, 0666);
        dup2(fdInput, 0);

        fdOut = open(argv[4], O_CREAT | O_WRONLY, 0666);
        dup2(fdOut, 1);
    }


    parse(argc, argv);

    close(fdError);
    close(fdInput);
    close(fdOut);
    return 0;
}