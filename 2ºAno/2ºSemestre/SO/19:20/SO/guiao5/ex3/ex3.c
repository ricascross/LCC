#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

#define MAX 100

int main(int argc, char* argv[]){
    int pfd[2];  //pfd[0] - saída; pfd[1] - entrada
    pipe(pfd);

    if(fork()==0){
        
        int bytesRead;
        char buf[MAX];

        close(pfd[1]);

        dup2(pfd[0],0); //copia o apontador da saida do pipe para o stdin
        close(pfd[0]);
        
        execlp("wc", "wc", NULL);

        
        perror("wc");
        _exit(0);
    }else{
        char buf[MAX];
        int bytesRead;
        int max = 5;
        close(pfd[0]); //nunca usa a saída
        
        while((bytesRead = read(0, buf, MAX))>0){
            write(pfd[1], buf, bytesRead);
        }
        close(pfd[1]);
        
        wait(NULL);
        
    }
}