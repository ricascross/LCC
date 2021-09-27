
/**
 * Write a description of class Hotel here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
import java.io.*;
public abstract class Hotel implements Serializable, Comparable<Hotel>
{
    /**
     * codigo do hotel
     */
    private String code;
    
    /**
     * nome do hotel
     */
    private String name;
    
    /**
     * localidade do hotel
     */
    private String adress;
    
    /**
     * Estrelas do hotel
     */
    private int stars;
    
    /**
     * Numero de quartos
     */
    private int rooms;
    
    /**
     * Preco por quarto
     */
    private double price;
    
    /**
     * Construtor por omissao
     */
    public Hotel(){
        this.code = "n/a";
        this.name = "n/a";
        this.adress = "n/a";
        this.stars = 1;
        this.rooms = 0;
        this.price = 0;
    }
    
    /**
     * Construtor 
     */
    public Hotel(String code, String name, String adress, int stars, int rooms, double price){
        this.code = code;
        this.name = name;
        this.adress = adress;
        this.stars = stars;
        this.rooms = rooms;
        this.price = price;
    }
    
    /**
     * Construtor por copia
     */
    public Hotel(Hotel outroHotel){
        this.code = outroHotel.getCode();
        this.name = outroHotel.getName();
        this.adress = outroHotel.getAdress();
        this.stars = outroHotel.getStars();
        this.rooms = outroHotel.getRooms();
        this.price = outroHotel.getPrice();
    }
    
    public String getCode(){
        return this.code;
    }
    
    public void setCode(String newCode){
        this.code = newCode;
    }
    
    public String getName(){
        return this.name;
    }
    
    public void setName(String newName){
        this.name = newName;
    }
    
    public String getAdress(){
        return this.adress;
    }
    
    public void setAdress(String newAdress){
        this.adress = newAdress;
    }
    
    public int getStars(){
        return this.stars;
    }
    
    public void setStars(int newStars){
        this.stars = newStars;
    }
    
    public int getRooms(){
        return this.rooms;
    }
    
    public void setRooms(int newRooms){
        this.rooms = newRooms;
    }
    
    public double getPrice(){
        return this.price;
    }
    
    public void setPrice(double newPrice){
        this.price = newPrice;
    }
    
    /**
     * Clone do Hotel
     */
    public abstract Hotel clone();
    
    /**
     * Verifica se um hotel e igual
     */
    public boolean equals(Object o){
        if (o == this) return true;
        if ((o == null) || (o.getClass() != this.getClass())) return false;
        
        Hotel hotel = (Hotel) o;
        
        return this.code.equals(hotel.getCode()) && this.name.equals(hotel.getName())
                && this.adress.equals(hotel.getAdress()) && this.stars == hotel.getStars()
                && this.rooms == hotel.getRooms() && this.price == hotel.getPrice();
    }
    
    /**
     * Mete tudo em forma de string
     */
    
    public String toString(){
        StringBuilder sb = new StringBuilder();
        
        sb.append("Codigo: "); sb.append(this.code); sb.append("\n");
        sb.append("Nome: "); sb.append(this.name); sb.append("\n");
        sb.append("Localidade: "); sb.append(this.adress); sb.append("\n");
        sb.append("Estrelas: "); sb.append(this.stars); sb.append("\n");
        sb.append("Quartos: "); sb.append(this.rooms); sb.append("\n");
        sb.append("Preço: "); sb.append(this.price); sb.append("\n");
        
        return sb.toString();
    }
    
    public int hashCode(){
        return code.hashCode();
    }
    
    public int compareTo(Hotel hotel){
        return hotel.getName().compareTo(this.name);
    }
    
    public abstract double precoNoite();
}
