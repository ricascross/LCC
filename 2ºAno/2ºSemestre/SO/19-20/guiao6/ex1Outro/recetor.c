#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char* argv[]){
    mkfifo("fifo", 0600); //só o user pode ler e escrever

    int entrada = open("fifo", O_RDONLY);

    char buf[100];
    int bytesRead;

    while((bytesRead = read(entrada, buf, 100))>0){
        write(1, buf, bytesRead);
    }

    close(entrada);
}