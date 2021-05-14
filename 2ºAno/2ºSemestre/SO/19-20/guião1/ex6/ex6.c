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

void insertPerson(char *argv[])
{
	int fd = open("pessoas.dat", O_CREAT | O_WRONLY | O_APPEND, 0644);

	char newName[MAX];
	strcpy(newName, argv[2]);

	int newAge = atoi(argv[3]);

	struct person novo;
	strcpy(novo.name, newName);
	novo.age = newAge;

	write(fd, &novo, sizeof(struct person));

	close(fd);
	
}

void updatePerson(char *argv[])
{
	int fd = open("pessoas.dat", O_RDWR);
	ssize_t bytesRead;
	struct person aux;

	char newName[MAX];
	strcpy(newName, argv[2]);

	int newAge = atoi(argv[3]);

	while ((bytesRead = read(fd, &aux, sizeof(struct person))) > 0)
	{

		if (strcmp(aux.name, argv[2])==0)
		{
			lseek(fd, bytesRead*(-1), SEEK_CUR);
			strcpy(aux.name, newName);
			aux.age = newAge;
			write(fd, &aux, sizeof(struct person));
			break;
		}
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
		insertPerson(argv);
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
