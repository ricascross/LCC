#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

int main(int argc, char* argv[]){
    int pfd[2];
    pipe(pfd);

    if(fork() == 0){
        close(pfd[0]);
        dup2(pfd[1], 1);
        close(pfd[1]);

        execlp("grep", "grep", "-v", "^#", "/etc/passwd", NULL);
        perror("grep");
        _exit(0);

    }else {
        wait(NULL);

        int pfd2[2];
        pipe(pfd2);

        if(fork() == 0){
            close(pfd[1]);
            dup2(pfd[0], 0);
            close(pfd[0]);

            close(pfd2[0]);
            dup2(pfd2[1], 1);
            close(pfd2[1]);

            execlp("cut", "cut", "-f7", "-d:", NULL);
            perror("cut");
            _exit(1);
        }
        close(pfd[0]);
        close(pfd[1]);
        wait(NULL);

        int pfd3[2];
        pipe(pfd3);

        if (fork() == 0)
        {
            close(pfd2[1]);
            dup2(pfd2[0], 0);
            close(pfd2[0]);

            close(pfd3[0]);
            dup2(pfd3[1], 1);
            close(pfd3[1]);

            execlp("uniq", "uniq", NULL);
            perror("uniq");
            _exit(2);
        }

        close(pfd2[1]);
        close(pfd2[0]);
        wait(NULL);

        if (fork() == 0)
        {
            close(pfd3[1]);
            dup2(pfd3[0], 0);
            close(pfd3[0]);

            execlp("wc", "wc", "-l", NULL);
            perror("wc");
            _exit(3);
        }

        close(pfd3[1]);
        close(pfd3[0]);
        wait(NULL);
    }
}