package FinalSep2023;

import PaqueteLectura.*;

public class FinalSeptiembre {
    public static void main(String[] args) {
        GeneradorAleatorio.iniciar();
        int i, j;
        Estacion est1 = new Estacion("La Plata", -34.921, -57.955);
        Estacion est2 = new Estacion("Mar del Plata", -38.002, -57.556);
        
        SistAnual sistAnual = new SistAnual(3, est1);
        SistMensual sistMensual = new SistMensual(4, est2);
        
        for(i=0; i<3; i++) {
            for(j=0; j<12; j++) {
                sistAnual.setTemp(j+1, i+2021, GeneradorAleatorio.generarDouble(30));
            }
        }
        
        for(i=0; i<4; i++) {
            for(j=0; j<12; j++) {
                sistMensual.setTemp(j+1, i+2020, GeneradorAleatorio.generarDouble(30));
            }
        }
        
        //sistAnual.setTemp(1, 2022, 31.0);
        //sistMensual.setTemp(1, 2023, 31.0);
        
        System.out.println(sistAnual.toString());
        System.out.println(sistAnual.mayorTemp());
        
        System.out.println("--------------------");
        
        System.out.println(sistMensual.toString());
        System.out.println(sistMensual.mayorTemp());
        
    }
    
}
