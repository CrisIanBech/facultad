package openClosedPrinciple.caso1;

interface MailManager {
    int contarBorrados();
    int contarInbox();
    void eliminarBorrado(Correo borrado);
    void borrarCorreo(Correo correo);
}
