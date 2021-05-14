#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>


int main(int argc, char* argv[]){
    mkfifo("fifo", 0600);
    int exit = open("fifo", O_RDONLY); //Opens the named pipe only for read

    int logFile = open("client.log", O_CREAT | O_WRONLY | O_APPEND, 0666); //open logsfile in write mode

    int bytesRead;
    char buf[100];

    while(1){
        bytesRead = read(exit, buf, sizeof(buf));
        write(logFile, buf, bytesRead);
    }

    close(logFile);
    close(exit);

    return 0;
}