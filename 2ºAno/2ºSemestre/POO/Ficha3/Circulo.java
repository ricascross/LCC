
/**
 * Escreva a descrição da classe Circulo aqui.
 * 
 * @author (seu nome) 
 * @version (número de versão ou data)
 */
public class Circulo
{
    private double x, y, raio;

    /*Definir construtores:*/
    public Circulo(){
        this.x = this.y = this.raio = 0;
    }


    public Circulo(double x, double y, double raio){
        this.x = x;
        this.y = y;
        this.raio = raio;
    }

    //Construtor de cópia
    public Circulo (Circulo outroCirculo){
        this.x = outroCirculo.getX();
        this.y = outroCirculo.getY();
        this.raio = outroCirculo.getRaio();
    }

    //os getters têm de ser definidos para o construtor cópia funcionar.
    public double getX(){
        return this.x;
    }

    public double getY(){
        return this.y;
    }

    public double getRaio(){
        return this.raio;
    }
    
    public void setX(double x){
        this.x = x;
    }
    
    public void setY(double y){
        this.y = y;
    }
    
    public void setRaio(double raio){
        this.raio = raio;
    }
    
    public void alteraCentro (double x, double y){
        this.x = x;
        this.y = y;
    }
    
    
    //======================================Metodos==========================================================================
    
    public double calculaArea(){
        return Math.PI*Math.pow(this.raio,2);
    }
    
    public double calculaPerimetro(){
        return 2*Math.PI*this.raio;
    }
    
    //criar um circulo clone
    public Circulo clone(){
        return new Circulo(this);
    }
    
    //criar metodo igual
    public boolean equals(Object o){
        if (this == o) return true;
        
        if ((o==null) || (this.getClass() != o.getClass())) return false;
        
        Circulo c = (Circulo) o; //faz-se um cast ao objeto para ficar de classe igual para poder comparar
        return this.x == c.getX() && this.y == c.getY() && this.raio == c.getRaio();
        
        
    }
    
    
}
