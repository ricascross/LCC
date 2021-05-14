#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

int main(int argc, char* argv[]){
    /**
     * pfd[0] - saída do pipe
     * pfd[1] -  entrada do pipe
     */ 
    int pfd[2]; 
    int pfd_2[2];
    int pfd_3[2];

    pipe(pfd); //criação do pipe

    if(fork() == 0){
        /**
         * primeiro pipe
        */
        close(pfd[0]);
        dup2(pfd[1],1);
        close(pfd[1]);

        execlp("grep", "grep", "-v", "^#", "/etc/passwd", NULL);

        perror("grep"); //se o grep não for um comando, dá erro
        _exit(1); //mata o primeiro filho

    } else {
        pipe(pfd_2); // criação do segundo pipe
        if(fork() == 0){
            /**
             * primeiro pipe
            */ 
            close(pfd[1]);
            dup2(pfd[0],0); //redireciona a saída do pipe para o stdin
            close(pfd[0]);
            
            /**
             * Segundo Pipe
            */
            close(pfd_2[0]);
            dup2(pfd_2[1], 1); // redireciona a entrada do pipe para o stdout
            close(pfd_2[1]);

            //execução do comando
            execlp("cut","cut", "-f7", "-d:", NULL);

            
            perror("cut"); //se cut não for um comando, dá erro
            _exit(2); //mata o segundo filho
        }
        /**
         * Fechar o primeiro pipe
        */
        close(pfd[0]);
        close(pfd[1]);
        

        pipe(pfd_3); //criação do terceiro pipe

        if(fork() == 0){
            /**
             * Segundo pipe
            */
           close(pfd_2[1]);
           dup2(pfd_2[0], 0); //redireciona o a saída do pipe para o stdin
           close(pfd_2[0]);
            
           /**
            * Terceiro pipe 
            */ 
           close(pfd_3[0]);
           dup2(pfd_3[1], 1); //redireciona a entrada do pipe para o stdout
           close(pfd_3[1]);

           execlp("uniq", "uniq", NULL); //executa o comando

           perror("uniq"); //se o uniq não for um comando dá erro
           _exit(3); //mata o 3 filho
        }

        /**
         * Fechar segundo pipe
        */
        close(pfd_2[0]);
        close(pfd_2[1]);
        

        if(fork() == 0){
            /**
             * Terceiro pipe
            */
            close(pfd_3[1]);
            dup2(pfd_3[0],0);
            close(pfd_3[0]);

            execlp("wc", "wc", "-l", NULL);

            perror("wc"); //se o wc não for um comando dá erro
            _exit(4); //mata o 4 filho
        }

        /**
         * Fechar o terceiro pipe
        */
        close(pfd_3[0]);
        close(pfd_3[1]);
        
        wait(NULL);
        wait(NULL);
        wait(NULL);
        wait(NULL);
    }

    return 0;
}