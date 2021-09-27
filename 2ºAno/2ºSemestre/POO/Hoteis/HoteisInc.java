
import Exceptions.HotelJaExiste;
import Exceptions.NaoExisteHotel;

import java.util.Map;
import java.util.HashMap;
import java.util.stream.Stream;
import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;
import java.util.Set;
import java.util.Comparator;
import java.util.TreeSet;
import java.util.Iterator;
public class HoteisInc
{
    /**
     * Compara cada hotel por nome
     */
    public static Map<String, Comparator<Hotel>> comparadores = new HashMap<>();
    
    public static void juntaOrdenacao(String name, Comparator<Hotel> ordem) {comparadores.put(name,ordem);}
    
    public static Comparator<Hotel> getOrdem(String name){return comparadores.get(name);}
    /**
     * Nome da companhia de hoteis
     */
    private String name;
    /**
     * Mapeamente por codigo de hotel para hotel
     */
    private Map<String, Hotel> hoteis;
    
    /**
     * Contrutor por omissao
     */
    public HoteisInc(){
        this.hoteis = new HashMap<String,Hotel>();
        this.name = "HoteisInc";
    }
    
    /**
     * Contrutor por copia
    */
    public HoteisInc(HoteisInc outrosHoteis){
        this.hoteis = outrosHoteis.getHoteis();
        this.name = outrosHoteis.getName();
    }
    
    /**
     * Construtor Parametrizado
     * @param hoteis
     * @param nome
     */
    public HoteisInc(Map<String, Hotel> novoHotel, String newName){
        this.name = newName;
        this.hoteis = new HashMap<String,Hotel>();
        setHoteis(hoteis);
    }
    
    /**
     * Devolve o nome da companhia de hoteis
     * 
     * @return String
     */
    public String getName(){
        return this.name;
    }
    
    /**
     * Insere um novo nome da companhia de hoteis
     * @param hoteis
     */
    public void setName(String newName){
        this.name = newName;
    }
    
    /**
     * Obter uma copia do mapeamento de hoteis
     * @return Map
     */
    private Map<String,Hotel> getHoteis(){
        return this.hoteis.entrySet()
                          .stream()
                          .collect(Collectors.toMap(h -> h.getKey(), h -> h.getValue().clone()));
    }
    
    /**
     * Definir os hoteis
     * @param hoteis
     */
    private void setHoteis(Map<String,Hotel> hoteis){
        this.hoteis.entrySet()
                   .stream()
                   .collect(Collectors.toMap(h -> h.getKey(), h -> h.getValue().clone()));
    }
    /**
     * Devolve uma copia da companhia de hoteis
     * @return HoteisInc
     */
    public HoteisInc clone(){
        return new HoteisInc(this);
    }
    
    /**
     * Verifica a igualdade com outro objeto
     * @return boolean
     */
    public boolean equals(Object obj){
        if (this == obj) return true;
        if ((obj == null) || (this.getClass() != obj.getClass())) return false;
        
        HoteisInc hoteis = (HoteisInc) obj;
        return hoteis.getName().equals(this.name) && hoteis.getHoteis().equals(this.hoteis);
    }
    
    /**
     * Formata tudo para representacao textual
     * @return String
     */
    public String toString(){
        StringBuilder sb = new StringBuilder();
        
        sb.append("Nome da cadeia de Hoteis: ");sb.append(this.name);
        sb.append("\n");
        sb.append("Hoteis: ");
        for (Hotel hotel : this.hoteis.values()){
            sb.append(hotel.toString());
        }
        return sb.toString();
    }
    
    /**
     * Insere um novo hotel
     * @param hoteis
     */
    public void insereHotel(Hotel hotel) throws HotelJaExiste {
        if (this.hoteis.containsKey(hotel.getCode())) 
            throw new HotelJaExiste("Erro: Ja existe hotel. Codigo do Hotel: " + hotel.getCode());
        else
            this.hoteis.put(hotel.getCode(), hotel.clone());
    }
    
