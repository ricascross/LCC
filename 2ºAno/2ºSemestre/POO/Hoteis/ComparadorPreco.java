
/**
 * Write a description of class ComparadorPreco here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
import java.util.Comparator;
public class ComparadorPreco implements Comparator<Hotel>
{
    public int compare(Hotel h1, Hotel h2){
        if(h1.getPrice() < h2.getPrice()) return 1;
        if(h1.getPrice() > h2.getPrice()) return -1;
        return 0;
    }
}
