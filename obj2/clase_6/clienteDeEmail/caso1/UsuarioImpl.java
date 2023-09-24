package openClosedPrinciple.caso1;

public class UsuarioImpl {
    private String name;
    private String password;

    public UsuarioImpl(String name, String password) {
        this.name = name;
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }
}