    /**
     * Verifica se existe um hotel segundo um codigo fornecido
     * @return boolean 
     */
    public boolean existeHotel(String code){
        return this.hoteis.containsKey(code);
    }
    
    /**
     * Devolve quantos hoteis estao inseridos
     * 
     * @return int 
     */
    public int quantos(){
        return this.hoteis.size();
    }
    
    /**
     * Devolve o numero de hoteis de uma dada localidade
     * @return int
     */
    public int quantosHoteis(String local){
        return (int) this.hoteis.values()
                                .stream()
                                .filter(hotel -> hotel.getAdress().equals(local))
                                .count();
    }
    
    /**
     * Devolve o hotel segundo um determinado codigo
     * @return Hotel
     */
    public Hotel getHotel(String code) throws NaoExisteHotel{
        if (!this.hoteis.containsKey(code)) 
            throw new NaoExisteHotel("Erro: Nao existe hotel com este codigo: "+ code);
        return (Hotel) this.hoteis.values()
                                  .stream()
                                  .map(Hotel::clone)
                                  .filter(hotel -> hotel.getCode().equals(code));
    }
    
    /**
     * Devolver uma lista que contem a copia de todos os hoteis do sistema
     * @return List<Hotel>
     */
    public List<Hotel> getHoteisList(){
        return this.hoteis.values()
                          .stream()
                          .map(Hotel::clone)
                          .collect(Collectors.toList());
    }
    
    public void adiciona(Set<Hotel> hs) {
        for(Hotel h : hs) {
            hs.add(h);
        }
    }
    
    /**
     * Muda para epoca alta ou para epoca baixa e muda o preco do quarto.
     * Epoca alta aumenta 20 euros, epoca baixa diminui 20 euros.
     */
    public void mudaEpoca(String epoca){
        for(Hotel h : this.hoteis.values()){
            if (h instanceof HotelStandard){
                HotelStandard hotel = (HotelStandard) h;
                if(epoca.equals("alta")){
                    hotel.setEpoca(true);
                }
                else{
                    hotel.setEpoca(false);
                }
            }
        }
    }
    
    /**
     * Calcula o valor total diario recebido pela cadeia
     * @return total
     */
    public long valorTotalDiario(){
        long total = 0;
        for (Hotel hotel : this.hoteis.values()){
            total += hotel.getRooms() * hotel.getPrice();
        }
        return total;
    }
    
    /**
     * Ordena os hoteis usando o TreeSet.
     * @return ordHoteis
     */
    public TreeSet<Hotel> ordenarHoteis(){
        TreeSet<Hotel> ordHoteis = new TreeSet<Hotel>();
        this.hoteis.values().forEach(h -> {ordHoteis.add(h.clone());});
        return ordHoteis;
    }
    
    /**
     * Ordena os hoteis usando o TreeSet atraves de um comparator
     */
    public TreeSet<Hotel> ordenarHoteis(Comparator<Hotel> comparador){
        TreeSet<Hotel> ordHoteis = new TreeSet<Hotel>(comparador);
        this.hoteis.values().forEach(h -> {ordHoteis.add(h.clone());});
        return ordHoteis;
    }
    
    /**
     * Ordena os hoteis usando Listas
     */
    public List<Hotel> ordenarHoteisLista(Comparator<Hotel> comparador){
        List<Hotel> ordHoteis = new ArrayList<Hotel>();
        ordHoteis = this.hoteis.values().stream()
                                        .map(Hotel::clone)
                                        .collect(Collectors.toList());
        ordHoteis.sort(comparador);                                
        return ordHoteis;                                
        
    }
    
    public Iterator<Hotel> ordenarHoteis(String criterio){
        TreeSet<Hotel> r = ordenarHoteis(getOrdem(criterio));
        return r.iterator();
    }
    
    
}
