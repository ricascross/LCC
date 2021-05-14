#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <stdlib.h>
 
int main(int argc, char* argv[]) {
 
    int pid = atoi(argv[1]);
 
    kill(pid, SIGUSR1); // não serve (só!) para matar!!!!
                        // serve para enviar qq sinal
 
}
