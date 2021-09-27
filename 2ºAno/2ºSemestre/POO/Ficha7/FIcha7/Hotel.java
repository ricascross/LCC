
/**
 * Write a description of class Hotel here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class Hotel{
    /**
     * variaveis de instancia
     */
    private String identificationCode;
    private String name;
    private String adress;
    private int numberOfStars;
    private int numberOfAvailableRooms;
    private double priceOfRooms;
    
    /**
     * Construtores
     */
    public Hotel() {
        this.identificationCode = "";
        this.name = "";
        this.adress = "";
        this.numberOfStars = 1;
        this.numberOfAvailableRooms = 1;
        this.priceOfRooms = 1.0;
    }
    
    public Hotel(String id, String name, String adress, int stars, int availRooms, double price){
        this.identificationCode = id;
        this.name = name;
        this.adress = adress;
        this.numberOfStars = stars;
        this.numberOfAvailableRooms = availRooms;
        this.priceOfRooms = price;
    }
    
    public Hotel(Hotel outroHotel){
        this.identificationCode = outroHotel.getId();
        this.name = outroHotel.getName();
        this.adress = outroHotel.getAdress();
        this.numberOfStars = outroHotel.getStars();
        this.numberOfAvailableRooms = outroHotel.getRooms();
        this.priceOfRooms = outroHotel.getPrice();
    }
    
    /**
     * Getters and Setters
     */
    
    public String getId(){
        return this.identificationCode;
    }
    
    public String getName(){
        return this.name;
    }
    
    public String getAdress(){
        return this.adress;
    }
    
    public int getStars(){
        return this.numberOfStars;
    }
    
    public int getRooms(){
        return this.numberOfAvailableRooms;
    }
    
    public double getPrice(){
        return this.priceOfRooms;
    }
    
    public void setId(String id){
        this.identificationCode = id;
    }
    
    public void setName(String name){
        this.name = name;
    }
    
    public void setAdress(String adress){
        this.adress = adress;
    }
    
    public void setStars(int stars){
        this.numberOfStars = stars;
    }
    
    public void setRooms(int rooms){
        this.numberOfAvailableRooms = rooms;
    }
    
    public void setPrice(double price){
        this.priceOfRooms = price;
    }
    
    /**
     * Metodos
     */
    
    public boolean equals(Object obj){
        if (this == obj) return true;
        if ((obj == null) || (this.getClass() != obj.getClass())) return false;
        
        Hotel umHotel = (Hotel) obj;
        return (this.identificationCode.equals(umHotel.getId()) && this.name.equals(umHotel.getName())
                && this.adress.equals(umHotel.getAdress()) && this.numberOfStars == umHotel.getStars()
                && this.numberOfAvailableRooms == umHotel.getRooms() && this.priceOfRooms == umHotel.getPrice());
       
    }
    
    public String toString(){
        StringBuilder sb = new StringBuilder();
        
        sb.append("Identification Code: "); sb.append(this.identificationCode+"\n");
        sb.append("Name: "); sb.append(this.name+"\n");
        sb.append("Adress: "); sb.append(this.adress+"\n");
        sb.append("Stars: "); sb.append(this.numberOfStars+"\n");
        sb.append("Available Rooms: "); sb.append(this.numberOfAvailableRooms+"\n");
        sb.append("Rooms price: "); sb.append(this.priceOfRooms+"\n");
        
        return sb.toString();
    }
    
    public Hotel clone(){
        return new Hotel(this);
    }
    
    public int hashCode(){
        return identificationCode.hashCode();
    }
    
}
