package FinalSep2022;

public class Bien {
    private String descripcion;
    private int cant;
    private double costoUnidad;
    
    public Bien(String d, int c, double cos) {
        this.descripcion = d;
        this.cant = c;
        this.costoUnidad = cos;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getCant() {
        return cant;
    }

    public void setCant(int cant) {
        this.cant = cant;
    }

    public double getCostoUnidad() {
        return costoUnidad;
    }

    public void setCostoUnidad(double costoUnidad) {
        this.costoUnidad = costoUnidad;
    }
    
    public double calcularBien() {
        double aux= 0.0;
        aux= this.cant * this.costoUnidad;
        return aux;
    }
}
