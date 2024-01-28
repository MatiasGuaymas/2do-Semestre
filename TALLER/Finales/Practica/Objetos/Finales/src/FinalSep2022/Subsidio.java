package FinalSep2022;

public abstract class Subsidio {
    private String nombre;
    private String plan;
    private Fecha fecha;
    public Subsidio(String nom, String p, Fecha fec) {
        this.nombre = nom;
        this.plan = p;
        this.fecha = fec;
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

    public Fecha getFecha() {
        return fecha;
    }

    public void setFecha(Fecha fecha) {
        this.fecha = fecha;
    }
    
    public abstract double montoSubsidio();
    
    @Override
    public String toString() {
        String aux = "";
        aux = "Investigador=" + this.nombre + " Plan=" + this.plan + " Fecha:" + this.fecha.toString() + " Monto=" + Math.round(this.montoSubsidio()*100.0)/100.0;
        return aux;
    }
}
