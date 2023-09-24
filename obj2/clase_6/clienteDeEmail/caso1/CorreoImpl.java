package openClosedPrinciple.caso1;

public class CorreoImpl extends Correo {

    private String asunto;
    private String destinatario;
    private String cuerpo;

    public CorreoImpl(String asunto, String destinatario, String cuerpo) {
        this.asunto = asunto;
        this.destinatario = destinatario;
        this.cuerpo = cuerpo;
    }

    @Override
    public String getAsunto() {
        return asunto;
    }

    @Override
    public String getDestinatario() {
        return destinatario;
    }

    @Override
    public String getCuerpo() {
        return cuerpo;
    }
}
