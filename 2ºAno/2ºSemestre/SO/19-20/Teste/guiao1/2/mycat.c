#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

#define MAX 1000

int main(int argc, char* argv[]){
    char buffer[MAX];
    int bytesRead;
    if (argc > 1){
        int fd = open(argv[1], O_RDONLY);

        while((bytesRead = read(fd, buffer, MAX)) > 0)
        {
            write(1, buffer, bytesRead);
        }

        close(fd);

    } else {
        while ((bytesRead = read(0, buffer, MAX)) > 0)
        {
            write(1, buffer, bytesRead);
        }
    }
    

    return 0;
}