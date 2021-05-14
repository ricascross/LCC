#include<unistd.h>
#include <sys/wait.h>
#include <stdio.h>


int main(int argc, char* argv[]){
    for(int i=1; i<argc; i++){
        if(fork()==0){
            execlp(argv[i], argv[i], NULL);
            perror(argv[1]);
            _exit(1);
        } else{
            wait(NULL);
        }
    }
    return 0;
}