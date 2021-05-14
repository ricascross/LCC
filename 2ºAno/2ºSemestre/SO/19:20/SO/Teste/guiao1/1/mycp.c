#include <unistd.h>
#include <fcntl.h>

#define MAX 100

int main(int argc, char* argv[]){
    int readFile = open(argv[1], O_RDONLY);
    int writeFile = open(argv[2], O_CREAT | O_WRONLY, 0644);

    char buffer[MAX];
    int bytesRead;

    while((bytesRead = read(readFile, buffer, MAX))>0)
    {
        write(writeFile, buffer, bytesRead);
    }

    close(readFile);
    close(writeFile);

    return 0;
}