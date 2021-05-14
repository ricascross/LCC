#include<stdio.h>
#include<unistd.h>
#include<sys/wait.h>

int main(int argc, char* argv[]){
    
    if (fork() == 0){
        printf("Filho: %d\n", getpid());
        printf("PAI: %d\n", getppid());

        for(int i = 1; i<10; i++){
            if(fork() == 0){
                printf("Filho: %d\n", getpid());
                printf("PAI: %d\n", getppid());
                
                _exit(i+1);
            } else {
                int status;
                wait(&status);
                if(WIFEXITED(status)){
                    printf("Filho %d terminou!\n", WEXITSTATUS(status));
                }
            }
        }

        _exit(1);
    } else {
        int status;
        wait(&status);
        if (WIFEXITED(status))
        {
            printf("Filho %d terminou!\n", WEXITSTATUS(status));
        }
    }

    return 0;
}