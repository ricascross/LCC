
/**
 * Write a description of class HotelStandard here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
import java.io.*;
public class HotelStandard extends Hotel implements CartaoHoteis, Serializable
{
   /**
    * Boolean para ver se epoca alta ou nao
    */
   private boolean epocaAlta;
   
   /**
    * Construtor por Omissao
    */
   public HotelStandard(){
       super();
       epocaAlta = false;
   }
   
   /**
    * Construtor por copia
    */
   public HotelStandard(Hotel outroHotel){
       super(outroHotel);
       this.epocaAlta = getEpoca();
   }
   
   /**
    * Construtor parametrizado
    */
   public HotelStandard(String code, String name, String adress, int stars, int rooms, double price, boolean epoca){
       super(code,name,adress,stars,rooms,price);
       this.epocaAlta = epoca;
   }
   
   /**
    * Devolve true se for epoca alta e false se nao for.
    * 
    * @return boolean
    */
   public boolean getEpoca(){
       return this.epocaAlta;
   }
   
   /**
    * Insere uma nova epoca.
    * 
    * @param epoca
    */
   public void setEpoca(boolean epoca){
       this.epocaAlta = epoca;
   }
   
   /**
    * Devolve o PrecoNoite de cada quarto
    * @return preco
    */
   public double precoNoite(){
       return getPrice() + (this.epocaAlta?20:0);
   }
    
   /**
    * Faz uma copia do HotelStandard.
    * 
    * @return HotelStandard
    */
   public HotelStandard clone(){
       return new HotelStandard(this);
   }
   
   /**
    * Verifica se existe um hotel igual
    * 
    * @return boolean
    */
   public boolean equals(Object obj){
       if (obj == this) return true;
       if ((obj == null) || (obj.getClass() != this.getClass())) return false;
       
       HotelStandard hotel = (HotelStandard) obj;
       
       return super.equals(hotel) && hotel.getEpoca() == this.epocaAlta;
   }
   
   /**
    * Retorna a representacao textual
    * 
    * @return String
    */
   public String toString(){
       StringBuilder sb = new StringBuilder();
       sb.append("Hotel Standard"); sb.append("\n");
       sb.append(super.toString()); sb.append("\n");
       sb.append("Epoca Alta: ");sb.append(this.epocaAlta);
       
       return sb.toString();
   }
   
   private int pontos;
   /**
    * Define o numero de pontos a acumular
    * @param pontos
    */
   public void setValorPontos(int pontos){
       this.pontos = pontos;
   }
   /**
    * Define o numero de pontos a acumular
    * @return int
    */
   public int getValorPontos(){
       return this.pontos;
   }
}
