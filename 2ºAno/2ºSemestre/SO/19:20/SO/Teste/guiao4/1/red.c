#include<unistd.h>
#include<fcntl.h>

#define MAX 1000

int main(int argc, char* argv[]){
    int fdInput = open("/etc/passwd", O_WRONLY);
    int fdOut = open("saidas.txt", O_WRONLY | O_CREAT, 0666);
    int fdError = open("erros.txt", O_WRONLY | O_CREAT, 0666);
    
    dup2(fdInput, 0);
    dup2(fdOut,1);
    dup2(fdError, 2);

    char* buffer[MAX];
    int bytesRead;

    while((bytesRead = read(0, buffer, MAX))> 0){
        write(fdOut, buffer, bytesRead);
    }

    close(fdOut);
    close(fdInput);
    close(fdError);

    return 0;
}