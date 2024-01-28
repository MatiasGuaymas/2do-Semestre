package FinalDic2023;

public class Partido {
    private String local;
    private String visitante;
    private String resultado;
    private double victoriaLocal;
    private double empate;
    private double victoriaVisitante;
    
    public Partido(String l, String v, double vicLoc, double emp, double vicVis) {
        this.local = l;
        this.visitante = v;
        this.resultado = "";
        this.victoriaLocal = vicLoc;
        this.empate = emp;
        this.victoriaVisitante = vicVis;
    }

    public String getLocal() {
        return local;
    }

    public void setLocal(String local) {
        this.local = local;
    }

    public String getVisitante() {
        return visitante;
    }

    public void setVisitante(String visitante) {
        this.visitante = visitante;
    }

    public String getResultado() {
        return resultado;
    }

    public void setResultado(String resultado) {
        this.resultado = resultado;
    }

    public double getVictoriaLocal() {
        return victoriaLocal;
    }

    public void setVictoriaLocal(double victoriaLocal) {
        this.victoriaLocal = victoriaLocal;
    }

    public double getEmpate() {
        return empate;
    }

    public void setEmpate(double empate) {
        this.empate = empate;
    }

    public double getVictoriaVisitante() {
        return victoriaVisitante;
    }

    public void setVictoriaVisitante(double victoriaVisitante) {
        this.victoriaVisitante = victoriaVisitante;
    }
    
    public double getMonto() {
        if(resultado.equals("victoria local")) {
            return victoriaLocal;
        } else if (resultado.equals("empate")) {
            return empate;
        } else return victoriaVisitante;
    }
    
}
