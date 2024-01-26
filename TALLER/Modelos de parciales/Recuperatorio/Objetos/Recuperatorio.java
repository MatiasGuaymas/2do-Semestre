package Parciales.Recuperatorio;

public class Recuperatorio {
    public static void main(String[] args) {
        SistemaAvion sistAvion = new SistemaAvion(8);
        SistemaEstadia sistEstadia = new SistemaEstadia(8);
        
        Solicitud soli1 = new Solicitud("Matias", "Prepago", "Bariloche", 100.0, 300.0, 100.0, 7, 150.0);
        Solicitud soli2 = new Solicitud("Pepe", "Prepago", "Tucuman", 300.0, 400.0, 500.0, 10, 100.0);
        Solicitud soli3 = new Solicitud("Romeo", "Prepago", "Bariloche", 200.0, 100.0, 100.0, 10, 150.0);
        Solicitud soli4 = new Solicitud("Juancho", "Prepago", "Bariloche", 100.0, 300.0, 100.0, 7, 150.0);
        Solicitud soli5 = new Solicitud("Pedro", "Prepago", "Tucuman", 300.0, 400.0, 500.0, 10, 100.0);
        Solicitud soli6 = new Solicitud("Julian", "Prepago", "Bariloche", 200.0, 100.0, 100.0, 10, 150.0);
        
        sistAvion.agregarSolicitud(soli1);
        sistAvion.agregarSolicitud(soli2);
        sistAvion.agregarSolicitud(soli3);
        sistAvion.otorgarSubsidio(450.0);
        System.out.println(sistAvion.toString());
        
        System.out.println("-----------------");
        
        sistEstadia.agregarSolicitud(soli4);
        sistEstadia.agregarSolicitud(soli5);
        sistEstadia.agregarSolicitud(soli6);
        sistEstadia.otorgarSubsidio(1200.0);
        System.out.println(sistEstadia.toString());
    }
    
}
