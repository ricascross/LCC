#include <unistd.h>
#include <fcntl.h>

#define MAX 1000

int main(int argc, char* argv[]){
    int fd = open("myfifo", O_WRONLY);

    int bytesRead;
    char buffer[MAX];

    while((bytesRead = read(0, buffer, MAX))>0){
        write(fd, buffer, bytesRead);
    }

    close(fd);

    return 0;
}