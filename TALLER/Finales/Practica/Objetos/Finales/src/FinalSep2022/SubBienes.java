package FinalSep2022;

public class SubBienes extends Subsidio{
    private Bien[] vecBienes;
    private int dimF;
    private int dimL = 0;
    private int i;
    public SubBienes(String nom, String p, Fecha fec, int cantMax) {
        super(nom, p, fec);
        this.dimF = cantMax;
        this.vecBienes = new Bien[this.dimF];
        this.inicializarVector();
    }
    private void inicializarVector() {
        for(i=0; i<this.dimF; i++) {
            this.vecBienes[i] = null;
        }
    }

    private Bien[] getVecBienes() {
        return vecBienes;
    }

    private void setVecBienes(Bien[] vecBienes) {
        this.vecBienes = vecBienes;
    }

    public int getDimF() {
        return dimF;
    }

    private void setDimF(int dimF) {
        this.dimF = dimF;
    }

    public int getDimL() {
        return dimL;
    }

    private void setDimL(int dimL) {
        this.dimL = dimL;
    }
    
    public void agregarBien(Bien b) {
        if(dimL < dimF) {
            this.vecBienes[dimL++] = b;
        }
    }
    
    @Override
    public double montoSubsidio() {
        double aux = 0.0;
        for(i=0; i<dimL;i++) {
            aux+= this.vecBienes[i].calcularBien();
        }
        return aux;
    }
    
    @Override
    public String toString() {
        String aux = super.toString() + "\n";
        for(i=0; i<dimL;i++) {
            aux+= (i+1) + ". Descripcion=" + this.vecBienes[i].getDescripcion() + "\n";
        }
        return aux;
    }
}
