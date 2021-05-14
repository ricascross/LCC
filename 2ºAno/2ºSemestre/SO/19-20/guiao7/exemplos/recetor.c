#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <stdlib.h>
#include <stdio.h>
 
void recebi() {
    write(1, "recebi!", 7);
}
 
int main(int argc, char* argv[]) {
 
    printf("eu sou %d\n", getpid());
 
    signal(SIGUSR1, recebi); // instantaneo!!!
 
    //while(1); // MUITO ERRADO! Espera ativa!
 
    while(1)
        pause(); // pedir ao scheduler para não o escolher
}
