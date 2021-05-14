#include<unistd.h>
#include<stdio.h>

int main(int argc, char* argv[]){
    //1. criar um canal
    int pfd[2]; //pfd[0] = saida ; pfd[1] = entrada 
    
    pipe(pfd);


    //enviar bytes
    write(pfd[1], "ola", 4);


    //3. receber bytes
    char buf[100];
    read(pfd[0], buf, 4);

    printf("recebi: %s\n", buf);
}