#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

int main(int argc, char* argv[]){
    //processos concorrentes
    for(int i=0;i<10;i++){
        if(fork()==0){
            //Filho
            printf("Filho %d começou, filho de %d\n", getpid(),getppid());
            printf("Filho %d terminou\n", getpid());
            _exit(i);
        }
    }
    for(int i=0; i<10;i++){
        int status;
        wait(&status);
        if(WIFEXITED(status)){
            printf("Filho %d terminado\n", WEXITSTATUS(status));
        }  
    }
    
    
}