#include <unistd.h>
#include <fcntl.h>


int main(int argc, char* argv[]){
    char buf[100];
    int n;

    n = read(0,buf, 100);
    write(1, &buf, n);

    int fd = open("entrada.txt", O_CREAT | O_RDWR, 0644);
    dup2(fd, 0); //redireciona o apontador do fd para o standard input

    
    int fd2 = open("saida.txt", O_CREAT | O_RDWR, 0644);
    dup2(fd2, 1); //redireciona o apontador do fd para o standard input
    
    int fd3 = open("erros.txt", O_CREAT | O_RDWR, 0644);
    dup2(fd3, 2); //redireciona o apontador do fd para o standard input
    
    //o dup2(...,0)
    //o dup2(...,1)
    //o dup2(...,2)
    //nunca ao contrário

    n = read(0,buf,100); //neste caso não vai ler do terminal, mas sim do fd, porque o apontador do stdin(0) está a apontar para o fd
    write(1,buf,n);
    

    return 0;
}