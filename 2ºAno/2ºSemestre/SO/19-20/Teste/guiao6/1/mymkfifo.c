#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char* argv[]){
    mkfifo("myfifo", 0666);

    return 0;
}