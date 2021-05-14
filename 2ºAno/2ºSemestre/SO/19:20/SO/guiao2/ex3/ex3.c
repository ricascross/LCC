#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

int main(int argc, char* argv[]){
    //processos sequenciais
    
    for(int i = 0; i<10;i++){
        if(fork()==0){
        //Filho
        
        printf("Filho %d começou, sou filho de %d\n",getpid(), getppid());
        sleep(3);
        printf("Filho %d terminou\n",getpid());
        _exit(i);
        }else{
        //pai
        wait(NULL); //não está interessado no resultado do filho
        printf("Filho %d terminado\n", i); //pai percebeu que o filho terminou
        }
    }
}