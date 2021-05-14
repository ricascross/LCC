#include <unistd.h>
#include <fcntl.h>
#include <string.h>


int main(int argc, char* argv[]){
    int fd = open("myfifo", O_WRONLY);
    write(fd, argv[1], strlen(argv[1]));

    close(fd);

    return 0;
}