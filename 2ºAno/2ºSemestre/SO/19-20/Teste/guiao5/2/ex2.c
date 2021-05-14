#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

#define MAX 1000

int main(int argc, char *argv[])
{
    int pfd[2]; // out - pipe[0]; in - pipe[1]
    pipe(pfd);

    if (fork() == 0)
    {
        close(pfd[1]);
        dup2(pfd[0], 0);
        close(pfd[0]);

        char buffer[MAX];

        int bytesRead;

        while((bytesRead = read(0, buffer, MAX))>0){
            printf("Bytes Lidos: %d\n", bytesRead);
        }

        

        _exit(0);
    }
    else
    {
        close(pfd[0]);

        write(pfd[1], "olá!\n", 7);

        sleep(5);

        write(pfd[1], "Tudo Bem?\n", 11);

        close(pfd[1]);

        wait(NULL);
    }

    return 0;
}