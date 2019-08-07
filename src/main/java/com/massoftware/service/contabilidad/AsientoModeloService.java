package com.massoftware.service.contabilidad;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.AsientoModelo;
import com.massoftware.service.UtilNumeric;

public class AsientoModeloService {

	private int levelDefault = 1;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(AsientoModelo obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto AsientoModelo no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_AsientoModelo(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, ejercicioContable};

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


	public String update(AsientoModelo obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto AsientoModelo no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto AsientoModelo con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_AsientoModelo(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, ejercicioContable};

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
			throw new IllegalArgumentException("Se esperaba un id (AsientoModelo.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_AsientoModeloById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (AsientoModelo.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_AsientoModelo_numero(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (AsientoModelo.nombre) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_AsientoModelo_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_AsientoModelo_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.AsientoModelo;";

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


	public List<AsientoModelo> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (AsientoModelo.numero o AsientoModelo.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº asiento

		if(UtilNumeric.isInteger(arg)) {

			AsientoModeloFiltro filtroNumero = new AsientoModeloFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<AsientoModelo> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		AsientoModeloFiltro filtroNombre = new AsientoModeloFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<AsientoModelo> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<AsientoModelo>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public AsientoModelo findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public AsientoModelo findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (AsientoModelo.id) no nulo/vacio.");
		}

		id = id.trim();

		AsientoModelo obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_AsientoModeloById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 4) {

				obj = mapper4Fields(row);

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


	public List<AsientoModelo> find(AsientoModeloFiltro filtro) throws Exception {

		List<AsientoModelo> listado = new ArrayList<AsientoModelo>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_AsientoModelo" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();
		Object ejercicioContable = ( filtro.getEjercicioContable() != null && filtro.getEjercicioContable().getId() != null) ? filtro.getEjercicioContable().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre, ejercicioContable};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre, ejercicioContable};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 4) {

				AsientoModelo obj = mapper4Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 10) {

				AsientoModelo obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoModelo mapper4Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoModeloArg0 = (String) row[++c];
		Integer numeroAsientoModeloArg1 = (Integer) row[++c];
		String nombreAsientoModeloArg2 = (String) row[++c];
		String ejercicioContableAsientoModeloArg3 = (String) row[++c]; // EjercicioContable.id

		AsientoModelo obj = new AsientoModelo(idAsientoModeloArg0, numeroAsientoModeloArg1, nombreAsientoModeloArg2, ejercicioContableAsientoModeloArg3);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoModelo mapper10Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoModeloArg0 = (String) row[++c];
		Integer numeroAsientoModeloArg1 = (Integer) row[++c];
		String nombreAsientoModeloArg2 = (String) row[++c];
		String idEjercicioContableArg3 = (String) row[++c];
		Integer numeroEjercicioContableArg4 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg5 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg6 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg7 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg8 = (Boolean) row[++c];
		String comentarioEjercicioContableArg9 = (String) row[++c];

		AsientoModelo obj = new AsientoModelo(idAsientoModeloArg0, numeroAsientoModeloArg1, nombreAsientoModeloArg2, idEjercicioContableArg3, numeroEjercicioContableArg4, aperturaEjercicioContableArg5, cierreEjercicioContableArg6, cerradoEjercicioContableArg7, cerradoModulosEjercicioContableArg8, comentarioEjercicioContableArg9);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------