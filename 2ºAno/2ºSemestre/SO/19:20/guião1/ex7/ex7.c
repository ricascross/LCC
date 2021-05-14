#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <string.h>
#include <stdlib.h>

#define MAX 100

struct person
{
	char name[MAX];
	int age;
};

off_t insertPerson(char *argv[])
{
	int fd = open("pessoas.dat", O_CREAT | O_WRONLY | O_APPEND, 0644);

	char newName[MAX];
	strcpy(newName, argv[2]);

	int newAge = atoi(argv[3]);

	off_t position;

	struct person novo;
	strcpy(novo.name, newName);
	novo.age = newAge;

	ssize_t bytesRead = write(fd, &novo, sizeof(struct person));

	position = lseek(fd, bytesRead*(-1), SEEK_CUR);

	close(fd);
	return position;
}

void updatePerson(char *argv[])
{
	int fd = open("pessoas.dat", O_RDWR);
	ssize_t bytesRead;
	struct person aux;

	char newName[MAX];

	int newAge = atoi(argv[3]);
	off_t position = atoi(argv[2]);
	int counter =0;

	while ((bytesRead = read(fd, &aux, sizeof(struct person))) > 0)
	{
		if (counter == position)
		{
			lseek(fd,bytesRead*(-1),SEEK_CUR);
			aux.age = newAge;
			write(fd, &aux, sizeof(struct person));
			break;
		}
		counter += bytesRead;
	}
	close(fd);
}

void printPersons()
{
	int fd = open("pessoas.dat", O_RDONLY);

	struct person aux;
	ssize_t r;
	while ((r = read(fd, &aux, sizeof(struct person))) > 0)
	{

		printf("Nome: %s, Idade: %d\n", aux.name, aux.age);
	}
	close(fd);
}

int main(int argc, char *argv[])
{
	if (argc < 1)
	{
		printf("Faltam argumentos");
		return 1;
	}

	if (strcmp(argv[1], "-i") == 0)
	{
		//Acrescentar pessoas a um ficheiro binário
		off_t position = insertPerson(argv);
		printf("%lld\n", position);
	}
	else if (strcmp(argv[1], "-u") == 0)
	{
		//Altera a idade de uma dada pessoa
		updatePerson(argv);
	}
	else if (strcmp(argv[1], "-p") == 0)
	{
		printPersons();
	}
	else
	{
		printf("Insira parâmetros corretos\n");
	}
	return 0;
}
