#include <unistd.h>
#include <fcntl.h>

#define MAX 1000

int main(int argc, char* argv[]){
	int fd = open(argv[1], O_RDONLY);
	int r;
	char buf[MAX];
	while((r=read(fd,buf,MAX))>0){
		write(1, &buf, r);
	}
	close(fd);
}
