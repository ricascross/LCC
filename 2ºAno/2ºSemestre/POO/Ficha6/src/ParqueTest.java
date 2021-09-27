
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import static org.junit.Assert.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
public class ParqueTest  {

    Parque p;


    @Before
    public void setUp()  {
        Lugar l1 = new Lugar();
        l1.setMatricula ("00-aa-00");
        Lugar l2 = new Lugar();
        l2.setMatricula("11-bb-11");
        Map<String, Lugar> lugares = new HashMap<>();
        lugares.put(l1.getMatricula(), l1.clone());
        lugares.put(l2.getMatricula(), l2.clone());
        p = new Parque("Parque 1", lugares);


    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void testeGetMatriculas() {
        Set<String> matriculas = p.todasMatriculas();
        matriculas.clear();
        assertEquals(2, p.todasMatriculas().size());
    }

    @Test
    public void testNLugares(){
        assertEquals(2, p.numLugares());
    }

}