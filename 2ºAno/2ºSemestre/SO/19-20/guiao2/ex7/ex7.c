#include<stdlib.h>
#include<stdio.h>
#include<time.h>
#include<sys/time.h>
#include<unistd.h>
#include<string.h>

#define Lines 10
#define Columns 1000

void make_matrix(int matrix[Lines][Columns]){
    time_t t;
    srand((unsigned) time(&t));
    for(int i=0; i<Lines; i++){
        for(int j=0; j<Columns; j++){
            matrix[i][j] = rand()%(Columns*Lines);
            
        }
    }
}

int main(int argc, char* argv[]){
    int matrix[Lines][Columns];
    int found = 0; //0 - didn't find, 1-found
    int elem = atoi(argv[1]); //cast to int
    int* res = malloc(sizeof(int));
    int r=0;
    
   

    make_matrix(matrix);
    
    for(int i=0;i<Lines && !found;i++){
        if(fork()==0){ //creates a new process line by line that will search over the columns 
            for(int j=0;j<Columns && !found;j++){
                if(matrix[i][j] == elem){
                    found = 1;
                }
            }
            if(found==1){
                _exit(i); //returns if had been found or hadn't
            }else{
                _exit(-10);
            }
        } else{ //wait for the son and kill him
            int status;
            wait(&status);
            if(WIFEXITED(status)){ //check if the child process terminated normally or get any error
                if(WEXITSTATUS(status)>=0 && WEXITSTATUS(status)<Lines){
                    res[r++] = WEXITSTATUS(status);
                }
            }
        }
    }
    
    for(int i=0;i<r;i++) printf("Foi encontrado em: %d\n", res[i]);
    
    return 0;
}