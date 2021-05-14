#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
 
void morreu() {
    write(1, "filho morreu\n", 13);
    int pid = wait(NULL);
}
 
int main(int argc, char* argv[]) {
 
    signal(SIGCHLD, morreu);
 
    if (fork()==0) {
        sleep(5);
        write(1, "ok!\n", 4);
        _exit(0);
    }
 
    char buf[100];
    int n;
    while((n=read(0, buf, 100))>0) {
        write(1, buf, n);
    }
}
