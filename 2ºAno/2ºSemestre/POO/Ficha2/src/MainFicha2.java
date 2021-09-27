
import java.util.Arrays;
import java.util.Scanner;
import static java.lang.System.out;
public class MainFicha2 {

    static Scanner ler;

    private static int[] leArray() {
        //exercicio1

        int tam;
        int[] array;


        out.print("Tamanho do array: ");
        tam = ler.nextInt();
        array = new int[tam];

        out.print("Escreva "+tam+" inteiros: ");
        for(int i=0 ; i < array.length;i++)
            array[i] = ler.nextInt();

        return array;
    }



    public static void main (String[] args){
        Ficha2 f = new Ficha2();
        ler = new Scanner(System.in);
        //int[] aux = leArray();

        //exercicio 1a)
        //out.println(f.minimo(aux));

        //exercicio 1b)

        /*int indice1,indice2;
        int subArray[];
        //fazer ler indice
        indice1 = 1;
        indice2 = 4;
        subArray = f.arrayNovo(aux,indice1,indice2);
        out.println(Arrays.toString(subArray));*/

        //exercicio1c
        /*
        int[] array1 = leArray();
        int[] array2 = leArray();
        int[] subArray;

        subArray = f.arrayComElementosComuns(array1,array2);

        out.println(Arrays.toString(subArray));*/







        ler.close();
    }

}
