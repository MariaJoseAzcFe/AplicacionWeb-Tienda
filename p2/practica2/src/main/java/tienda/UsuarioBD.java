package tienda;

public class UsuarioBD {
    private String nombre;
    private String apellidos;
    private String direccion;
    private String codigoPostal;
    private String telefono;
    private String provincia;
    private String poblacion;
    private String clave;

    // Constructor
    public UsuarioBD(String nombre, String clave, String direccion, String codigoPostal, String telefono, String apellidos, String provincia, String poblacion) {
        this.nombre = nombre;
        this.clave = clave;
        this.direccion = direccion;
        this.codigoPostal = codigoPostal;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.provincia = provincia;
        this.poblacion = poblacion;
    }

    // Getters y Setters
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }   

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getCodigoPostal() {
        return codigoPostal;
    }

    public void setCodigoPostal(String codigoPostal) {
        this.codigoPostal = codigoPostal;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getPoblacion() {
        return poblacion;
    }

    public void setPoblacion(String poblacion) {
        this.poblacion = poblacion;
    }



}
