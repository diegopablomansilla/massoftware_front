package com.massoftware.model.monedas;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.afip.MonedaAFIP;

@ClassLabelAnont(singular = "Moneda", plural = "Monedas", singularPre = "la moneda", pluralPre = "las monedas")
public class Moneda extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº moneda
	@FieldConfAnont(label = "Nº moneda", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Abreviatura
	@FieldConfAnont(label = "Abreviatura", labelError = "", unique = true, readOnly = false, required = true, columns = 5.0f, maxLength = 5, minValue = "", maxValue = "", mask = "")
	private String abreviatura;

	// Cotización
	@FieldConfAnont(label = "Cotización", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = 10, minValue = "-9999.9999", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal cotizacion;

	// Fecha cotización
	@FieldConfAnont(label = "Fecha cotización", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.sql.Timestamp cotizacionFecha;

	// Control de actualizacion
	@FieldConfAnont(label = "Control de actualizacion", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean controlActualizacion = false;

	// Moneda AFIP
	@FieldConfAnont(label = "Moneda AFIP", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private MonedaAFIP monedaAFIP;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Moneda() throws Exception {
	}

	public Moneda(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, java.math.BigDecimal cotizacionArg4, java.sql.Timestamp cotizacionFechaArg5, Boolean controlActualizacionArg6) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3, cotizacionArg4, cotizacionFechaArg5, controlActualizacionArg6);

	}

	public Moneda(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, java.math.BigDecimal cotizacionArg4, java.sql.Timestamp cotizacionFechaArg5, Boolean controlActualizacionArg6, String idArg7, String codigoArg8, String nombreArg9) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3, cotizacionArg4, cotizacionFechaArg5, controlActualizacionArg6, idArg7, codigoArg8, nombreArg9);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET ID
	public String getId() {
		return this.id;
	}
	// SET ID
	public void setId(String id){
		id = (id != null) ? id.trim() : null;
		this.id = (id != null && id.length() == 0) ? null : id;
	}

	// GET Nº moneda
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº moneda
	public void setNumero(Integer numero ){
		this.numero = numero;
	}

	// GET Nombre
	public String getNombre() {
		return this.nombre;
	}

	// SET Nombre
	public void setNombre(String nombre ){
		nombre = (nombre != null) ? nombre.trim() : null;
		this.nombre = (nombre != null && nombre.length() == 0) ? null : nombre;
	}

	// GET Abreviatura
	public String getAbreviatura() {
		return this.abreviatura;
	}

	// SET Abreviatura
	public void setAbreviatura(String abreviatura ){
		abreviatura = (abreviatura != null) ? abreviatura.trim() : null;
		this.abreviatura = (abreviatura != null && abreviatura.length() == 0) ? null : abreviatura;
	}

	// GET Cotización
	public java.math.BigDecimal getCotizacion() {
		return this.cotizacion;
	}

	// SET Cotización
	public void setCotizacion(java.math.BigDecimal cotizacion ){
		this.cotizacion = cotizacion;
	}

	// GET Fecha cotización
	public java.sql.Timestamp getCotizacionFecha() {
		return this.cotizacionFecha;
	}

	// SET Fecha cotización
	public void setCotizacionFecha(java.sql.Timestamp cotizacionFecha ){
		this.cotizacionFecha = cotizacionFecha;
	}

	// GET Control de actualizacion
	public Boolean getControlActualizacion() {
		return this.controlActualizacion;
	}

	// SET Control de actualizacion
	public void setControlActualizacion(Boolean controlActualizacion ){
		this.controlActualizacion = (controlActualizacion == null) ? false : controlActualizacion;
	}

	// BUILD IF NULL AND GET Moneda AFIP
	public MonedaAFIP buildMonedaAFIP() throws Exception {
		this.monedaAFIP = (this.monedaAFIP == null) ? new MonedaAFIP() : this.monedaAFIP;
		return this.monedaAFIP;
	}

	// GET Moneda AFIP
	public MonedaAFIP getMonedaAFIP() {
		this.monedaAFIP = (this.monedaAFIP != null && this.monedaAFIP.getId() == null) ? null : this.monedaAFIP ;
		return this.monedaAFIP;
	}

	// SET Moneda AFIP
	public void setMonedaAFIP(MonedaAFIP monedaAFIP ){
		this.monedaAFIP = monedaAFIP;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, java.math.BigDecimal cotizacionArg4, java.sql.Timestamp cotizacionFechaArg5, Boolean controlActualizacionArg6) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);
		this.setCotizacion(cotizacionArg4);
		this.setCotizacionFecha(cotizacionFechaArg5);
		this.setControlActualizacion(controlActualizacionArg6);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, java.math.BigDecimal cotizacionArg4, java.sql.Timestamp cotizacionFechaArg5, Boolean controlActualizacionArg6, String idArg7, String codigoArg8, String nombreArg9) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);
		this.setCotizacion(cotizacionArg4);
		this.setCotizacionFecha(cotizacionFechaArg5);
		this.setControlActualizacion(controlActualizacionArg6);
		this.buildMonedaAFIP().setId(idArg7);
		this.buildMonedaAFIP().setCodigo(codigoArg8);
		this.buildMonedaAFIP().setNombre(nombreArg9);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getNumero() != null && this.getNombre() != null){
			return this.getNumero() + " - " +  this.getNombre();
		} else if(this.getNumero() != null && this.getNombre() == null){
			return this.getNumero().toString();
		} else if(this.getNumero() == null && this.getNombre() != null){
			return this.getNombre();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------