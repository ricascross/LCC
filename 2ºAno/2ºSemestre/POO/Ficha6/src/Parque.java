import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.Collection;
import java.util.stream.Collectors;

/**
 * KeySet()     Values()
 *         ___   _ VA
 *      K1    \/
 *      K2    /\_ VB
 *      K3   ---- VC
 */

public class Parque {
    /**
     * nome do Parque
     */
    private String nome;

    /**
     * Representação do parque: Matricula -> Lugar
     */
    private Map<String,Lugar> lugares;

    public Parque()
    {
        this.lugares = new HashMap<>();

    }

    public Parque(String nome, Map<String, Lugar> lugares){
        this.setNome(nome);
        this.setLugares(lugares);
    }

    public Parque(Parque parque){
        this.nome = parque.getNome();
        this.lugares = parque.getLugares();
    }

    public String getNome(){
        return this.nome;
    }

    public void setNome(String nome){
        this.nome = nome;
    }

    /**
     * itera as chaves
     * @return
     */
    public Map<String, Lugar> getLugares(){
        Map<String, Lugar> res = new HashMap<>();
        Set<String> matriculas = this.lugares.keySet();

        for(String m : matriculas){ // iterar matriculas uma a uma
            Lugar l = this.lugares.get(m); //buscar o lugar dando uma matricula
            res.put(m,l.clone()); //vai copiar o lugar
        }
        return res;
    }

    /**
     * itera os valores;
     * @return
     */
    public Map<String, Lugar> getLugares2(){
        Map<String, Lugar> res = new HashMap<>();
        Collection<Lugar> lugares = this.lugares.values();

        for(Lugar l : lugares){ // iterar matriculas uma a uma
            String k = l.getMatricula();
            res.put(k,l.clone()); //vai copiar o lugar
        }
        return res;
    }

    /**
     * itera o par matriculas/lugar;
     * itera tanto por chave como por valor
     * @return
     */
    public Map<String, Lugar> getLugares3(){
        Map<String, Lugar> res = new HashMap<>();

        for (Map.Entry<String,Lugar> par : this.lugares.entrySet()){
            String matricula = par.getKey();
            Lugar lugar = par.getValue();
            res.put(matricula, lugar.clone());
        }

        return res;
    }


    public Map<String, Lugar> getLugares4(){
        Map<String, Lugar> res = this.lugares.values().stream()
                .collect(Collectors.toMap((lugar)-> lugar.getMatricula(),
                                          (lugar)->lugar.clone()));



        return res;
    }



    public void setLugares(Map<String, Lugar> lugares) {
        this.lugares = new HashMap<>();
        lugares.values().forEach(l -> this.lugares.put(l.getMatricula(), l.clone()));
    }

    /**
     * fazer métodos:
     *  - toString;
     *  - equals;
     *  - clone
     */

    /**
     * Métodos
     */

    public Set<String> todasMatriculas(){
        return this.lugares.keySet().stream().collect(Collectors.toSet());
    }

    public int numLugares(){
        return this.lugares.size();
    }

    public void registaLugar(Lugar l){
        this.lugares.put(l.getMatricula(), l.clone());
    }

    public void removeLugar(String matricula){
        this.lugares.remove(matricula);
    }

    public Lugar obterLugar(String matricula){
        return this.lugares.get(matricula).clone();
    }

    public void alteraTempoDisponivel(String matricula, int aumentaTempo){
        obterLugar(matricula).setMinutos(aumentaTempo);

    }

    
}

