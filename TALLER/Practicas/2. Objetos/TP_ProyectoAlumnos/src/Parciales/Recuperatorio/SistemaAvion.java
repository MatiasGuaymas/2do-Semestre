package Parciales.Recuperatorio;

public class SistemaAvion extends Sistema {
    private int i;
    public SistemaAvion(int cant) {
        super(cant);
    }
    
    @Override
    public void otorgarSubsidio(double x) {
        for(i=0; i<this.getCantSolicitudes(); i++) {
            if(this.getSolicitudes()[i].montoAvion() < x) {
                this.getSolicitudes()[i].setOtorgado();
            }
        }
    }
}
