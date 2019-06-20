package com.massoftware.model.monedas;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.monedas.Moneda;
import com.massoftware.model.seguridad.Usuario;

@ClassLabelAnont(singular = "Cotización de moneda", plural = "Cotizaciones de monedas", singularPre = "la cotización de moneda", pluralPre = "las cotizaciones de monedas")
public class MonedaCotizacion extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Fecha cotización
	@FieldConfAnont(label = "Fecha cotización", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.sql.Timestamp cotizacionFecha;

	// Compra
	@FieldConfAnont(label = "Compra", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "-9999.9999", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal compra;

	// Venta
	@FieldConfAnont(label = "Venta", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "-9999.9999", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal venta;

	// Fecha cotización (Auditoria)
	@FieldConfAnont(label = "Fecha cotización (Auditoria)", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.sql.Timestamp cotizacionFechaAuditoria;

	// Moneda
	@FieldConfAnont(label = "Moneda", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Moneda moneda;

	// Usuario
	@FieldConfAnont(label = "Usuario", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Usuario usuario;

	// ---------------------------------------------------------------------------------------------------------------------------


	public MonedaCotizacion() throws Exception {
	}

	public MonedaCotizacion(String idArg0, java.sql.Timestamp cotizacionFechaArg1, java.math.BigDecimal compraArg2, java.math.BigDecimal ventaArg3, java.sql.Timestamp cotizacionFechaAuditoriaArg4, String idMonedaArg5, String idUsuarioArg6) throws Exception {

		setter(idArg0, cotizacionFechaArg1, compraArg2, ventaArg3, cotizacionFechaAuditoriaArg4, idMonedaArg5, idUsuarioArg6);

	}

	public MonedaCotizacion(String idArg0, java.sql.Timestamp cotizacionFechaArg1, java.math.BigDecimal compraArg2, java.math.BigDecimal ventaArg3, java.sql.Timestamp cotizacionFechaAuditoriaArg4, String idArg5, Integer numeroArg6, String nombreArg7, String abreviaturaArg8, java.math.BigDecimal cotizacionArg9, java.sql.Timestamp cotizacionFechaArg10, Boolean controlActualizacionArg11, String idMonedaAFIPArg12, String idArg13, Integer numeroArg14, String nombreArg15) throws Exception {

		setter(idArg0, cotizacionFechaArg1, compraArg2, ventaArg3, cotizacionFechaAuditoriaArg4, idArg5, numeroArg6, nombreArg7, abreviaturaArg8, cotizacionArg9, cotizacionFechaArg10, controlActualizacionArg11, idMonedaAFIPArg12, idArg13, numeroArg14, nombreArg15);

	}

	public MonedaCotizacion(String idArg0, java.sql.Timestamp cotizacionFechaArg1, java.math.BigDecimal compraArg2, java.math.BigDecimal ventaArg3, java.sql.Timestamp cotizacionFechaAuditoriaArg4, String idArg5, Integer numeroArg6, String nombreArg7, String abreviaturaArg8, java.math.BigDecimal cotizacionArg9, java.sql.Timestamp cotizacionFechaArg10, Boolean controlActualizacionArg11, String idArg12, String codigoArg13, String nombreArg14, String idArg15, Integer numeroArg16, String nombreArg17) throws Exception {

		setter(idArg0, cotizacionFechaArg1, compraArg2, ventaArg3, cotizacionFechaAuditoriaArg4, idArg5, numeroArg6, nombreArg7, abreviaturaArg8, cotizacionArg9, cotizacionFechaArg10, controlActualizacionArg11, idArg12, codigoArg13, nombreArg14, idArg15, numeroArg16, nombreArg17);

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

	// GET Fecha cotización
	public java.sql.Timestamp getCotizacionFecha() {
		return this.cotizacionFecha;
	}

	// SET Fecha cotización
	public void setCotizacionFecha(java.sql.Timestamp cotizacionFecha ){
		this.cotizacionFecha = cotizacionFecha;
	}

	// GET Compra
	public java.math.BigDecimal getCompra() {
		return this.compra;
	}

	// SET Compra
	public void setCompra(java.math.BigDecimal compra ){
		this.compra = compra;
	}

	// GET Venta
	public java.math.BigDecimal getVenta() {
		return this.venta;
	}

	// SET Venta
	public void setVenta(java.math.BigDecimal venta ){
		this.venta = venta;
	}

	// GET Fecha cotización (Auditoria)
	public java.sql.Timestamp getCotizacionFechaAuditoria() {
		return this.cotizacionFechaAuditoria;
	}

	// SET Fecha cotización (Auditoria)
	public void setCotizacionFechaAuditoria(java.sql.Timestamp cotizacionFechaAuditoria ){
		this.cotizacionFechaAuditoria = cotizacionFechaAuditoria;
	}

	// BUILD IF NULL AND GET Moneda
	public Moneda buildMoneda() throws Exception {
		this.moneda = (this.moneda == null) ? new Moneda() : this.moneda;
		return this.moneda;
	}

	// GET Moneda
	public Moneda getMoneda() {
		this.moneda = (this.moneda != null && this.moneda.getId() == null) ? null : this.moneda ;
		return this.moneda;
	}

	// SET Moneda
	public void setMoneda(Moneda moneda ){
		this.moneda = moneda;
	}

	// BUILD IF NULL AND GET Usuario
	public Usuario buildUsuario() throws Exception {
		this.usuario = (this.usuario == null) ? new Usuario() : this.usuario;
		return this.usuario;
	}

	// GET Usuario
	public Usuario getUsuario() {
		this.usuario = (this.usuario != null && this.usuario.getId() == null) ? null : this.usuario ;
		return this.usuario;
	}

	// SET Usuario
	public void setUsuario(Usuario usuario ){
		this.usuario = usuario;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, java.sql.Timestamp cotizacionFechaArg1, java.math.BigDecimal compraArg2, java.math.BigDecimal ventaArg3, java.sql.Timestamp cotizacionFechaAuditoriaArg4, String idMonedaArg5, String idUsuarioArg6) throws Exception {

		this.setId(idArg0);
		this.setCotizacionFecha(cotizacionFechaArg1);
		this.setCompra(compraArg2);
		this.setVenta(ventaArg3);
		this.setCotizacionFechaAuditoria(cotizacionFechaAuditoriaArg4);
		this.buildMoneda().setId(idMonedaArg5);
		this.buildUsuario().setId(idUsuarioArg6);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, java.sql.Timestamp cotizacionFechaArg1, java.math.BigDecimal compraArg2, java.math.BigDecimal ventaArg3, java.sql.Timestamp cotizacionFechaAuditoriaArg4, String idArg5, Integer numeroArg6, String nombreArg7, String abreviaturaArg8, java.math.BigDecimal cotizacionArg9, java.sql.Timestamp cotizacionFechaArg10, Boolean controlActualizacionArg11, String idMonedaAFIPArg12, String idArg13, Integer numeroArg14, String nombreArg15) throws Exception {

		this.setId(idArg0);
		this.setCotizacionFecha(cotizacionFechaArg1);
		this.setCompra(compraArg2);
		this.setVenta(ventaArg3);
		this.setCotizacionFechaAuditoria(cotizacionFechaAuditoriaArg4);
		this.buildMoneda().setId(idArg5);
		this.buildMoneda().setNumero(numeroArg6);
		this.buildMoneda().setNombre(nombreArg7);
		this.buildMoneda().setAbreviatura(abreviaturaArg8);
		this.buildMoneda().setCotizacion(cotizacionArg9);
		this.buildMoneda().setCotizacionFecha(cotizacionFechaArg10);
		this.buildMoneda().setControlActualizacion(controlActualizacionArg11);
		this.buildMoneda().buildMonedaAFIP().setId(idMonedaAFIPArg12);
		this.buildUsuario().setId(idArg13);
		this.buildUsuario().setNumero(numeroArg14);
		this.buildUsuario().setNombre(nombreArg15);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, java.sql.Timestamp cotizacionFechaArg1, java.math.BigDecimal compraArg2, java.math.BigDecimal ventaArg3, java.sql.Timestamp cotizacionFechaAuditoriaArg4, String idArg5, Integer numeroArg6, String nombreArg7, String abreviaturaArg8, java.math.BigDecimal cotizacionArg9, java.sql.Timestamp cotizacionFechaArg10, Boolean controlActualizacionArg11, String idArg12, String codigoArg13, String nombreArg14, String idArg15, Integer numeroArg16, String nombreArg17) throws Exception {

		this.setId(idArg0);
		this.setCotizacionFecha(cotizacionFechaArg1);
		this.setCompra(compraArg2);
		this.setVenta(ventaArg3);
		this.setCotizacionFechaAuditoria(cotizacionFechaAuditoriaArg4);
		this.buildMoneda().setId(idArg5);
		this.buildMoneda().setNumero(numeroArg6);
		this.buildMoneda().setNombre(nombreArg7);
		this.buildMoneda().setAbreviatura(abreviaturaArg8);
		this.buildMoneda().setCotizacion(cotizacionArg9);
		this.buildMoneda().setCotizacionFecha(cotizacionFechaArg10);
		this.buildMoneda().setControlActualizacion(controlActualizacionArg11);
		this.buildMoneda().buildMonedaAFIP().setId(idArg12);
		this.buildMoneda().buildMonedaAFIP().setCodigo(codigoArg13);
		this.buildMoneda().buildMonedaAFIP().setNombre(nombreArg14);
		this.buildUsuario().setId(idArg15);
		this.buildUsuario().setNumero(numeroArg16);
		this.buildUsuario().setNombre(nombreArg17);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getCotizacionFecha() != null && this.getCompra() != null){
			return this.getCotizacionFecha() + " - " +  this.getCompra();
		} else if(this.getCotizacionFecha() != null && this.getCompra() == null){
			return this.getCotizacionFecha().toString();
		} else if(this.getCotizacionFecha() == null && this.getCompra() != null){
			return this.getCompra().toString();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------