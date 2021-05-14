#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

int main(int argc, char* argv[]){
    int pfd[2]; //0 -saida; 1 - entrada
    pipe(pfd);

    if(fork() == 0){
        close(pfd[0]); //fecha a saída

        dup2(pfd[1], 1);
        close(pfd[1]); //Nunca usa a entrada
        

        execlp("ls", "ls", "/etc", NULL);

        perror("ls");
        _exit(1); // mata o filho

    } else {
        
        

        if(fork() == 0){
            close(pfd[1]);

            dup2(pfd[0], 0);
            close(pfd[0]);

            execlp("wc", "wc", "-l", NULL);

            perror("wc");
            _exit(2);
        }else{
    
            wait(NULL);
        }

        //os close têm de ser sempre depois dos dos filhos executarem
        close(pfd[0]); //nunca usa a saída

        close(pfd[1]); // fecha a entrada

        //o wait tem de ser sempre depois dos closes
        wait(NULL); // espera pelo primeiro filho

    }
}