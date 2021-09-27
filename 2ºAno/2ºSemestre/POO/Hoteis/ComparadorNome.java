
/**
 * Write a description of class ComparadorNome here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
import java.util.Comparator;
public class ComparadorNome implements Comparator<Hotel>
{
    public int compare(Hotel h1, Hotel h2){
        return h1.getName().compareTo(h2.getName());
    }
}
