#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <stdio.h>

#define MAXURL 100

int readline(int fd, void* buf, size_t count); // função declarada noutro programa getUrls

int main(int argc, char* argv[]){
    char buf[MAXURL];
    char* nome = argv[1]; //o enunciado diz que o nome é um argumento de um programa

    int fd = open(nome, O_WRONLY | O_CREAT, 0644);

    
    int bytesRead;

    int i = 0;
    while((bytesRead = read(0, buf, MAXURL)) > 0){
        
        
        if(fork() == 0){
            dup2(fd,1);
            execlp("./getURLS.sh", "getURLS", buf, NULL);

            perror("getURLS");
            _exit(i);
        } 
        i++;

        if (i == 10) {
            i--;
            wait(NULL);
        }
    }

    for(int j =0; j < i; j++){
        wait(NULL);
    }

    close(fd);
    
    return 0;
}