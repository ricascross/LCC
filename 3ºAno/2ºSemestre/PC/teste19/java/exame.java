import java.util.Random;
import java.util.concurrent.*;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.time.format.*;

interface Jogo {
    Partida participa();
}

interface Partida {
    String adivinha(int n);
}


class JogoImple implements Jogo {
    //cria uma partida e envia os jogadores para la, chegadndo a 4 a partida inicia 
    //e crio uma nova partida para os jogadores que ainda vao chegar e direciono para la

    Lock lock = new ReentrantLock();

    PartidaImple[] partidas;
    int index = 0;

    Jogo() {
        partidas = new Partida();

    }

    public Partida participa() {
        return partidas[index++];
    }



}

class PartidaImple implements Partida {
    // vai recebendo jogadores até 4 e inicia o contador de tempo e decide o random a determinar
    
    Lock lock = new ReentrantLock();
    Condition notEmpty = lock.newCondition();
    Condition notFull = lock.newCondition();

    private int jogadores = 0;
    private int[] jog;
    private int tempo;
    private int valor;

    private class Jogador {
        Jogador() {
            int tent = 0;
        }
    }

    public PartidaImple() {
        valor = Math.floor(Math.random()*100);
        tempo = 0;

        
        private String adivinha(int n) {
            switch(n) {
                case (n > valor) : return "adivinha é maior"; break;
                case (n < valor) : return "adivinha é menor"; break;
                default:
                    //sinaliza outros que ganhou
                    return "Ganhou";
            }
        }




    }




}
