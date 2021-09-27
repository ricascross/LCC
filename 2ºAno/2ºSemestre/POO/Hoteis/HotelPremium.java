
/**
 * Write a description of class HotelPremium here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
import java.io.*;
public class HotelPremium extends Hotel implements CartaoHoteis, Serializable
{
    /**
     * Taxa de luxo
     */
    private double taxaLuxo;

    /**
     * Construtor por omissao
     */
    public HotelPremium(){
        super();
        this.taxaLuxo = 0;
    }

    /**
     * Construtor por copia
     */
    public HotelPremium(HotelPremium outroHotel){
        super(outroHotel);
        this.taxaLuxo = outroHotel.getTaxa();
    }

    /**
     * Construtor Parametrizado
     */
    public HotelPremium(String code, String name, String adress, int stars, int rooms, double price, double taxa){
        super(code,name,adress,stars,rooms,price);
        this.taxaLuxo = taxa;
    }

    /**
     * Devolve a taxa de Luxo
     * @return taxaLuxo
     */
    public double getTaxa(){
        return this.taxaLuxo;
    }

    /**
     * Define uma nova taxa de luxo
     * @param novaTaxa
     */
    public void setTaxa(double novaTaxa){
        this.taxaLuxo = novaTaxa;
    }

    /**
     * Devolve o PrecoNoite de cada quarto
     * @return preco
     */
    public double precoNoite(){
        return getPrice()*this.taxaLuxo;
    }

    /**
     * Cria uma copia do HotelPremium
     * @return HotelPremium
     */
    public HotelPremium clone(){
        return new HotelPremium(this);
    }

    /**
     * Verifica a igualdade com outro object
     * @return boolean
     */
    public boolean equals(Object obj){
        if (this == obj) return true;
        if ((obj == null) || (this.getClass() != obj.getClass())) return false;

        HotelPremium hotel = (HotelPremium) obj;
        return super.equals(hotel) && hotel.getTaxa() == this.taxaLuxo;
    }

    /**
     * Formata tudo para representacao textual
     * @return String
     */
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("Hotel Premium"); sb.append("\n");
        sb.append(super.toString()); sb.append("\n");
        sb.append("Taxa de Luxo: "); sb.append(taxaLuxo);

        return sb.toString();
    }

    private int pontos;
    
    public int getValorPontos(){
        return this.pontos;
    }
    
    public void setValorPontos(int pontos){
        this.pontos = pontos;
    }
}
