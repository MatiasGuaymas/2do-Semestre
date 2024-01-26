package Parciales.Recuperatorio;

public class SistemaEstadia extends Sistema{
    private int i;
    public SistemaEstadia(int cant) {
        super(cant);
    }
    
    @Override
    public void otorgarSubsidio(double x) {
        for(i=0; i<this.getCantSolicitudes(); i++) {
            if(this.getSolicitudes()[i].montoEstadia() < x) {
                this.getSolicitudes()[i].setOtorgado();
            }
        }
    }
}
