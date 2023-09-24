package openClosedPrinciple.caso1;

public class ClienteEmail {

	private ConnectableEmailService connectableEmailService;
	private Usuario usuario;
	private MailManager mailManager;

	public ClienteEmail(ConnectableEmailService connectableEmailService, MailManager mailManager, Usuario usuario){
		this.connectableEmailService = connectableEmailService;
		this.usuario = usuario;
		this.mailManager = mailManager;
		this.conectar();
	}

	public void conectar(){
		this.connectableEmailService.conectar(usuario);
	}

	public void borrarCorreo(Correo correo){
		mailManager.borrarCorreo(correo);
	}

	public int contarBorrados(){
		return mailManager.contarBorrados();
	}

	public int contarInbox(){
		return mailManager.contarInbox();
	}

	public void eliminarBorrado(Correo borrado){
		mailManager.eliminarBorrado(borrado);
	}

	public void recibirNuevos(){
		this.connectableEmailService.recibirNuevos(usuario);
	}

	public void enviarCorreo(Correo correo){
		this.connectableEmailService.enviar(correo);
	}

}
