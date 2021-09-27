
/**
 * Escreva a descrição da classe Video aqui.
 * 
 * @author (seu nome) 
 * @version (número de versão ou data)
 */

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Arrays;

public class Video
{
    private String nome;
    private byte[] conteudo;
    private LocalDateTime dataCarr;
    private int resolucao;
    private LocalTime duracao;
    private String[] comentarios;
    private int numCom;
    private int likes, dislikes;
    
    public Video(){
        this.nome = "";
        this.conteudo = new byte[10];
        this.dataCarr = LocalDateTime.now();
        this.resolucao = 0;
        this.duracao = LocalTime.of(0,0);
        this.comentarios = new String[10];
        this.numCom = 0;
        this.likes = 0;
        this.dislikes = 0;
    }
    
    public Video(String nome, byte[] conteudo, LocalDateTime dataCarr, int resolucao, 
                 LocalTime duracao, String[] comentarios, int numCom, int likes, int dislikes){
           
           this.nome = nome;
           this.conteudo = Arrays.copyOf(conteudo, conteudo.length);
           this.dataCarr = dataCarr;
           this.resolucao = resolucao;
           this.duracao = duracao;
           this.comentarios = Arrays.copyOf(comentarios, comentarios.length);
           this.numCom = numCom;
           this.likes = likes;
           this.dislikes = dislikes; 
    }
    
}
