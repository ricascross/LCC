#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

#define MAX 100

/**
 * Executar wc no processo filho
 * pai - envia uma sequência de linhas de texto introduzidas pelo utilizador no seu standard inpu
 * associar o standard input do processo filho 
*/

int main(int argc, char* argv[]){
    int pfd[2];
    pipe(pfd);

    if (fork() == 0){
        close(pfd[1]);
        dup2(pfd[0], 0);
        close(pfd[0]);

        execlp("wc", "wc", NULL);
        perror("wc");
        _exit(0);
    } else{
        close(pfd[0]);

        int bytesRead;
        char buffer[100];

        while((bytesRead = read(0, buffer, MAX)) > 0){
            write(pfd[1], buffer, bytesRead);
        }

        close(pfd[1]);

        wait(NULL);
    }
}