OUTPUT: main.o redir.o mySystem.o
	gcc main.o redir.o mySystem.o -o output

main.o: main.c redir.h mySystem.h
	gcc -c main.c

redir.o: redir.c
	gcc -c redir.c

mySystem.o: mySystem.c
	gcc -c mySystem.c

clean: 
	rm *.o output
