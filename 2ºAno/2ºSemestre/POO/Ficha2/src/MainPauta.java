import java.util.Arrays;
import java.util.Scanner;
import static java.lang.System.out;



public class MainPauta {
    static Scanner ler;


    public static void main(String[] args){

        ler = new Scanner(System.in);

        int[][] notaTurma = new int[5][5];
        for (int i=0; i<notaTurma.length; i++){
            for (int j=0; j<notaTurma[i].length;j++){
                out.println("Alunos: "+i+" Nota da Unidade Curricular: "+j);
                notaTurma[i][j] = ler.nextInt();
            }
        }

        Pauta f = new Pauta(notaTurma);

        //exerciciob
        /*int uc;
        out.print("Introduza uma UC: ");
        uc = ler.nextInt();
        out.println("Soma das notas: "+f.somaNotas(uc));*/

        //exercicioc
        /*int aluno;

        out.print("Introduza um aluno: ");
        aluno = ler.nextInt();

        out.println("Média do Aluno é: "+f.mediaNotas(aluno));*/

        int uc;
        out.print("Introduza uma UC: ");
        uc = ler.nextInt();
        out.println("Soma das notas: "+f.mediaNotas(uc));


    }
}


