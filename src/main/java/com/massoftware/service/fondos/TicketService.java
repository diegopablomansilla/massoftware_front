package com.massoftware.service.fondos;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.Ticket;
import com.massoftware.service.UtilNumeric;

public class TicketService {

	private int levelDefault = 1;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Ticket obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto Ticket no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object fechaActualizacion = ( obj.getFechaActualizacion() == null ) ? java.util.Date.class : obj.getFechaActualizacion();
		Object cantidadPorLotes = ( obj.getCantidadPorLotes() == null ) ? Integer.class : obj.getCantidadPorLotes();
		Object ticketControlDenunciados = ( obj.getTicketControlDenunciados() != null && obj.getTicketControlDenunciados().getId() != null) ? obj.getTicketControlDenunciados().getId() : String.class;
		Object valorMaximo = ( obj.getValorMaximo() == null ) ? java.math.BigDecimal.class : obj.getValorMaximo();

		String sql = "SELECT * FROM massoftware.i_Ticket(?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, fechaActualizacion, cantidadPorLotes, ticketControlDenunciados, valorMaximo};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 1){

				Boolean ok = (Boolean) row[0];
				if(ok){
					return id.toString();
				} else { 
					throw new IllegalStateException("No se esperaba que la sentencia no insertara en la base de datos.");
				}

			} else {
				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + row.length + " columnas.");
			}
		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public String update(Ticket obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto Ticket no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto Ticket con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object fechaActualizacion = ( obj.getFechaActualizacion() == null ) ? java.util.Date.class : obj.getFechaActualizacion();
		Object cantidadPorLotes = ( obj.getCantidadPorLotes() == null ) ? Integer.class : obj.getCantidadPorLotes();
		Object ticketControlDenunciados = ( obj.getTicketControlDenunciados() != null && obj.getTicketControlDenunciados().getId() != null) ? obj.getTicketControlDenunciados().getId() : String.class;
		Object valorMaximo = ( obj.getValorMaximo() == null ) ? java.math.BigDecimal.class : obj.getValorMaximo();

		String sql = "SELECT * FROM massoftware.u_Ticket(?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, fechaActualizacion, cantidadPorLotes, ticketControlDenunciados, valorMaximo};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 1){

				Boolean ok = (Boolean) row[0];

				if(ok){
					return id.toString();
				} else { 
					throw new IllegalStateException("No se esperaba que la sentencia no actualizara en la base de datos.");
				}

			} else {
				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + row.length + " columnas.");
			}
		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public boolean deleteById(String id) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (Ticket.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_TicketById(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return row[0].equals(true);

		} else if(table.length > 1 ) {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

		return false;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public boolean isExistsNumero(Integer arg) throws Exception {

		if(arg == null || arg.toString().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un arg (Ticket.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_Ticket_numero(?)";

		Object[] args = new Object[] {arg};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 1){

				return (Boolean) row[0];

			} else { 
				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + row.length + " columnas.");
			}

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public boolean isExistsNombre(String arg) throws Exception {

		if(arg == null || arg.toString().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un arg (Ticket.nombre) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Ticket_nombre(?)";

		Object[] args = new Object[] {arg};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 1){

				return (Boolean) row[0];

			} else { 
				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + row.length + " columnas.");
			}

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Integer nextValueNumero() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Ticket_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValueCantidadPorLotes() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Ticket_cantidadPorLotes()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public java.math.BigDecimal nextValueValorMaximo() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Ticket_valorMaximo()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Long count() throws Exception {

		String sql = "SELECT COUNT(*) FROM massoftware.Ticket;";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Long) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public List<Ticket> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Ticket.numero o Ticket.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº ticket

		if(UtilNumeric.isInteger(arg)) {

			TicketFiltro filtroNumero = new TicketFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Ticket> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		TicketFiltro filtroNombre = new TicketFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Ticket> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Ticket>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Ticket findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Ticket findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (Ticket.id) no nulo/vacio.");
		}

		id = id.trim();

		Ticket obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_TicketById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 7) {

				obj = mapper7Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 9) {

				obj = mapper9Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else {
				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");
			}
		} else if(table.length > 1 ) {
				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

		return null;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public List<Ticket> find(TicketFiltro filtro) throws Exception {

		List<Ticket> listado = new ArrayList<Ticket>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_Ticket" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 7) {

				Ticket obj = mapper7Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 9) {

				Ticket obj = mapper9Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Ticket mapper7Fields(Object[] row) throws Exception {

		int c = -1;

		String idTicketArg0 = (String) row[++c];
		Integer numeroTicketArg1 = (Integer) row[++c];
		String nombreTicketArg2 = (String) row[++c];
		java.util.Date fechaActualizacionTicketArg3 = (java.util.Date) row[++c];
		Integer cantidadPorLotesTicketArg4 = (Integer) row[++c];
		String ticketControlDenunciadosTicketArg5 = (String) row[++c]; // TicketControlDenunciados.id
		java.math.BigDecimal valorMaximoTicketArg6 = (java.math.BigDecimal) row[++c];

		Ticket obj = new Ticket(idTicketArg0, numeroTicketArg1, nombreTicketArg2, fechaActualizacionTicketArg3, cantidadPorLotesTicketArg4, ticketControlDenunciadosTicketArg5, valorMaximoTicketArg6);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Ticket mapper9Fields(Object[] row) throws Exception {

		int c = -1;

		String idTicketArg0 = (String) row[++c];
		Integer numeroTicketArg1 = (Integer) row[++c];
		String nombreTicketArg2 = (String) row[++c];
		java.util.Date fechaActualizacionTicketArg3 = (java.util.Date) row[++c];
		Integer cantidadPorLotesTicketArg4 = (Integer) row[++c];
		String idTicketControlDenunciadosArg5 = (String) row[++c];
		Integer numeroTicketControlDenunciadosArg6 = (Integer) row[++c];
		String nombreTicketControlDenunciadosArg7 = (String) row[++c];
		java.math.BigDecimal valorMaximoTicketArg8 = (java.math.BigDecimal) row[++c];

		Ticket obj = new Ticket(idTicketArg0, numeroTicketArg1, nombreTicketArg2, fechaActualizacionTicketArg3, cantidadPorLotesTicketArg4, idTicketControlDenunciadosArg5, numeroTicketControlDenunciadosArg6, nombreTicketControlDenunciadosArg7, valorMaximoTicketArg8);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------