#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char* argv[]){
    int pfd[3][2];
    pipe(pfd[0]);

    if (fork() == 0)
    {
        close(pfd[0][0]);
        dup2(pfd[0][1], 1);
        close(pfd[0][1]);

        execlp("grep", "grep", "-v", "^#", "/etc/passwd", NULL);
        perror("grep");
        _exit(0);
    }
    else
    {
        wait(NULL);

        pipe(pfd[1]);

        if (fork() == 0)
        {
            close(pfd[0][1]);
            dup2(pfd[0][0], 0);
            close(pfd[0][0]);

            close(pfd[1][0]);
            dup2(pfd[1][1], 1);
            close(pfd[1][1]);

            execlp("cut", "cut", "-f7", "-d:", NULL);
            perror("cut");
            _exit(1);
        }
        close(pfd[0][0]);
        close(pfd[0][1]);
        wait(NULL);

        pipe(pfd[2]);

        if (fork() == 0)
        {
            close(pfd[1][1]);
            dup2(pfd[1][0], 0);
            close(pfd[1][0]);

            close(pfd[2][0]);
            dup2(pfd[2][1], 1);
            close(pfd[2][1]);

            execlp("uniq", "uniq", NULL);
            perror("uniq");
            _exit(2);
        }

        close(pfd[1][1]);
        close(pfd[1][0]);
        wait(NULL);

        if (fork() == 0)
        {
            close(pfd[2][1]);
            dup2(pfd[2][0], 0);
            close(pfd[2][0]);

            execlp("wc", "wc", "-l", NULL);
            perror("wc");
            _exit(3);
        }

        close(pfd[2][1]);
        close(pfd[2][0]);
        wait(NULL);
    }
}