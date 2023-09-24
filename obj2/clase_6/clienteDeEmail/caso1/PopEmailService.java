package openClosedPrinciple.caso1;

import java.util.ArrayList;
import java.util.Collection;

public class PopEmailService extends AuthenticatedEmailService {

	public PopEmailService(Authenticator authentication) {
		super(authentication);
	}

	public Collection<Correo> recibirNuevos(Usuario usuario) {
		Collection<Correo> retorno = new ArrayList<Correo>();
		if(isAuthenticated()) {
			// fetch mails
		}
		return retorno;
	}

	public void enviar(Correo correo) {
      //realiza lo necesario para enviar el correo.		
	}

}
