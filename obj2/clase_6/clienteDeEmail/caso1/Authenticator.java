package openClosedPrinciple.caso1;

public interface Authenticator {
    public void authenticate(Usuario usuario);
    public boolean isAuthenticated();
}
