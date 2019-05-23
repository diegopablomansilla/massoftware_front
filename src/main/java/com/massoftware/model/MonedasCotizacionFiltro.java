package com.massoftware.model;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.monedas.Moneda;

public class MonedasCotizacionFiltro extends Entity {

	@FieldConfAnont(label = "Moneda", required = true)
	private Moneda moneda;

	public Moneda getMoneda() {
		return moneda;
	}

	public void setMoneda(Moneda moneda) {
		this.moneda = moneda;
	}

}
