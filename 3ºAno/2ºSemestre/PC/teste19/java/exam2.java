import java.lang.Thread;
import java.util.Random;
import java.lang.Math;

interface Jogo {
    Partida participa();
}
interface Partida {
    String adivinha(int n);
}



class PartidaImple implements Partida {
    int count =0;
    boolean ganhou = false;
    int tentativas = 0;
    boolean timeout = false;
    long numero;

    PartidaImple() {
        //numero = new Random.nextInt(100);
        //numero = new Random.nextInt();
        numero = Math.round((Math.random()*100));
    }

    synchronized void timeout() {
        timeout = true;

    }

    public synchronized String adivinha(int n) {
        tentativas+=1;
        if(ganhou) return "PERDEU";
        if(timeout) return "TEMPO";
        if(tentativas>100) return "TENTATIVAS";
        if(n == numero) {
            ganhou = true;
            return "GANHOU";
        }
        if (numero > n) return "MAIOR";
        return "MENOR";
    }


    void start() {
        new Thread (() -> {
            try{
                Thread.sleep(60000);
                timeout();
            }catch(Exception e) { }
        }).start();
    }


}

class JogoImple implements Jogo {
    
    private PartidaImple partida = new PartidaImple();
    
    public synchronized Partida participa(){
        PartidaImple p = partida;
        p.count+=1;
        if(p.count ==4) {
            p.start();
            partida = new PartidaImple();
            notifyAll();
        }
        else {
            while (p.count<4){
                wait();
            }
        }
        return p;
    }
}