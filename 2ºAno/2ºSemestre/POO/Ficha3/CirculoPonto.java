import Ponto;
/**
 * Escreva a descrição da classe CirculoPonto aqui.
 * 
 * @author (seu nome) 
 * @version (número de versão ou data)
 */
public class CirculoPonto
{
     private Ponto ponto;
     private double raio;

    /*Definir construtores:*/
    public CirculoPonto(){
        this.ponto = new Ponto();
        this.raio = 0;
    }


    public CirculoPonto(Ponto ponto, double raio){
        this.ponto = new Ponto(x,y);
        this.raio = raio;
    }

    //Construtor de cópia
    public CirculoPonto (Circulo outroCirculo){
        this.ponto = outroCirculo.getPonto();
        this.raio = outroCirculo.getRaio();
    }

    //os getters têm de ser definidos para o construtor cópia funcionar.
    public double getPonto(){
        return this.ponto;
    }

    public double getRaio(){
        return this.raio;
    }
    
    public void setPonto(Ponto ponto){
        this.ponto = ponto.clone();
    }
    
    
    public void setRaio(double raio){
        this.raio = raio;
    }
    
    public void alteraCentro (int x, int y){
        //this.ponto.deslocamento(x,y);
        this.ponto = new Ponto(x,y);
    }
    
    
    //======================================Metodos==========================================================================
    
    public double calculaArea(){
        return Math.PI*Math.pow(this.raio,2);
    }
    
    public double calculaPerimetro(){
        return 2*Math.PI*this.raio;
    }
    
    //criar um circulo clone
    public CirculoPonto clone(){
        return new Circulo(this);
    }
    
    //criar metodo igual
    public boolean equals(Object o){
        if (this == o) return true;
        
        if ((o==null) || (this.getClass() != o.getClass())) return false;
        
        Circulo c = (Circulo) o; //faz-se um cast ao objeto para ficar de classe igual para poder comparar
        return this.p.equals(c.getPonto())  && this.raio == c.getRaio();
        
        
}
