
/**
 * Escreva a descrição da classe Lampada aqui.
 * 
 * @author (seu nome) 
 * @version (número de versão ou data)
 */
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
public class Lampada
{
    private static final int off = 0, eco = 1, on = 2; 
    
    private int estado;
    private double consumoON, consumoECO;
    private LocalDateTime lastReset;
    private double totalConsumo;
    /**
    *Construtores
    */
    public Lampada()
    {
        this.estado = off;
        this.consumoON = 0;
        this.consumoECO = 0;
        this.lastReset = LocalDateTime.now();
        this.totalConsumo = 0;
    }
    
    public Lampada(double consumoOn, double consumoEco)
    {
        this.estado = off;
        this.consumoON = consumoOn;
        this.consumoECO = consumoEco;
        this.lastReset = LocalDateTime.now();
        this.totalConsumo = 0;
    }
    
    public Lampada(Lampada outraLampada)
    {
        this.estado = outraLampada.getEstado();
        this.consumoON = outraLampada.getConsumoON();
        this.consumoECO = outraLampada.getConsumoECO();
        this.totalConsumo = outraLampada.getTotalConsumo();
    }
    
    /**
    * Getters and Setters
    */
   
    public int getEstado()
    {
        return this.estado;
    }
    
    public double getConsumoON()
    {
        return this.consumoON;
    }
    
    public double getConsumoECO()
    {
        return this.consumoECO;
    }
    
    public double getTotalConsumo()
    {
        return this.totalConsumo;
    }
    
    public void setEstado(int estado)
    {
        this.estado = estado;
    }
    
    public void setConsumoON(double consumoOn)
    {
        this.consumoON = consumoOn;
    }
    
    public void setConsumoECO(double consumoEco)
    {
        this.consumoECO = consumoEco;
    }
    
    public void setTotalConsumo(double totalConsumo)
    {
        this.totalConsumo = totalConsumo;
    }
    
    /**
     * Metodos 
     */
    public void LampON()
    {
        totalConsumo += this.periodoConsumo();
        lastReset = LocalDateTime.now();
        estado = on;
    }
    
    public void LampOFF()
    {
        totalConsumo += this.periodoConsumo();
        lastReset = LocalDateTime.now();
        estado = off;
    }
    
    public void LampECO()
    {
        totalConsumo += this.periodoConsumo();
        lastReset = LocalDateTime.now();
        estado = eco;
    }
    
    public double totalConsumo()
    {
        return this.totalConsumo + this.periodoConsumo();
    }
    
    
    public double periodoConsumo()
    {
        if(this.estado == off) return 0;
        
        double consumo = this.estado==on?this.consumoON:this.consumoECO;
        
        long ms = lastReset.until(LocalDateTime.now(), ChronoUnit.MILLIS);
        
        return consumo*ms;
    }
}
