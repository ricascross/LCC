#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

#define MAX 1000

int main (int argc, char* argv[]){
    mkfifo("myfifo", 0600);

    int fd = open("myfifo", O_RDONLY);
    int fdLog = open("logs.log", O_CREAT | O_WRONLY , 0666);

    int bytesRead;
    char buffer[MAX];

    while(1){
        bytesRead = read(fd, buffer, sizeof(buffer));
        write(fdLog, buffer, bytesRead);
        
    }

    close(fdLog);
    close(fd);
    

    return 0;
}