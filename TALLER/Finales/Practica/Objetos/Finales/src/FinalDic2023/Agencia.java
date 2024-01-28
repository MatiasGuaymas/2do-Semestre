package FinalDic2023;

public class Agencia {
    private int dimFPart;
    private int dimFApu;
    private int ultimo_id;
    private int dimL;
    private Partido[] vecPartidos;
    private Apuesta[] vecApuestas;
    private int i, j;
    
    public Agencia() {
        //this.dimFPart = 20;
        //this.dimFApu = 100;
        this.dimFPart = 4;
        this.dimFApu = 6;
        this.ultimo_id = 0;
        this.dimL = 0;
        this.vecPartidos = new Partido[dimFPart];
        this.vecApuestas = new Apuesta[dimFApu];
    }

    public int getDimFPart() {
        return dimFPart;
    }

    public int getDimFApu() {
        return dimFApu;
    }

    public int getUltimo_id() {
        return ultimo_id;
    }

    public int getDimL() {
        return dimL;
    }
    
    public Partido getPartido(int id){
        if((id > 0) && (id <= ultimo_id)) {
            return vecPartidos[id-1];
        } else return null;
    }
    
    public int agregarPartido(Partido p) {
        if(ultimo_id < dimFPart) {
            this.vecPartidos[ultimo_id++] = p;
            return ultimo_id;
        }
        else return -1;
    }
    
    public void agregarApuesta(Apuesta a) {
        if(dimL < dimFApu) {
            this.vecApuestas[dimL++] = a;
        }
    }
    
    public void ingresarResultado(int id, String resultado) {
        if ((id > 0) && (id <= ultimo_id)) {
            this.vecPartidos[id-1].setResultado(resultado.toLowerCase());
        }   
    }
    
    public String cerrarApuestas(){
        String aux = "Apuestas acertadas: " + "\n";
        for(i=0; i<ultimo_id; i++) {
            aux+= (i+1) + ". ";
            for(j=0; j<dimL; j++) {
                if((i+1) == vecApuestas[j].getId()) {
                    if(vecPartidos[i].getResultado().equals(vecApuestas[j].getApuesta())) {
                        aux+= vecApuestas[j].toString() + Math.round(vecApuestas[j].getMonto() * vecPartidos[i].getMonto())*100.0/100.0 + " | ";
                    }
                }
            }
            aux+= "\n";
        }
        return aux;
    }
    
    public void limpiarApuestas() {
        this.ultimo_id = 0;
        this.dimL = 0;
    }
}
