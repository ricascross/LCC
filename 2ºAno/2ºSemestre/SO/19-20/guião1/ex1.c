//Fazer um programa igual ao cp, ou seja, faz a cópia de um ficheiro para um novo

#include <unistd.h>
#include <fcntl.h>

#define MAX 1


int main(int args, char* argv[]){
	int fd1 = open(argv[1], O_RDONLY);
	int fd2 = open(argv[2], O_CREAT | O_WRONLY, 0644);

	char buf[MAX];
	int r;
	while((r = read(fd1,buf,MAX))>0){
		write(fd2,buf,r);

	}
	close(fd1);
	close(fd2);
}

