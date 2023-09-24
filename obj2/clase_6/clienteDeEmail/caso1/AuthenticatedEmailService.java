package openClosedPrinciple.caso1;

abstract class AuthenticatedEmailService implements ConnectableEmailService {

    private Authenticator authentication;

    public AuthenticatedEmailService(Authenticator authentication) {
        this.authentication = authentication;
    }

    @Override
    public void conectar(Usuario usuario) {
        authentication.authenticate(usuario);
    }

    public boolean isAuthenticated() {
        return authentication.isAuthenticated();
    }

}
