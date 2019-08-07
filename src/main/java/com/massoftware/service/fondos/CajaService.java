package com.massoftware.service.fondos;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.Caja;
import com.massoftware.service.UtilNumeric;

public class CajaService {

	private int levelDefault = 2;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Caja obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto Caja no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object seguridadPuerta = ( obj.getSeguridadPuerta() != null && obj.getSeguridadPuerta().getId() != null) ? obj.getSeguridadPuerta().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_Caja(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, seguridadPuerta};

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


	public String update(Caja obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto Caja no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto Caja con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object seguridadPuerta = ( obj.getSeguridadPuerta() != null && obj.getSeguridadPuerta().getId() != null) ? obj.getSeguridadPuerta().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_Caja(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, seguridadPuerta};

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
			throw new IllegalArgumentException("Se esperaba un id (Caja.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_CajaById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (Caja.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_Caja_numero(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (Caja.nombre) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Caja_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_Caja_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.Caja;";

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


	public List<Caja> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Caja.numero o Caja.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº caja

		if(UtilNumeric.isInteger(arg)) {

			CajaFiltro filtroNumero = new CajaFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Caja> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		CajaFiltro filtroNombre = new CajaFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Caja> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Caja>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Caja findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Caja findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (Caja.id) no nulo/vacio.");
		}

		id = id.trim();

		Caja obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_CajaById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 4) {

				obj = mapper4Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 8) {

				obj = mapper8Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 10) {

				obj = mapper10Fields(row);

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


	public List<Caja> find(CajaFiltro filtro) throws Exception {

		List<Caja> listado = new ArrayList<Caja>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_Caja" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?)";

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

			if(row.length == 4) {

				Caja obj = mapper4Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 8) {

				Caja obj = mapper8Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 10) {

				Caja obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Caja mapper4Fields(Object[] row) throws Exception {

		int c = -1;

		String idCajaArg0 = (String) row[++c];
		Integer numeroCajaArg1 = (Integer) row[++c];
		String nombreCajaArg2 = (String) row[++c];
		String seguridadPuertaCajaArg3 = (String) row[++c]; // SeguridadPuerta.id

		Caja obj = new Caja(idCajaArg0, numeroCajaArg1, nombreCajaArg2, seguridadPuertaCajaArg3);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Caja mapper8Fields(Object[] row) throws Exception {

		int c = -1;

		String idCajaArg0 = (String) row[++c];
		Integer numeroCajaArg1 = (Integer) row[++c];
		String nombreCajaArg2 = (String) row[++c];
		String idSeguridadPuertaArg3 = (String) row[++c];
		Integer numeroSeguridadPuertaArg4 = (Integer) row[++c];
		String nombreSeguridadPuertaArg5 = (String) row[++c];
		String equateSeguridadPuertaArg6 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg7 = (String) row[++c]; // SeguridadModulo.id

		Caja obj = new Caja(idCajaArg0, numeroCajaArg1, nombreCajaArg2, idSeguridadPuertaArg3, numeroSeguridadPuertaArg4, nombreSeguridadPuertaArg5, equateSeguridadPuertaArg6, seguridadModuloSeguridadPuertaArg7);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Caja mapper10Fields(Object[] row) throws Exception {

		int c = -1;

		String idCajaArg0 = (String) row[++c];
		Integer numeroCajaArg1 = (Integer) row[++c];
		String nombreCajaArg2 = (String) row[++c];
		String idSeguridadPuertaArg3 = (String) row[++c];
		Integer numeroSeguridadPuertaArg4 = (Integer) row[++c];
		String nombreSeguridadPuertaArg5 = (String) row[++c];
		String equateSeguridadPuertaArg6 = (String) row[++c];
		String idSeguridadModuloArg7 = (String) row[++c];
		Integer numeroSeguridadModuloArg8 = (Integer) row[++c];
		String nombreSeguridadModuloArg9 = (String) row[++c];

		Caja obj = new Caja(idCajaArg0, numeroCajaArg1, nombreCajaArg2, idSeguridadPuertaArg3, numeroSeguridadPuertaArg4, nombreSeguridadPuertaArg5, equateSeguridadPuertaArg6, idSeguridadModuloArg7, numeroSeguridadModuloArg8, nombreSeguridadModuloArg9);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------