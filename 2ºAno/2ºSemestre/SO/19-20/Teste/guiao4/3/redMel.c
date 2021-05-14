#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <stdio.h>

#define MAX 1000

int main(int argc, char *argv[])
{
    int fdInput = open("/etc/passwd", O_WRONLY);
    int fdOut = open("saidas.txt", O_WRONLY | O_CREAT, 0666);
    int fdError = open("erros.txt", O_WRONLY | O_CREAT, 0666);

    dup2(fdInput, 0);
    dup2(fdOut, 1);
    dup2(fdError, 2);

    if (fork() == 0){
        execlp("wc", "wc", NULL);
        perror("wc");
        _exit(0);
    } else {
        wait(NULL);
    }

    

    close(fdOut);
    close(fdInput);
    close(fdError);

    return 0;
}