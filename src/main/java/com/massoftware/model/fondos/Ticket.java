package com.massoftware.model.fondos;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.TicketControlDenunciados;

@ClassLabelAnont(singular = "Ticket", plural = "Tickets", singularPre = "el ticket", pluralPre = "los tickets")
public class Ticket extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº ticket
	@FieldConfAnont(label = "Nº ticket", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Fecha actualización
	@FieldConfAnont(label = "Fecha actualización", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fechaActualizacion;

	// Cantidad por lotes
	@FieldConfAnont(label = "Cantidad por lotes", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer cantidadPorLotes;

	// Control denunciados
	@FieldConfAnont(label = "Control denunciados", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private TicketControlDenunciados ticketControlDenunciados;

	// Valor máximo
	@FieldConfAnont(label = "Valor máximo", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal valorMaximo;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Ticket() throws Exception {
	}

	public Ticket(String idArg0, Integer numeroArg1, String nombreArg2, java.util.Date fechaActualizacionArg3, Integer cantidadPorLotesArg4, String idTicketControlDenunciadosArg5, java.math.BigDecimal valorMaximoArg6) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, fechaActualizacionArg3, cantidadPorLotesArg4, idTicketControlDenunciadosArg5, valorMaximoArg6);

	}

	public Ticket(String idArg0, Integer numeroArg1, String nombreArg2, java.util.Date fechaActualizacionArg3, Integer cantidadPorLotesArg4, String idArg5, Integer numeroArg6, String nombreArg7, java.math.BigDecimal valorMaximoArg8) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, fechaActualizacionArg3, cantidadPorLotesArg4, idArg5, numeroArg6, nombreArg7, valorMaximoArg8);

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

	// GET Nº ticket
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº ticket
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

	// GET Fecha actualización
	public java.util.Date getFechaActualizacion() {
		return this.fechaActualizacion;
	}

	// SET Fecha actualización
	public void setFechaActualizacion(java.util.Date fechaActualizacion ){
		this.fechaActualizacion = fechaActualizacion;
	}

	// GET Cantidad por lotes
	public Integer getCantidadPorLotes() {
		return this.cantidadPorLotes;
	}

	// SET Cantidad por lotes
	public void setCantidadPorLotes(Integer cantidadPorLotes ){
		this.cantidadPorLotes = cantidadPorLotes;
	}

	// BUILD IF NULL AND GET Control denunciados
	public TicketControlDenunciados buildTicketControlDenunciados() throws Exception {
		this.ticketControlDenunciados = (this.ticketControlDenunciados == null) ? new TicketControlDenunciados() : this.ticketControlDenunciados;
		return this.ticketControlDenunciados;
	}

	// GET Control denunciados
	public TicketControlDenunciados getTicketControlDenunciados() {
		this.ticketControlDenunciados = (this.ticketControlDenunciados != null && this.ticketControlDenunciados.getId() == null) ? null : this.ticketControlDenunciados ;
		return this.ticketControlDenunciados;
	}

	// SET Control denunciados
	public void setTicketControlDenunciados(TicketControlDenunciados ticketControlDenunciados ){
		this.ticketControlDenunciados = ticketControlDenunciados;
	}

	// GET Valor máximo
	public java.math.BigDecimal getValorMaximo() {
		return this.valorMaximo;
	}

	// SET Valor máximo
	public void setValorMaximo(java.math.BigDecimal valorMaximo ){
		this.valorMaximo = valorMaximo;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, java.util.Date fechaActualizacionArg3, Integer cantidadPorLotesArg4, String idTicketControlDenunciadosArg5, java.math.BigDecimal valorMaximoArg6) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setFechaActualizacion(fechaActualizacionArg3);
		this.setCantidadPorLotes(cantidadPorLotesArg4);
		this.buildTicketControlDenunciados().setId(idTicketControlDenunciadosArg5);
		this.setValorMaximo(valorMaximoArg6);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, java.util.Date fechaActualizacionArg3, Integer cantidadPorLotesArg4, String idArg5, Integer numeroArg6, String nombreArg7, java.math.BigDecimal valorMaximoArg8) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setFechaActualizacion(fechaActualizacionArg3);
		this.setCantidadPorLotes(cantidadPorLotesArg4);
		this.buildTicketControlDenunciados().setId(idArg5);
		this.buildTicketControlDenunciados().setNumero(numeroArg6);
		this.buildTicketControlDenunciados().setNombre(nombreArg7);
		this.setValorMaximo(valorMaximoArg8);

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