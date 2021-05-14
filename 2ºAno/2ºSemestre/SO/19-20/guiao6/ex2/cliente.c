#include <unistd.h>
#include <fcntl.h>
#include <string.h>

int main(int argc, char* argv[]){
    int entry = open("fifo", O_WRONLY); //open the pipe fifo to write

    strcat(argv[1], "\n");

    write(entry, argv[1], strlen(argv[1]));

    close(entry);

    return 0;
}