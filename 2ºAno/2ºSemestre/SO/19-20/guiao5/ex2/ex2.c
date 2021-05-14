#include<unistd.h>
#include<stdio.h>
#include<sys/wait.h>

int main(int argc, char* argv[]){
    //1. criar um canal
    int pfd[2]; //pfd[0] = saida ; pfd[1] = entrada 
    ssize_t bytesRead;
    pipe(pfd);

    if(fork() == 0){
        //FILHO
        close(pfd[1]); // filho nunca usa a entrada

        printf("vou ler!\n");
        //3. receber bytes
        char buf[100];

        while((bytesRead = read(pfd[0],buf,100))>0)
            printf("recebi: %zd\n", bytesRead);

        _exit(0);
        
    }else{
        //PAI
        //enviar bytes
        sleep(5);

        write(pfd[1], "ola", 4);
        
        sleep(5);

        write(pfd[1], "ola", 4);

        close(pfd[1]); // passa a não haver nenhu,a entrada no pipe
       
        
        wait(NULL);
    }
    


    
}