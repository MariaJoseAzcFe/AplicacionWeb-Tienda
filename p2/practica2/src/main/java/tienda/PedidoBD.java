package tienda;

public class PedidoBD{
    private int codigo;
    private float importe;
    private int estado;


    public PedidoBD(int codigo, float importe, int estado) {
        this.codigo = codigo;
        this.importe = importe;
        this.estado = estado;
    }

    public int getCodigo() {
        return codigo;
    }

    public float getImporte() {
        return importe;
    }

    public int getEstado() {
        return estado;
    }
}