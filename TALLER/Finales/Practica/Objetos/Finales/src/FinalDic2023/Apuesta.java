package FinalDic2023;

public class Apuesta {
    private String nombre;
    private int dni;
    private int id;
    private String apuesta;
    private double monto;
    
    public Apuesta(String n, int dni, int id, String res, double monto) {
        this.nombre = n;
        this.dni = dni;
        this.id = id;
        this.apuesta = res.toLowerCase();
        this.monto = monto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getApuesta() {
        return apuesta;
    }

    public void setApuesta(String apuesta) {
        this.apuesta = apuesta;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }
    
    @Override
    public String toString() {
        return "Nombre=" + this.nombre + " DNI=" + this.dni + " Dinero ganado=";
    }
}
