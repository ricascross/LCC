#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX 1000 



int main(int argc, char* argv[]){
	int i = 1;
	int r;
	char *miniBuf = malloc(sizeof(int));
	char buf[MAX];
	while((r=read(0,buf,MAX))>0){
		sprintf(miniBuf, "     %d ",i++);
		write(1,miniBuf,sizeof(miniBuf));
		write(1,&buf,r);
	}
	
	
	return 0;
}
