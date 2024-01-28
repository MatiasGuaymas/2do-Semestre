package FinalSep2023;

public class SistAnual extends Sistema {
    
    public SistAnual(int cantAnios, Estacion estacion) {
        super(cantAnios, estacion);
    }
    
    @Override
    public String retornarMedia() {
        String aux = "";
        double total;
        for(int i=0;i<this.getCantAnios();i++){
            total = 0.0;
            for(int j=0;j<12;j++){
                total += getTemp(j+1, i+this.getAnioInicial());
            }
            aux += "Anio "+(i+this.getAnioInicial())+": "+Math.round((total/12)*100.0)/100.0+"°C \n";
        }
        return aux;
    }    
    
}