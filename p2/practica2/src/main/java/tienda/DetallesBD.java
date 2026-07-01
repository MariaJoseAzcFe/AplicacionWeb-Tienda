package tienda;

public class DetallesBD {
    private String descripcion;
    private int cantidad;
    private float precioUnitario;

    public DetallesBD(String descripcion, int cantidad, float precioUnitario) {
        this.descripcion = descripcion;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public int getCantidad() {
        return cantidad;
    }

    public float getPrecioUnitario() {
        return precioUnitario;
    }
}
 
