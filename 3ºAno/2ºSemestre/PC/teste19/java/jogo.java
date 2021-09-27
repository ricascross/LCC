import java.lang.Thread;



interface Jogo {
    Partida participa();
}

interface Partida {
    String adivinha(int n);
}


class PartidaImpl implements Partida {
    public int count = 0;
    private boolean ganhou = false;
    private int tentativas = 0;
    private boolean timeout = false;
    private int numero;


    PartidaImpl() {
        numero = 55;
    }

    private synchronized void timeout() {
        timeout = true;
    }

    public synchronized String adivinha(int n) {
        tentativas +=1;

        if (ganhou) return "PERDEU";
        if (timeout) return "TEMPO";
        if (tentativas>100) return "TENTATIVAS";
        if (n == numero) {
            ganhou = true;
            return "GANHOU";
        }
        if (numero > n) return "MAIOR";
        return "MENOR";
    }

    public void start() {
        new Thread (() -> {
            try {
                Thread.sleep(60000);
                timeout();
            } catch (Exception e) { }
        }).start();
    }


}




class JogoImpl implements Jogo {

    public PartidaImpl partida = new PartidaImpl();

    public synchronized Partida participa() {
        PartidaImpl p = partida;
        p.count +=1;

        try{
            if (p.count == 1) {
                p.start();
                partida = new PartidaImpl();
                notify();
            }
            else {
                while (p.count < 1) {
                    wait();
                }
            }
            
        } 
        catch (Exception e) {}
        return p;
    }


}


class Jogador {
    public static void main(String[] args) {
        PartidaImpl jogada = new PartidaImpl();


        System.out.println(jogada.adivinha(33));
        System.out.println(jogada.adivinha(43));
        System.out.println(jogada.adivinha(56));
        System.out.println(jogada.adivinha(55));

    }

}