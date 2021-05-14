#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <string.h>
 
char * msg;
 
//void tempo(char* msg) { --> ERRADO!
void tempo() {
    write(1, msg, strlen(msg));
   // _exit(0);
}
 
void nope() {
    write(1, "Nope.", 5);
}
 
int main(int argc, char* argv[]) {
 
    signal(SIGALRM, tempo);
    //signal(SIGALRM, tempo()); // --> ERRADO!
    //signal(SIGALRM, tempo("mensagem")); // --> ERRADO!
 
    signal(SIGINT, nope);
    signal(SIGQUIT, nope);
    signal(SIGTERM, nope);
    signal(SIGHUP, nope);
    signal(SIGKILL, nope); // --> não funciona!
    signal(SIGSTOP, nope); // --> não funciona!
    signal(SIGCONT, nope); // --> não funciona!
 
    char pin[4];
 
    msg = "Fim do tempo\n";
 
    write(1, "Pin: ", 5);
    
    alarm(5);
    read(0, pin, 4);
 
    write(1, "Ok!\n", 4);
}
