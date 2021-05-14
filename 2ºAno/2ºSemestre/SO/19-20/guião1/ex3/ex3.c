#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

int readchar(int fd){
	char buf;
	if (read(fd, &buf, sizeof(char))<0)
		return -1;
	else
		return buf;
}

ssize_t readln(int fd, char *buf, size_t size){
	int c = readchar(fd);
	int i =0;
	while(c!='\n' && c!=-1){
		buf[i] = c;
		i++;
		c = readchar(fd);
	}
	buf[i] = 0; //acrescentar o '/0' ao array.
	i++;
	return i;
}

int main(int argc, char* argv[]){
	int fd = open(argv[1], O_RDONLY);
	
	char buf[100];
	ssize_t r = readln(fd, buf,100);
	write(1,&buf,r);
	close(fd);
	
	
	return 0;
}
