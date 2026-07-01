package tienda;

public class EstadoBD {
    private String estadoletra;
    private int estado;


    public EstadoBD(int estado, String estadoletra) {
        this.estado = estado;
        this.estadoletra = estadoletra;
    }

    public int getEstado() {
        return estado;
    }
    public String getEstadoLetra() {
        return estadoletra;
    }

    
}
