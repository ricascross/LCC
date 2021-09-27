public class Pauta {
    private int notaTurma[][];

    public Pauta(int[][] nota){
        this.notaTurma = nota;
    }

    public int somaNotas(int uc){
        int res = 0;

        for(int i=0;i<notaTurma.length; i++){
            for (int j=0;j<notaTurma[i].length;j++){
                if (j == uc)
                    res += notaTurma[i][j];
            }
        }
        return res;
    }

    public double mediaNotas(int aluno){
        int res = 0;
        for (int i=0;i<notaTurma.length;i++){
            if (i == aluno){
                for (int j=0;j<notaTurma[i].length;j++){
                    res += notaTurma[i][j];
                }
            }
        }
        return (res/5);
    }

    public double mediaUC (int uc){
        int notas = somaNotas(uc);
        return (notas/5);
    }

    public int notaMaisAlta (int uc){
        int res = 0;

        

    }
}


