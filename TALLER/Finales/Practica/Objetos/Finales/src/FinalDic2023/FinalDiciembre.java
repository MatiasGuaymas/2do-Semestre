package FinalDic2023;

public class FinalDiciembre {
    public static void main(String[] args) {
        Agencia agen = new Agencia();
        
        Partido part1 = new Partido("Boca", "River", 200.0, 100.0, 200.0);
        Partido part2 = new Partido("Racing", "River", 150.0, 50.0, 100.0);
        Partido part3 = new Partido("Boca", "Racing", 100.0, 50.0, 200.0);
        Partido part4 = new Partido("Velez", "Colon", 100.0, 125.0, 200.0);
        
        System.out.println(agen.agregarPartido(part1));
        System.out.println(agen.agregarPartido(part2));
        System.out.println(agen.agregarPartido(part3));
        System.out.println(agen.agregarPartido(part4));
        
        Apuesta apu1 = new Apuesta("Matias", 111, 1, "victoria local", 200.0);
        Apuesta apu2 = new Apuesta("Juan", 222, 1, "empate", 100.0);
        Apuesta apu3 = new Apuesta("Pepe", 333, 2, "victoria visitante", 300.0);
        Apuesta apu4 = new Apuesta("Matias", 111, 3, "empate", 500.0);
        Apuesta apu5 = new Apuesta("Juan", 222, 4, "victoria local", 100.0);
        Apuesta apu6 = new Apuesta("Josias", 444, 4, "victoria local", 200.0);
        
        agen.agregarApuesta(apu1);
        agen.agregarApuesta(apu2);
        agen.agregarApuesta(apu3);
        agen.agregarApuesta(apu4);
        agen.agregarApuesta(apu5);
        agen.agregarApuesta(apu6);
        
        agen.ingresarResultado(1, "Victoria local");
        agen.ingresarResultado(2, "victoria visitante");
        agen.ingresarResultado(3, "Empate");
        agen.ingresarResultado(4, "victoria local");
        
        System.out.println(agen.cerrarApuestas());
        agen.limpiarApuestas();
        System.out.println(agen.cerrarApuestas());
    }
    
}
