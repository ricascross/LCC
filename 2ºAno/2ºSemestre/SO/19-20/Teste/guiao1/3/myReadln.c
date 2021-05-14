#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>

#define MAX 1000

char readln(char buffer[], int bytesRead){
    char line[bytesRead - 1];
    if (bytesRead > 0){
        for (int i = 0; i < bytesRead; i++){
            if(buffer[i] != '\n'){
                strcpy(line, buffer[i]);
            } else {
                return line;
            }
        }
    }
    return line;
}

int main(int argc, char* argv[]){
    char buffer[MAX];
    int bytesRead;
    char lineRead;

    if (argc > 1){
        int fd = open(argv[1], O_RDONLY);

        while((bytesRead = read(fd, buffer, MAX))>0){
            lineRead = readln(buffer, bytesRead);
            printf("%s", lineRead);
        }
    }

    return 0;
}