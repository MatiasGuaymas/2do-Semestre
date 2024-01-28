package FinalSep2022;

public class SubEstadia extends Subsidio{
    private String destino;
    private double costoPasajes;
    private int cantDias;
    private double montoDia;

    public SubEstadia(String nom, String p, Fecha fec, String des, double cosPas, int cant, double monDia) {
        super(nom, p, fec);
        this.destino = des;
        this.costoPasajes = cosPas;
        this.cantDias = cant;
        this.montoDia = monDia;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public double getCostoPasajes() {
        return costoPasajes;
    }

    public void setCostoPasajes(double costoPasajes) {
        this.costoPasajes = costoPasajes;
    }

    public int getCantDias() {
        return cantDias;
    }

    public void setCantDias(int cantDias) {
        this.cantDias = cantDias;
    }

    public double getMontoDia() {
        return montoDia;
    }

    public void setMontoDia(double montoDia) {
        this.montoDia = montoDia;
    }
    
    @Override
    public double montoSubsidio() {
        double aux = 0.0;
        aux = this.costoPasajes + (this.cantDias * this.montoDia);
        return aux;
    }
    
    @Override
    public String toString() {
        String aux = super.toString();
        aux+= " Destino=" + this.destino + " Dias=" + this.cantDias;
        return aux;
    }
}
