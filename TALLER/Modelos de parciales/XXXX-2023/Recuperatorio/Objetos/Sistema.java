package Parciales.Recuperatorio;

public abstract class Sistema {
   private Solicitud [] solicitudes;
   private int cantMax;
   private int cantSolicitudes = 0;
   private int i;
   
    public Sistema(int cant) {
        this.cantMax = cant;
        this.solicitudes = new Solicitud[cantMax];
        for(i = 0; i <  cantMax; i++) {
            this.solicitudes[i] = null;
        }
    }

    public Solicitud[] getSolicitudes() {
        return solicitudes;
    }
    
    public int getCantMax() {
        return cantMax;
    }

    public int getCantSolicitudes() {
        return cantSolicitudes;
    }
   
    public void agregarSolicitud(Solicitud s) {
        this.solicitudes[cantSolicitudes++] = s;
    }
    
    public Solicitud obtenerSolicitud(int i) {
        return this.solicitudes[i];
    }
    
    public abstract void otorgarSubsidio(double x);
    
   @Override
    public String toString() {
        String aux = "Subsidios otorgados:" + "\n";
        for(i=0; i<cantSolicitudes; i++) {
            if(this.solicitudes[i].isOtorgado()) {
                aux+= (i+1) + ". " + this.solicitudes[i].toString() + "\n";
            }
        }
        return aux;
    }
}
