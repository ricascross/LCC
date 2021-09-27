
/**
 * Escreva a descrição da classe FBFeedTest aqui.
 * 
 * @author (seu nome) 
 * @version (número de versão ou data)
 */
import java.util.ArrayList;
import java.util.LocalDateTime;
public class FBFeedTest
{
    public static void main(String[] args) {
        FBFeed face = new FBFeed();
        FBPost p1 = new FBPost(1,"jfc", LocalDateTime.now(), "Umpost!", 0, ArrayList<String>());
        
        face.addPost(p1);
        
        p1.setId(2);
        
        face.addPost(p1);
        
    }
}
