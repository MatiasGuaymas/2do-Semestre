package FinalSep2023;

public class SistMensual extends Sistema {
    private String[] meses = new String[]{"Enero", "Febrero", "Marzo",
        "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre",
        "Octubre", "Noviembre", "Diciembre"};
    
    public SistMensual(int cantAnios, Estacion estacion) {
        super(cantAnios, estacion);
    }
    
    @Override
    public String retornarMedia() {
        String aux = "";
        double total;
        for (int j=0;j<12;j++){
            total = 0.0;
            for(int i=0;i<this.getCantAnios();i++){
                total += getTemp(j+1, i+this.getAnioInicial());         
            }
            aux += meses[j]+": "+Math.round((total/this.getCantAnios())*100.0)/100.0+"°C \n";
        }
        return aux;
    }
    
}