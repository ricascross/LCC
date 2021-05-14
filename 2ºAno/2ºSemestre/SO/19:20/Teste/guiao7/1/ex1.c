#include<signal.h>
#include<sys/types.h>
#include <stdio.h>
#include<unistd.h>

int time = 0;
int click = 0;

void counter_handler(){
    click++;
    printf("Passou %d segundos!\n", time);
}

void timeCounter_handler(){
    time++;
}

void terminated_handler(){
    printf("Carregou %d vezes no Control-C!\n", click);
    _exit(0);
}

int main(int argc, char* argv[]){
    signal(SIGINT, counter_handler);
    signal(SIGALRM, timeCounter_handler);
    signal(SIGQUIT, terminated_handler);
    
    alarm(1);
    while(1) {
        pause();
        alarm(1);
    }

    return 0;
}