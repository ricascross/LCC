#include <unistd.h>
#include <fcntl.h>

int main(int argc, char* argv[]){
    int entrada = open("fifo", O_WRONLY);

    char buf[100];
    int bytesRead;
    
    while((bytesRead = read(0, buf, sizeof(buf)))>0){
        write(entrada, buf, bytesRead);
    }


    close(entrada);
}