#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

int main(int argc, char* argv[]){
    int pfd[2];
    pipe(pfd);

    if (fork() == 0){
        close(pfd[0]);
        dup2(pfd[1], 1);
        close(pfd[1]);
        execlp("ls", "ls", "/etc", NULL);
        perror("ls");
        _exit(1);
    }else{

        if (fork() == 0)
        {
            close(pfd[1]);
            dup2(pfd[0], 0);
            close(pfd[0]);

            execlp("wc", "wc", "-l", NULL);
            perror("wc");
            _exit(2);
        }

        close(pfd[1]);
        close(pfd[0]);

        wait(NULL);
        wait(NULL);
    }
}