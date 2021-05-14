#include<unistd.h>
#include <fcntl.h>
#include <sys/wait.h>

int main(int argc, char* argv[]){
    write(1, "Antes\n", 6);

    int fd = open("saida.txt", O_WRONLY | O_CREAT, 0644);
    dup2(fd,1);

    if (fork()==0){
        write(1, "Filho\n", 6);
        _exit(0);
    } else{
        write(1, "Pai\n", 4);
        wait(NULL);
    }

    return 0;
}