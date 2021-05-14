#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int arg, char* argv[]){
    printf("Antes (%d)\n", getpid());
    int p = fork();

    //getpid() - dá o número do processo
    //getppid() - dá o numero do processo pai

    if(p==0){
        printf("Copia/Filho (sou %d, filho de %d) - O novo é %d/n", getpid(), getppid(), p);
        sleep(5);
        printf("Copia/Filho (sou %d, filho de %d) - O novo é %d/n", getpid(), getppid(), p);
        _exit(123);// é o mesmo que o return
    } else{
        printf("Original/pai (Sou %d e filho de %d) - Depois %d/n", getpid(), getppid(),p);
        int status; //variável inteira
        int w = wait(&status); //espera que o filho termine, se não esperar, o filho fica zombie (Z+)
        printf("Pai: terminou %d\n", w);

        //Ver se o processo filho terminou naturalmente ou se deu algum erro
        if(WIFEXITED(status)){
            printf("Pai: terminou %d com resultado %d\n", w, WEXITSTATUS(status));
        }
    }
}