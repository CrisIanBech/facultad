package org.example;

import java.util.List;

public class GestorBibliografico {

    private List<Articulo> articulos;
    private List<SuscripcionArticulo> suscripcionesArticulos;

    public void cargarArticulo(Articulo articulo) {
        articulos.add(articulo);
        notificarSuscriptores(articulo);
    }

    private void notificarSuscriptores(Articulo articulo) {
        suscripcionesArticulos
                .forEach(suscripcionArticulo -> {
                    if (cumpleFiltro(articulo, suscripcionArticulo))
                        suscripcionArticulo.getSuscripcionArticuloListener().articuloNuevo(articulo);
                });
    }

    public boolean cumpleFiltro(Articulo articulo, SuscripcionArticulo suscripcionArticulo) {
        return suscripcionArticulo.preferenciaAutores(articulo.getAutores())
                && suscripcionArticulo.preferenciaTipoArticulo(articulo.getTipoArticulo())
                && suscripcionArticulo.preferenciaFiliales(articulo.getFiliales())
                && suscripcionArticulo.preferenciaLugarPublicacion(articulo.getLugarPublicacion())
                && suscripcionArticulo.preferenciaPalabrasClave(articulo.getPalabrasClave())
                && suscripcionArticulo.preferenciaTitulo(articulo.getTitulo());
    }

    public void suscribirseArticulos(SuscripcionArticulo suscripcionArticulo) {
        suscripcionesArticulos.add(suscripcionArticulo);
    }

}
