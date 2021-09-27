
/**
 * Write a description of class HotelDiscount here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class HotelDiscount extends Hotel
{
    /**
     * taxa de ocupacao
     */
    private double ocupacao;
    
    /**
     * Construtor por omissao
     */
    public HotelDiscount(){
        super();
        this.ocupacao = 0;
    }
    
    /**
     * Constutor por copia
     */
    public HotelDiscount(HotelDiscount outroHotel){
        super(outroHotel);
        this.ocupacao = outroHotel.getOcupacao();
    }
    
    /**
     * COnstrutor Parametrizado
     */
    public HotelDiscount(String code, String name, String adress, int stars, int rooms, double price, double ocupacao){
        super(code,name,adress,stars,rooms,price);
        this.ocupacao = ocupacao;
    }
    
    /**
     * Devolve a taxa de ocupacao
     * @return ocupacao
     */
    public double getOcupacao(){
        return this.ocupacao;
    }
    
    /**
     * Define uma nova taca de ocupacao
     * @param novaOcupacao
     */
    
    public void setOcupacao(double novaOcupacao){
        this.ocupacao = novaOcupacao;
    }
    
    /**
    * Devolve o PrecoNoite de cada quarto
    * @return preco
    */
    public double precoNoite(){
        return getPrice()*0.5 + getPrice()*0.4*this.ocupacao;
    }
   
    /**
     * Cria uma copia do hotelDiscount
     * @return HotelDiscount
     * 
     */
    public HotelDiscount clone(){
        return new HotelDiscount(this);
    }
    
    /**
     * Verifica a igualde com outro object
     * @return boolean
     */
    public boolean equals(Object obj){
        if(obj == this) return true;
        if ((obj == null) || (this.getClass() != obj.getClass())) return false;
        
        HotelDiscount hotel = (HotelDiscount) obj;
        return super.equals(hotel) && hotel.getOcupacao() == this.ocupacao;
    }
    
    /**
     * FOrmata tudo para representaçao textual
     * @return String
     */
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("Hotel Discount"); sb.append("\n");
        sb.append(super.toString());sb.append("\n");
        sb.append("Taxa de Ocupacao: "); sb.append(this.ocupacao);
        
        return sb.toString();
    }
}
