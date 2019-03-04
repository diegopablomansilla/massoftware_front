package com.massoftware.windows.a.monedas_cotizaciones;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.Entity;

@ClassLabelAnont(singular = "Actualización de datos vigentes", plural = "Actualización de datos vigentes", singularPre = "Actualización de datos vigentes", pluralPre = "Actualización de datos vigentes")
public class ActualizacionDatosVigentes extends Entity {

	@FieldConfAnont(label = "Cotización")
	private Boolean cotizacion;

	@FieldConfAnont(label = "Fecha cotización")
	private Boolean cotizacionFecha;

	public Boolean getCotizacion() {
		return cotizacion;
	}

	public void setCotizacion(Boolean cotizacion) {
		this.cotizacion = cotizacion;
	}

	public Boolean getCotizacionFecha() {
		return cotizacionFecha;
	}

	public void setCotizacionFecha(Boolean cotizacionFecha) {
		this.cotizacionFecha = cotizacionFecha;
	}

}
