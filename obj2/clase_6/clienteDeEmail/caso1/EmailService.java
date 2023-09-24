package openClosedPrinciple.caso1;

import java.util.Collection;

public interface EmailService {
	Collection<Correo> recibirNuevos(Usuario usuario);
	void enviar(Correo correo);
}
