
/**
 * Escreva a descrição da classe FBFeed aqui.
 * 
 * @author (seu nome) 
 * @version (número de versão ou data)
 */
import java.util.List;
import java.util.ArrayList;
import static java.util.stream.Collectors.toList;
import java.util.TreeSet;
public class FBFeed
{
   private List<FBPost> feed;
   
   public FBFeed(){
    this.feed = new ArrayList<>();
   }
   
   public void addPost(FBPost p){
       this.feed.add(p.clone());
   }
   
   
   
   
   /**
    * metodos
    */
   public int nrPosts(String user) {
       return (int) this.feed.stream().filter((FBPost p)->p.getUsername().equals(user)).count();
   }
   
   public int nrPosts2(String user){
       int count = 0;
       
       for(FBPost p: this.feed){
           if (p.getUsername().equals(user)){
               count++;
           }
       }
       return count;
    }
    
    public List<FBPost> postsOf(String user){
        return this.feed.stream().filter(p-> p.getUsername().equals(user))
                                 .map(FBPost::clone)
                                 .collect(toList());
    }
    
    public FBPost getPost(int id){
        return this.feed.stream().filter(p -> p.getId() == id).findFirst().get();
    }
    
    public void comment(int postid, String comentario){
        FBPost post = this.feed.stream().filter(p-> p.getId() == postid).findFirst().get();
        post.addComentario(comentario);
                                 
    }
    
    public List<Integer> top5comments(){
         return this.feed.stream().sorted(c).limit(5).map(FBPost::clone).collect(toList());
    }
    
}
