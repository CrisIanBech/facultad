package ar.edu.unq.po2;

import java.util.Collection;

public class Caja {

    public double registrar(Collection<Pagable> pagables) {

        double precioFinal = 0;

        for(Pagable pagable: pagables) {
            precioFinal += pagable.getMonto();
            pagable.procesarPago();
        }

        return precioFinal;

    }

}
