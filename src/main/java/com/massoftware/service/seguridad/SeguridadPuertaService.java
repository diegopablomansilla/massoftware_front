package com.massoftware.service.seguridad;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.service.UtilNumeric;

public class SeguridadPuertaService {

	private int levelDefault = 1;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(SeguridadPuerta obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto SeguridadPuerta no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object equate = ( obj.getEquate() == null ) ? String.class : obj.getEquate();
		Object seguridadModulo = ( obj.getSeguridadModulo() != null && obj.getSeguridadModulo().getId() != null) ? obj.getSeguridadModulo().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_SeguridadPuerta(?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, equate, seguridadModulo};

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


	public String update(SeguridadPuerta obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto SeguridadPuerta no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto SeguridadPuerta con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object equate = ( obj.getEquate() == null ) ? String.class : obj.getEquate();
		Object seguridadModulo = ( obj.getSeguridadModulo() != null && obj.getSeguridadModulo().getId() != null) ? obj.getSeguridadModulo().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_SeguridadPuerta(?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, equate, seguridadModulo};

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
			throw new IllegalArgumentException("Se esperaba un id (SeguridadPuerta.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_SeguridadPuertaById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (SeguridadPuerta.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_SeguridadPuerta_numero(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (SeguridadPuerta.nombre) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_SeguridadPuerta_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_SeguridadPuerta_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.SeguridadPuerta;";

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


	public List<SeguridadPuerta> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (SeguridadPuerta.numero o SeguridadPuerta.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº puerta

		if(UtilNumeric.isInteger(arg)) {

			SeguridadPuertaFiltro filtroNumero = new SeguridadPuertaFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<SeguridadPuerta> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		SeguridadPuertaFiltro filtroNombre = new SeguridadPuertaFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<SeguridadPuerta> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<SeguridadPuerta>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public SeguridadPuerta findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public SeguridadPuerta findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (SeguridadPuerta.id) no nulo/vacio.");
		}

		id = id.trim();

		SeguridadPuerta obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_SeguridadPuertaById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 5) {

				obj = mapper5Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 7) {

				obj = mapper7Fields(row);

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


	public List<SeguridadPuerta> find(SeguridadPuertaFiltro filtro) throws Exception {

		List<SeguridadPuerta> listado = new ArrayList<SeguridadPuerta>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_SeguridadPuerta" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?)";

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

			if(row.length == 5) {

				SeguridadPuerta obj = mapper5Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 7) {

				SeguridadPuerta obj = mapper7Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private SeguridadPuerta mapper5Fields(Object[] row) throws Exception {

		int c = -1;

		String idSeguridadPuertaArg0 = (String) row[++c];
		Integer numeroSeguridadPuertaArg1 = (Integer) row[++c];
		String nombreSeguridadPuertaArg2 = (String) row[++c];
		String equateSeguridadPuertaArg3 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg4 = (String) row[++c]; // SeguridadModulo.id

		SeguridadPuerta obj = new SeguridadPuerta(idSeguridadPuertaArg0, numeroSeguridadPuertaArg1, nombreSeguridadPuertaArg2, equateSeguridadPuertaArg3, seguridadModuloSeguridadPuertaArg4);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private SeguridadPuerta mapper7Fields(Object[] row) throws Exception {

		int c = -1;

		String idSeguridadPuertaArg0 = (String) row[++c];
		Integer numeroSeguridadPuertaArg1 = (Integer) row[++c];
		String nombreSeguridadPuertaArg2 = (String) row[++c];
		String equateSeguridadPuertaArg3 = (String) row[++c];
		String idSeguridadModuloArg4 = (String) row[++c];
		Integer numeroSeguridadModuloArg5 = (Integer) row[++c];
		String nombreSeguridadModuloArg6 = (String) row[++c];

		SeguridadPuerta obj = new SeguridadPuerta(idSeguridadPuertaArg0, numeroSeguridadPuertaArg1, nombreSeguridadPuertaArg2, equateSeguridadPuertaArg3, idSeguridadModuloArg4, numeroSeguridadModuloArg5, nombreSeguridadModuloArg6);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------