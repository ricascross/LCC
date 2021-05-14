#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char* argv[]){
    
    char* cmds[argc];
    for(int i =0; i < argc; i++){
        cmds[i] = strdup(argv[i]);
    } 

    char* token;
    const char delim[2] = "|";

    
    token = strtok(argv[1], delim);

    int N = 0;

    while(token != NULL){
        printf("%s\n", token);
        token = strtok(NULL, delim);
        N++;
    }

    


    int pant[2]; //pipe anterior
    int pseg[2]; //pipe seguinte

    
    

    
    for(int i=0; i<N; i++){
        if (i != N-1){
                pipe(pseg);
        }

        if (fork() == 0){
            if(i != 0){ // se não é a primeira
                //close(pant[1]); não é necessºario, foi fechado pelo pai no inicio da iteração anterior
                dup2(pant[0], 0); // redir stdin do pipe anterior
                close(pant[0]);
            }
            

            close(pseg[0]);
            dup2(pseg[1],1);
            close(pseg[1]);

            //partir o cmd[i] em args usand o strtok
            //execvp();
            //perror();
            _exit(i);

        }else{

            if(i != 0){
                close(pant[0]);
            }
            if(i != N-1){
                close(pant[0]);
                close(pseg[1]);
                pant[0] = pseg[0];
            }
            
        }
    }

    for(int i =0; i < N; i++){ //mete todos os filhos a trabalhar e depois espera por todos
        wait(NULL);
    }
}