package com.massoftware.model.fondos;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.Ticket;

@ClassLabelAnont(singular = "Ticket modelo", plural = "Tickets modelos", singularPre = "el ticket modelo", pluralPre = "los tickets modelo")
public class TicketModelo extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº modelo
	@FieldConfAnont(label = "Nº modelo", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// ticket
	@FieldConfAnont(label = "ticket", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Ticket ticket;

	// Prueba lectura
	@FieldConfAnont(label = "Prueba lectura", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String pruebaLectura;

	// activo
	@FieldConfAnont(label = "activo", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean activo = false;

	// Longitud lectura
	@FieldConfAnont(label = "Longitud lectura", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer longitudLectura;

	// Posición
	@FieldConfAnont(label = "Posición", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer identificacionPosicion;

	// Identificación
	@FieldConfAnont(label = "Identificación", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer identificacion;

	// Posición
	@FieldConfAnont(label = "Posición", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer importePosicion;

	// Longitud
	@FieldConfAnont(label = "Longitud", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer longitud;

	// Cantidad decimales
	@FieldConfAnont(label = "Cantidad decimales", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer cantidadDecimales;

	// Número posición
	@FieldConfAnont(label = "Número posición", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer numeroPosicion;

	// Número longitud
	@FieldConfAnont(label = "Número longitud", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer numeroLongitud;

	// Prefijo identificación importación
	@FieldConfAnont(label = "Prefijo identificación importación", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "", maxValue = "", mask = "")
	private String prefijoIdentificacion;

	// Posición prefijo
	@FieldConfAnont(label = "Posición prefijo", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer posicionPrefijo;

	// ---------------------------------------------------------------------------------------------------------------------------


	public TicketModelo() throws Exception {
	}

	public TicketModelo(String idArg0, Integer numeroArg1, String nombreArg2, String idTicketArg3, String pruebaLecturaArg4, Boolean activoArg5, Integer longitudLecturaArg6, Integer identificacionPosicionArg7, Integer identificacionArg8, Integer importePosicionArg9, Integer longitudArg10, Integer cantidadDecimalesArg11, Integer numeroPosicionArg12, Integer numeroLongitudArg13, String prefijoIdentificacionArg14, Integer posicionPrefijoArg15) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idTicketArg3, pruebaLecturaArg4, activoArg5, longitudLecturaArg6, identificacionPosicionArg7, identificacionArg8, importePosicionArg9, longitudArg10, cantidadDecimalesArg11, numeroPosicionArg12, numeroLongitudArg13, prefijoIdentificacionArg14, posicionPrefijoArg15);

	}

	public TicketModelo(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, java.util.Date fechaActualizacionArg6, Integer cantidadPorLotesArg7, String idTicketControlDenunciadosArg8, java.math.BigDecimal valorMaximoArg9, String pruebaLecturaArg10, Boolean activoArg11, Integer longitudLecturaArg12, Integer identificacionPosicionArg13, Integer identificacionArg14, Integer importePosicionArg15, Integer longitudArg16, Integer cantidadDecimalesArg17, Integer numeroPosicionArg18, Integer numeroLongitudArg19, String prefijoIdentificacionArg20, Integer posicionPrefijoArg21) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, fechaActualizacionArg6, cantidadPorLotesArg7, idTicketControlDenunciadosArg8, valorMaximoArg9, pruebaLecturaArg10, activoArg11, longitudLecturaArg12, identificacionPosicionArg13, identificacionArg14, importePosicionArg15, longitudArg16, cantidadDecimalesArg17, numeroPosicionArg18, numeroLongitudArg19, prefijoIdentificacionArg20, posicionPrefijoArg21);

	}

	public TicketModelo(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, java.util.Date fechaActualizacionArg6, Integer cantidadPorLotesArg7, String idArg8, Integer numeroArg9, String nombreArg10, java.math.BigDecimal valorMaximoArg11, String pruebaLecturaArg12, Boolean activoArg13, Integer longitudLecturaArg14, Integer identificacionPosicionArg15, Integer identificacionArg16, Integer importePosicionArg17, Integer longitudArg18, Integer cantidadDecimalesArg19, Integer numeroPosicionArg20, Integer numeroLongitudArg21, String prefijoIdentificacionArg22, Integer posicionPrefijoArg23) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, fechaActualizacionArg6, cantidadPorLotesArg7, idArg8, numeroArg9, nombreArg10, valorMaximoArg11, pruebaLecturaArg12, activoArg13, longitudLecturaArg14, identificacionPosicionArg15, identificacionArg16, importePosicionArg17, longitudArg18, cantidadDecimalesArg19, numeroPosicionArg20, numeroLongitudArg21, prefijoIdentificacionArg22, posicionPrefijoArg23);

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

	// GET Nº modelo
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº modelo
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

	// BUILD IF NULL AND GET ticket
	public Ticket buildTicket() throws Exception {
		this.ticket = (this.ticket == null) ? new Ticket() : this.ticket;
		return this.ticket;
	}

	// GET ticket
	public Ticket getTicket() {
		this.ticket = (this.ticket != null && this.ticket.getId() == null) ? null : this.ticket ;
		return this.ticket;
	}

	// SET ticket
	public void setTicket(Ticket ticket ){
		this.ticket = ticket;
	}

	// GET Prueba lectura
	public String getPruebaLectura() {
		return this.pruebaLectura;
	}

	// SET Prueba lectura
	public void setPruebaLectura(String pruebaLectura ){
		pruebaLectura = (pruebaLectura != null) ? pruebaLectura.trim() : null;
		this.pruebaLectura = (pruebaLectura != null && pruebaLectura.length() == 0) ? null : pruebaLectura;
	}

	// GET activo
	public Boolean getActivo() {
		return this.activo;
	}

	// SET activo
	public void setActivo(Boolean activo ){
		this.activo = (activo == null) ? false : activo;
	}

	// GET Longitud lectura
	public Integer getLongitudLectura() {
		return this.longitudLectura;
	}

	// SET Longitud lectura
	public void setLongitudLectura(Integer longitudLectura ){
		this.longitudLectura = longitudLectura;
	}

	// GET Posición
	public Integer getIdentificacionPosicion() {
		return this.identificacionPosicion;
	}

	// SET Posición
	public void setIdentificacionPosicion(Integer identificacionPosicion ){
		this.identificacionPosicion = identificacionPosicion;
	}

	// GET Identificación
	public Integer getIdentificacion() {
		return this.identificacion;
	}

	// SET Identificación
	public void setIdentificacion(Integer identificacion ){
		this.identificacion = identificacion;
	}

	// GET Posición
	public Integer getImportePosicion() {
		return this.importePosicion;
	}

	// SET Posición
	public void setImportePosicion(Integer importePosicion ){
		this.importePosicion = importePosicion;
	}

	// GET Longitud
	public Integer getLongitud() {
		return this.longitud;
	}

	// SET Longitud
	public void setLongitud(Integer longitud ){
		this.longitud = longitud;
	}

	// GET Cantidad decimales
	public Integer getCantidadDecimales() {
		return this.cantidadDecimales;
	}

	// SET Cantidad decimales
	public void setCantidadDecimales(Integer cantidadDecimales ){
		this.cantidadDecimales = cantidadDecimales;
	}

	// GET Número posición
	public Integer getNumeroPosicion() {
		return this.numeroPosicion;
	}

	// SET Número posición
	public void setNumeroPosicion(Integer numeroPosicion ){
		this.numeroPosicion = numeroPosicion;
	}

	// GET Número longitud
	public Integer getNumeroLongitud() {
		return this.numeroLongitud;
	}

	// SET Número longitud
	public void setNumeroLongitud(Integer numeroLongitud ){
		this.numeroLongitud = numeroLongitud;
	}

	// GET Prefijo identificación importación
	public String getPrefijoIdentificacion() {
		return this.prefijoIdentificacion;
	}

	// SET Prefijo identificación importación
	public void setPrefijoIdentificacion(String prefijoIdentificacion ){
		prefijoIdentificacion = (prefijoIdentificacion != null) ? prefijoIdentificacion.trim() : null;
		this.prefijoIdentificacion = (prefijoIdentificacion != null && prefijoIdentificacion.length() == 0) ? null : prefijoIdentificacion;
	}

	// GET Posición prefijo
	public Integer getPosicionPrefijo() {
		return this.posicionPrefijo;
	}

	// SET Posición prefijo
	public void setPosicionPrefijo(Integer posicionPrefijo ){
		this.posicionPrefijo = posicionPrefijo;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idTicketArg3, String pruebaLecturaArg4, Boolean activoArg5, Integer longitudLecturaArg6, Integer identificacionPosicionArg7, Integer identificacionArg8, Integer importePosicionArg9, Integer longitudArg10, Integer cantidadDecimalesArg11, Integer numeroPosicionArg12, Integer numeroLongitudArg13, String prefijoIdentificacionArg14, Integer posicionPrefijoArg15) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildTicket().setId(idTicketArg3);
		this.setPruebaLectura(pruebaLecturaArg4);
		this.setActivo(activoArg5);
		this.setLongitudLectura(longitudLecturaArg6);
		this.setIdentificacionPosicion(identificacionPosicionArg7);
		this.setIdentificacion(identificacionArg8);
		this.setImportePosicion(importePosicionArg9);
		this.setLongitud(longitudArg10);
		this.setCantidadDecimales(cantidadDecimalesArg11);
		this.setNumeroPosicion(numeroPosicionArg12);
		this.setNumeroLongitud(numeroLongitudArg13);
		this.setPrefijoIdentificacion(prefijoIdentificacionArg14);
		this.setPosicionPrefijo(posicionPrefijoArg15);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, java.util.Date fechaActualizacionArg6, Integer cantidadPorLotesArg7, String idTicketControlDenunciadosArg8, java.math.BigDecimal valorMaximoArg9, String pruebaLecturaArg10, Boolean activoArg11, Integer longitudLecturaArg12, Integer identificacionPosicionArg13, Integer identificacionArg14, Integer importePosicionArg15, Integer longitudArg16, Integer cantidadDecimalesArg17, Integer numeroPosicionArg18, Integer numeroLongitudArg19, String prefijoIdentificacionArg20, Integer posicionPrefijoArg21) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildTicket().setId(idArg3);
		this.buildTicket().setNumero(numeroArg4);
		this.buildTicket().setNombre(nombreArg5);
		this.buildTicket().setFechaActualizacion(fechaActualizacionArg6);
		this.buildTicket().setCantidadPorLotes(cantidadPorLotesArg7);
		this.buildTicket().buildTicketControlDenunciados().setId(idTicketControlDenunciadosArg8);
		this.buildTicket().setValorMaximo(valorMaximoArg9);
		this.setPruebaLectura(pruebaLecturaArg10);
		this.setActivo(activoArg11);
		this.setLongitudLectura(longitudLecturaArg12);
		this.setIdentificacionPosicion(identificacionPosicionArg13);
		this.setIdentificacion(identificacionArg14);
		this.setImportePosicion(importePosicionArg15);
		this.setLongitud(longitudArg16);
		this.setCantidadDecimales(cantidadDecimalesArg17);
		this.setNumeroPosicion(numeroPosicionArg18);
		this.setNumeroLongitud(numeroLongitudArg19);
		this.setPrefijoIdentificacion(prefijoIdentificacionArg20);
		this.setPosicionPrefijo(posicionPrefijoArg21);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, java.util.Date fechaActualizacionArg6, Integer cantidadPorLotesArg7, String idArg8, Integer numeroArg9, String nombreArg10, java.math.BigDecimal valorMaximoArg11, String pruebaLecturaArg12, Boolean activoArg13, Integer longitudLecturaArg14, Integer identificacionPosicionArg15, Integer identificacionArg16, Integer importePosicionArg17, Integer longitudArg18, Integer cantidadDecimalesArg19, Integer numeroPosicionArg20, Integer numeroLongitudArg21, String prefijoIdentificacionArg22, Integer posicionPrefijoArg23) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildTicket().setId(idArg3);
		this.buildTicket().setNumero(numeroArg4);
		this.buildTicket().setNombre(nombreArg5);
		this.buildTicket().setFechaActualizacion(fechaActualizacionArg6);
		this.buildTicket().setCantidadPorLotes(cantidadPorLotesArg7);
		this.buildTicket().buildTicketControlDenunciados().setId(idArg8);
		this.buildTicket().buildTicketControlDenunciados().setNumero(numeroArg9);
		this.buildTicket().buildTicketControlDenunciados().setNombre(nombreArg10);
		this.buildTicket().setValorMaximo(valorMaximoArg11);
		this.setPruebaLectura(pruebaLecturaArg12);
		this.setActivo(activoArg13);
		this.setLongitudLectura(longitudLecturaArg14);
		this.setIdentificacionPosicion(identificacionPosicionArg15);
		this.setIdentificacion(identificacionArg16);
		this.setImportePosicion(importePosicionArg17);
		this.setLongitud(longitudArg18);
		this.setCantidadDecimales(cantidadDecimalesArg19);
		this.setNumeroPosicion(numeroPosicionArg20);
		this.setNumeroLongitud(numeroLongitudArg21);
		this.setPrefijoIdentificacion(prefijoIdentificacionArg22);
		this.setPosicionPrefijo(posicionPrefijoArg23);

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