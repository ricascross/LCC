#include <unistd.h>
#include <fcntl.h>

#define MAX 1000

int main(int argc, char* argv[]){
    int fd = open("myfifo", O_RDONLY);

    int bytesRead;
    char buffer[MAX];

    while((bytesRead = read(fd, buffer, MAX)) > 0){
        write(1, buffer, bytesRead);
    }

    close(fd);

    return 0;
}