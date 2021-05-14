#include <signal.h>
#include <sys/types.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>


int counter = 0;
int time_counter = 0;
char *msg1;
char *msg2;


void time(){
    time_counter += 1;
}

void counter_CONTROL_C(){
    counter +=1;
    
    printf("Já passou %d segundos!\n", time_counter);
}

void finish(){
    printf("O ^C foi premido %d vezes!\n", counter);

    _exit(0);
}

int main(int argc, char* argv[]){
    signal(SIGALRM, time);
    signal(SIGINT, counter_CONTROL_C);
    signal(SIGQUIT, finish);

    int bytesRead;
    char buf[100];
    
    alarm(1);
    while((bytesRead = read(0,buf, 100))>0) alarm(1);
    

    return 0;
}