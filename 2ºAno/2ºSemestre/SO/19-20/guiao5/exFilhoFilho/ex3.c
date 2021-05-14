#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

int main(int argc, char* argv[]) {
	// 1. criar um canal
	int pfd[2];
		// pfd[0] = saida
		// pfd[1] = entrada
	pipe(pfd);

	if (fork()==0) {
		// FILHO
		close(pfd[0]); // este nunca usa a saida

			// 2. enviar bytes
			char buf[1000];
			for(int i=0;i<1000;i++) {
				sleep(20);
				write(pfd[1], buf, 1000);
				printf("escrevi %d bytes\n", i*1000);
			}

			close(pfd[1]); // passa a não haver nenhuma entrada no pipe!

		_exit(0);
	} else {
		if (fork() == 0){
			//Segundo Filho
			close(pfd[1]); // este nunca usa a entrada

			printf("vou ler!\n");

			// 3. receber bytes
			char buf[1000];
			int n;
			int max=10;
			while((n=read(pfd[0], buf, 1000))>0 && max>0) {
				//sleep(20);
				printf("recebi %d bytes\n", n);
				max--;
			}

			close(pfd[0]); // passa a não haver nunhuma saida do pipe!
			_exit(0);
		}else{
			// PAI
			wait(NULL);
		}
		wait(NULL);
	}
}
    


    
