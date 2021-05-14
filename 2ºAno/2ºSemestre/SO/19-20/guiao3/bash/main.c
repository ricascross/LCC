#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include "mySystem.h"
#include "redir.h"
 

#define MAX 10000
 
 

int main(int argc, char* argv[]){
    ssize_t bytesRead;
    char buf[MAX];
    while((bytesRead = read(0,buf,MAX)) >0){
        buf[bytesRead] = '\0'; 
        
        if (strchr(buf, '<') != NULL){
            redirInput(buf);
        } else if (strchr(buf, '>') != NULL)
        {
            redirOutput(buf);
        } else if (strchr(buf, '>>') != NULL)
        {
            appendRedirectedOutput(buf);
        }
        else if (strchr(buf, '2>') != NULL)
        {
            redirInputAndError(buf);
        }
        else if (strchr(buf, '2>>') != NULL)
        {
            appendRedirectedOutputAndError(buf);
        } else {
            my_system(buf);
        }

        
    }
    return 0;
}
