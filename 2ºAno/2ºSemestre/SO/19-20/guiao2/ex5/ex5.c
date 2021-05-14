#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

int main(int argc, char* argv[]) {

	// Processos em profundidade
	
	if (fork()==0) {
		// Filho
		printf("Filho %d começou, é filho de %d\n", getpid(), getppid());

        for(int i=1; i<=10;i++){
            if (fork()==0) {
                // Filho
                printf("Filho %d (neto!) começou, é filho de %d\n", getpid(), getppid());
                sleep(3);
                printf("Filho %d terminou\n", getpid());

                _exit(i);  // MUITO IMPORTANTE!
            } else {
                // Pai
                int status;
                wait(&status);
                if(WIFEXITED(status)){
                    printf("Filho %d (neto do primeiro!)  terminado\n", WEXITSTATUS(status));
                }
                

            }
        }
		

		printf("Filho %d terminou\n", getpid());

		_exit(0);  // MUITO IMPORTANTE!
	} else {
		// Pai
        int status;
		wait(&status);
        if(WIFEXITED(status)){
            printf("Filho %d terminado\n", WEXITSTATUS(status));
        }
		
	}

}