package Parciales.Recuperatorio;

public class Solicitud {
    private String nombre;
    private String plan;
    private String destino;
    private double ida;
    private double vuelta;
    private double tasa;
    private int cantDias;
    private double montoHotel;
    private boolean otorgado;
    
    public Solicitud(String nombre, String plan, String destino, double ida, double vuelta, double tasa, int cant, double monto) {
        this.nombre = nombre;
        this.plan = plan;
        this.destino = destino;
        this.ida = ida;
        this.vuelta = vuelta;
        this.tasa = tasa;
        this.cantDias = cant;
        this.montoHotel = monto;
        this.otorgado = false;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPlan() {
        return plan;
    }

    public void setPlan(String plan) {
        this.plan = plan;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public double getIda() {
        return ida;
    }

    public void setIda(double ida) {
        this.ida = ida;
    }

    public double getVuelta() {
        return vuelta;
    }

    public void setVuelta(double vuelta) {
        this.vuelta = vuelta;
    }

    public double getTasa() {
        return tasa;
    }

    public void setTasa(double tasa) {
        this.tasa = tasa;
    }

    public int getCantDias() {
        return cantDias;
    }

    public void setCantDias(int cantDias) {
        this.cantDias = cantDias;
    }

    public double getMontoHotel() {
        return montoHotel;
    }

    public void setMontoHotel(double montoHotel) {
        this.montoHotel = montoHotel;
    }

    public boolean isOtorgado() {
        return otorgado;
    }

    public void setOtorgado() {
        this.otorgado = true;
    }
    
    public double montoAvion(){
        return (this.ida+this.vuelta+this.tasa);
    }
    
    public double montoEstadia(){
        return (this.cantDias * this.montoHotel);
    }
    
    @Override
    public String toString() {
        return "Nombre=" + this.nombre + " Plan=" + this.plan + " Destino=" + this.destino;
    }
}
