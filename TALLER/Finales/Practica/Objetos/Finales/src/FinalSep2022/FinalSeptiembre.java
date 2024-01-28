package FinalSep2022;

public class FinalSeptiembre {
    public static void main(String[] args) {
        Fecha fec1 = new Fecha(1, 7, 2005);
        SubEstadia subEst = new SubEstadia("Matias", "Prepago", fec1, "Bariloche", 400.0, 10, 200.0);
        Fecha fec2 = new Fecha(9, 2, 2002);
        SubBienes subBienes = new SubBienes("Lucio", "Pagado", fec2, 5);
        
        Bien bien1 = new Bien("Bien 1", 10, 250.0);
        Bien bien2 = new Bien("Bien 2", 30, 100.0);
        Bien bien3 = new Bien("Bien 3", 5, 50.0);
        subBienes.agregarBien(bien1);
        subBienes.agregarBien(bien2);
        subBienes.agregarBien(bien3);
        
        System.out.println(subEst.toString());
        System.out.println(subBienes.toString());
    }
    
}
