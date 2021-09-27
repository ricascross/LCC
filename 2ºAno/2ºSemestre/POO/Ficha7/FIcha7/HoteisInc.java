
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Stream;
import java.util.stream.Collectors;
public class HoteisInc
{
    private Map<String, Hotel> hoteis;
    
    public HoteisInc(){
        this.hoteis = new HashMap <String,Hotel>();
    }
    
    public HoteisInc(Map<String,Hotel> hoteis){
        this.hoteis = hoteis.values().stream().collect(Collectors.toMap(hotel -> hotel.getId(),hotel -> hotel.clone()));
    }
    
    public boolean existeHotel(String cod){
        for (Hotel hotel)
    }
}
