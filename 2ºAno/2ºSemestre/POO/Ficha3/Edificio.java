
/**
 * Escreva a descrição da classe Edificio aqui.
 * 
 * @author (seu nome) 
 * @version (número de versão ou data)
 */
public class Edificio
{
    private Lampada [][] corredores, salas;
    
    
    /**
     * nc -> numero de corredores
     * tc -> quantidade de lampadas no corredor
     * ns -> numero de salas
     * ts -> numero de lampadas na sala
     */
    public Edificio(int nc, int tc, Lampada lc, int ns, int ts, Lampada ls)
    {
        corredores = new Lampada[nc][tc];
        
        for (int i = 0; i<nc; i++)
            for (int j = 0; i < tc; j++)
            {   
                corredores[i][j] = lc.clone();
            }
    }
}
