package openClosedPrinciple.caso1;

import java.util.ArrayList;
import java.util.Collection;

public class MailManagerImpl implements MailManager {
    private Collection<Correo> inbox;
    private Collection<Correo> borrados;

    public MailManagerImpl() {
        this.inbox = new ArrayList<>();
        this.borrados = new ArrayList<>();
    }

    @Override
    public int contarBorrados() {
        return borrados.size();
    }

    @Override
    public int contarInbox() {
        return inbox.size();
    }

    @Override
    public void eliminarBorrado(Correo borrado) {
        borrados.remove(borrado);
    }

    @Override
    public void borrarCorreo(Correo correo) {
        inbox.remove(correo);
        borrados.remove(correo);
    }
}
