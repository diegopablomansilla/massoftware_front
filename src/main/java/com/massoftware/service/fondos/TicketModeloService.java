package com.massoftware.service.fondos;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.TicketModelo;

public class TicketModeloService {

	private int levelDefault = 2;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(TicketModelo obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto TicketModelo no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object ticket = ( obj.getTicket() != null && obj.getTicket().getId() != null) ? obj.getTicket().getId() : String.class;
		Object pruebaLectura = ( obj.getPruebaLectura() == null ) ? String.class : obj.getPruebaLectura();
		Object activo = ( obj.getActivo() == null ) ? Boolean.class : obj.getActivo();
		Object longitudLectura = ( obj.getLongitudLectura() == null ) ? Integer.class : obj.getLongitudLectura();
		Object identificacionPosicion = ( obj.getIdentificacionPosicion() == null ) ? Integer.class : obj.getIdentificacionPosicion();
		Object identificacion = ( obj.getIdentificacion() == null ) ? Integer.class : obj.getIdentificacion();
		Object importePosicion = ( obj.getImportePosicion() == null ) ? Integer.class : obj.getImportePosicion();
		Object longitud = ( obj.getLongitud() == null ) ? Integer.class : obj.getLongitud();
		Object cantidadDecimales = ( obj.getCantidadDecimales() == null ) ? Integer.class : obj.getCantidadDecimales();
		Object numeroPosicion = ( obj.getNumeroPosicion() == null ) ? Integer.class : obj.getNumeroPosicion();
		Object numeroLongitud = ( obj.getNumeroLongitud() == null ) ? Integer.class : obj.getNumeroLongitud();
		Object prefijoIdentificacion = ( obj.getPrefijoIdentificacion() == null ) ? String.class : obj.getPrefijoIdentificacion();
		Object posicionPrefijo = ( obj.getPosicionPrefijo() == null ) ? Integer.class : obj.getPosicionPrefijo();

		String sql = "SELECT * FROM massoftware.i_TicketModelo(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, ticket, pruebaLectura, activo, longitudLectura, identificacionPosicion, identificacion, importePosicion, longitud, cantidadDecimales, numeroPosicion, numeroLongitud, prefijoIdentificacion, posicionPrefijo};

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


	public String update(TicketModelo obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto TicketModelo no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto TicketModelo con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object ticket = ( obj.getTicket() != null && obj.getTicket().getId() != null) ? obj.getTicket().getId() : String.class;
		Object pruebaLectura = ( obj.getPruebaLectura() == null ) ? String.class : obj.getPruebaLectura();
		Object activo = ( obj.getActivo() == null ) ? Boolean.class : obj.getActivo();
		Object longitudLectura = ( obj.getLongitudLectura() == null ) ? Integer.class : obj.getLongitudLectura();
		Object identificacionPosicion = ( obj.getIdentificacionPosicion() == null ) ? Integer.class : obj.getIdentificacionPosicion();
		Object identificacion = ( obj.getIdentificacion() == null ) ? Integer.class : obj.getIdentificacion();
		Object importePosicion = ( obj.getImportePosicion() == null ) ? Integer.class : obj.getImportePosicion();
		Object longitud = ( obj.getLongitud() == null ) ? Integer.class : obj.getLongitud();
		Object cantidadDecimales = ( obj.getCantidadDecimales() == null ) ? Integer.class : obj.getCantidadDecimales();
		Object numeroPosicion = ( obj.getNumeroPosicion() == null ) ? Integer.class : obj.getNumeroPosicion();
		Object numeroLongitud = ( obj.getNumeroLongitud() == null ) ? Integer.class : obj.getNumeroLongitud();
		Object prefijoIdentificacion = ( obj.getPrefijoIdentificacion() == null ) ? String.class : obj.getPrefijoIdentificacion();
		Object posicionPrefijo = ( obj.getPosicionPrefijo() == null ) ? Integer.class : obj.getPosicionPrefijo();

		String sql = "SELECT * FROM massoftware.u_TicketModelo(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, ticket, pruebaLectura, activo, longitudLectura, identificacionPosicion, identificacion, importePosicion, longitud, cantidadDecimales, numeroPosicion, numeroLongitud, prefijoIdentificacion, posicionPrefijo};

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

			throw new IllegalArgumentException("Se esperaba un id (TicketModelo.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_TicketModeloById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (TicketModelo.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_TicketModelo_numero(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (TicketModelo.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_TicketModelo_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_TicketModelo_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueLongitudLectura() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TicketModelo_longitudLectura()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueIdentificacionPosicion() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TicketModelo_identificacionPosicion()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueIdentificacion() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TicketModelo_identificacion()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueImportePosicion() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TicketModelo_importePosicion()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueLongitud() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TicketModelo_longitud()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueCantidadDecimales() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TicketModelo_cantidadDecimales()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueNumeroPosicion() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TicketModelo_numeroPosicion()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueNumeroLongitud() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TicketModelo_numeroLongitud()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValuePosicionPrefijo() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TicketModelo_posicionPrefijo()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Long count() throws Exception {

		String sql = "SELECT COUNT(*) FROM massoftware.TicketModelo;";

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


	public List<TicketModelo> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (TicketModelo.numero o TicketModelo.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº modelo

		if(UtilNumeric.isInteger(arg)) {

			TicketModeloFiltro filtroNumero = new TicketModeloFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<TicketModelo> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		TicketModeloFiltro filtroNombre = new TicketModeloFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<TicketModelo> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<TicketModelo>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public TicketModelo findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public TicketModelo findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (TicketModelo.id) no nulo/vacio.");

		}


		id = id.trim();


		TicketModelo obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_TicketModeloById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 16) {

				obj = mapper16Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 22) {

				obj = mapper22Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 24) {

				obj = mapper24Fields(row);

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


	public List<TicketModelo> find(TicketModeloFiltro filtro) throws Exception {

		List<TicketModelo> listado = new ArrayList<TicketModelo>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_TicketModelo" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();
		Object ticket = ( filtro.getTicket() != null && filtro.getTicket().getId() != null) ? filtro.getTicket().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre, ticket};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre, ticket};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 16) {

				TicketModelo obj = mapper16Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 22) {

				TicketModelo obj = mapper22Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 24) {

				TicketModelo obj = mapper24Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private TicketModelo mapper16Fields(Object[] row) throws Exception {

		int c = -1;

		String idTicketModeloArg0 = (String) row[++c];
		Integer numeroTicketModeloArg1 = (Integer) row[++c];
		String nombreTicketModeloArg2 = (String) row[++c];
		String ticketTicketModeloArg3 = (String) row[++c]; // Ticket.id
		String pruebaLecturaTicketModeloArg4 = (String) row[++c];
		Boolean activoTicketModeloArg5 = (Boolean) row[++c];
		Integer longitudLecturaTicketModeloArg6 = (Integer) row[++c];
		Integer identificacionPosicionTicketModeloArg7 = (Integer) row[++c];
		Integer identificacionTicketModeloArg8 = (Integer) row[++c];
		Integer importePosicionTicketModeloArg9 = (Integer) row[++c];
		Integer longitudTicketModeloArg10 = (Integer) row[++c];
		Integer cantidadDecimalesTicketModeloArg11 = (Integer) row[++c];
		Integer numeroPosicionTicketModeloArg12 = (Integer) row[++c];
		Integer numeroLongitudTicketModeloArg13 = (Integer) row[++c];
		String prefijoIdentificacionTicketModeloArg14 = (String) row[++c];
		Integer posicionPrefijoTicketModeloArg15 = (Integer) row[++c];

		TicketModelo obj = new TicketModelo(idTicketModeloArg0, numeroTicketModeloArg1, nombreTicketModeloArg2, ticketTicketModeloArg3, pruebaLecturaTicketModeloArg4, activoTicketModeloArg5, longitudLecturaTicketModeloArg6, identificacionPosicionTicketModeloArg7, identificacionTicketModeloArg8, importePosicionTicketModeloArg9, longitudTicketModeloArg10, cantidadDecimalesTicketModeloArg11, numeroPosicionTicketModeloArg12, numeroLongitudTicketModeloArg13, prefijoIdentificacionTicketModeloArg14, posicionPrefijoTicketModeloArg15);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private TicketModelo mapper22Fields(Object[] row) throws Exception {

		int c = -1;

		String idTicketModeloArg0 = (String) row[++c];
		Integer numeroTicketModeloArg1 = (Integer) row[++c];
		String nombreTicketModeloArg2 = (String) row[++c];
		String idTicketArg3 = (String) row[++c];
		Integer numeroTicketArg4 = (Integer) row[++c];
		String nombreTicketArg5 = (String) row[++c];
		java.util.Date fechaActualizacionTicketArg6 = (java.util.Date) row[++c];
		Integer cantidadPorLotesTicketArg7 = (Integer) row[++c];
		String ticketControlDenunciadosTicketArg8 = (String) row[++c]; // TicketControlDenunciados.id
		java.math.BigDecimal valorMaximoTicketArg9 = (java.math.BigDecimal) row[++c];
		String pruebaLecturaTicketModeloArg10 = (String) row[++c];
		Boolean activoTicketModeloArg11 = (Boolean) row[++c];
		Integer longitudLecturaTicketModeloArg12 = (Integer) row[++c];
		Integer identificacionPosicionTicketModeloArg13 = (Integer) row[++c];
		Integer identificacionTicketModeloArg14 = (Integer) row[++c];
		Integer importePosicionTicketModeloArg15 = (Integer) row[++c];
		Integer longitudTicketModeloArg16 = (Integer) row[++c];
		Integer cantidadDecimalesTicketModeloArg17 = (Integer) row[++c];
		Integer numeroPosicionTicketModeloArg18 = (Integer) row[++c];
		Integer numeroLongitudTicketModeloArg19 = (Integer) row[++c];
		String prefijoIdentificacionTicketModeloArg20 = (String) row[++c];
		Integer posicionPrefijoTicketModeloArg21 = (Integer) row[++c];

		TicketModelo obj = new TicketModelo(idTicketModeloArg0, numeroTicketModeloArg1, nombreTicketModeloArg2, idTicketArg3, numeroTicketArg4, nombreTicketArg5, fechaActualizacionTicketArg6, cantidadPorLotesTicketArg7, ticketControlDenunciadosTicketArg8, valorMaximoTicketArg9, pruebaLecturaTicketModeloArg10, activoTicketModeloArg11, longitudLecturaTicketModeloArg12, identificacionPosicionTicketModeloArg13, identificacionTicketModeloArg14, importePosicionTicketModeloArg15, longitudTicketModeloArg16, cantidadDecimalesTicketModeloArg17, numeroPosicionTicketModeloArg18, numeroLongitudTicketModeloArg19, prefijoIdentificacionTicketModeloArg20, posicionPrefijoTicketModeloArg21);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private TicketModelo mapper24Fields(Object[] row) throws Exception {

		int c = -1;

		String idTicketModeloArg0 = (String) row[++c];
		Integer numeroTicketModeloArg1 = (Integer) row[++c];
		String nombreTicketModeloArg2 = (String) row[++c];
		String idTicketArg3 = (String) row[++c];
		Integer numeroTicketArg4 = (Integer) row[++c];
		String nombreTicketArg5 = (String) row[++c];
		java.util.Date fechaActualizacionTicketArg6 = (java.util.Date) row[++c];
		Integer cantidadPorLotesTicketArg7 = (Integer) row[++c];
		String idTicketControlDenunciadosArg8 = (String) row[++c];
		Integer numeroTicketControlDenunciadosArg9 = (Integer) row[++c];
		String nombreTicketControlDenunciadosArg10 = (String) row[++c];
		java.math.BigDecimal valorMaximoTicketArg11 = (java.math.BigDecimal) row[++c];
		String pruebaLecturaTicketModeloArg12 = (String) row[++c];
		Boolean activoTicketModeloArg13 = (Boolean) row[++c];
		Integer longitudLecturaTicketModeloArg14 = (Integer) row[++c];
		Integer identificacionPosicionTicketModeloArg15 = (Integer) row[++c];
		Integer identificacionTicketModeloArg16 = (Integer) row[++c];
		Integer importePosicionTicketModeloArg17 = (Integer) row[++c];
		Integer longitudTicketModeloArg18 = (Integer) row[++c];
		Integer cantidadDecimalesTicketModeloArg19 = (Integer) row[++c];
		Integer numeroPosicionTicketModeloArg20 = (Integer) row[++c];
		Integer numeroLongitudTicketModeloArg21 = (Integer) row[++c];
		String prefijoIdentificacionTicketModeloArg22 = (String) row[++c];
		Integer posicionPrefijoTicketModeloArg23 = (Integer) row[++c];

		TicketModelo obj = new TicketModelo(idTicketModeloArg0, numeroTicketModeloArg1, nombreTicketModeloArg2, idTicketArg3, numeroTicketArg4, nombreTicketArg5, fechaActualizacionTicketArg6, cantidadPorLotesTicketArg7, idTicketControlDenunciadosArg8, numeroTicketControlDenunciadosArg9, nombreTicketControlDenunciadosArg10, valorMaximoTicketArg11, pruebaLecturaTicketModeloArg12, activoTicketModeloArg13, longitudLecturaTicketModeloArg14, identificacionPosicionTicketModeloArg15, identificacionTicketModeloArg16, importePosicionTicketModeloArg17, longitudTicketModeloArg18, cantidadDecimalesTicketModeloArg19, numeroPosicionTicketModeloArg20, numeroLongitudTicketModeloArg21, prefijoIdentificacionTicketModeloArg22, posicionPrefijoTicketModeloArg23);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------