

import static org.junit.Assert.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * The test class TesteParque.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class TesteParque
{
    /**
     * Default constructor for test class TesteParque
     */
    public TesteParque()
    {
    }

    /**
     * Sets up the test fixture.
     *
     * Called before every test case method.
     */
    @Before
    public void setUp()
    {
        Lugar l1 = new Lugar();
        l1.setMatricula ("00-aa-00");
        Lugar l2 = new Lugar();
        l2.setMatricula("11-bb-11");
        Map<String, Lugar> lugares = new HashMap<>();
        lugares.put(l1.getMatricula(), l1.clone());
        lugares.put(l2.getMatricula(), l2.clone);

        Parque p = new Parque("Parque 1", lugares);
    }

    /**
     * Tears down the test fixture.
     *
     * Called after every test case method.
     */
    @After
    public void tearDown()
    {
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
    
    public void registaLugar(Lugar l){
        this.lugares.put(l.getMatricula(), l.clone());
    }
    
    public void removeLugar(String matricula){
        this.lugares.remove(matricula);
    }
    
    public Lugar obterLugar(String matricula){
        return this.lugares.get(matricula).clone();
    }
}
