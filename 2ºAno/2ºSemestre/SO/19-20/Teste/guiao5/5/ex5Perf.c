#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <string.h>

int pipes_couter(int argc, char* argv[]){
    int counter = 0;
    for(int i = 0; i < argc; i++){
        if(strcmp("|", argv[i]) == 0){
            counter++;
        }
    } 
    return counter;
}

int main(int argc, char* argv[]){
    int pipesCount = pipes_counter(argc, argv);
    
    int pfd[pipesCount][2];

    char* cmds[argc];

    for (int i = 0; i < argc; i++){
        cmds[i] = strdup(argv[i]);
    }

    


}