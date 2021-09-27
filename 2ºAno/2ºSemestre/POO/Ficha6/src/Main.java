import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class Main {
    public static void main(String[] args){
        Lugar l1 = new Lugar();
        l1.setMatricula ("00-aa-00");
        Lugar l2 = new Lugar();
        l2.setMatricula("11-bb-11");
        Map<String, Lugar> lugares = new HashMap<>();
        lugares.put(l1.getMatricula(), l1.clone());
        lugares.put(l2.getMatricula(), l2.clone());

        Parque p = new Parque("Parque 1", lugares);

        //teste
        Set<String> matriculas = p.todasMatriculas();
        matriculas.clear();
        System.out.println(p.todasMatriculas().size()==2);
    }
}
