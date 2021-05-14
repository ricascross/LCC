#include <unistd.h>
#include <fcntl.h>

int main(int argc, char* argv[]){
    int entrada = open("fifo", O_WRONLY);

    char buf[100];
    int bytesRead;
    
    int i =0;
    while( i < 10){
        write(entrada, "ola, tudo bem?\n", 16);
        i++;
    }


    close(entrada);
}