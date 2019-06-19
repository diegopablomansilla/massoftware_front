package com.massoftware.service.contabilidad;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.EjercicioContable;

public class EjercicioContableService {

	private int levelDefault = 0;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(EjercicioContable obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto EjercicioContable no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object apertura = ( obj.getApertura() == null ) ? java.util.Date.class : obj.getApertura();
		Object cierre = ( obj.getCierre() == null ) ? java.util.Date.class : obj.getCierre();
		Object cerrado = ( obj.getCerrado() == null ) ? Boolean.class : obj.getCerrado();
		Object cerradoModulos = ( obj.getCerradoModulos() == null ) ? Boolean.class : obj.getCerradoModulos();
		Object comentario = ( obj.getComentario() == null ) ? String.class : obj.getComentario();

		String sql = "SELECT * FROM massoftware.i_EjercicioContable(?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, apertura, cierre, cerrado, cerradoModulos, comentario};

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


	public String update(EjercicioContable obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto EjercicioContable no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto EjercicioContable con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object apertura = ( obj.getApertura() == null ) ? java.util.Date.class : obj.getApertura();
		Object cierre = ( obj.getCierre() == null ) ? java.util.Date.class : obj.getCierre();
		Object cerrado = ( obj.getCerrado() == null ) ? Boolean.class : obj.getCerrado();
		Object cerradoModulos = ( obj.getCerradoModulos() == null ) ? Boolean.class : obj.getCerradoModulos();
		Object comentario = ( obj.getComentario() == null ) ? String.class : obj.getComentario();

		String sql = "SELECT * FROM massoftware.u_EjercicioContable(?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, apertura, cierre, cerrado, cerradoModulos, comentario};

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

			throw new IllegalArgumentException("Se esperaba un id (EjercicioContable.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_EjercicioContableById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (EjercicioContable.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_EjercicioContable_numero(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_EjercicioContable_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.EjercicioContable;";

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


	public List<EjercicioContable> findByNumero(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (EjercicioContable.numero) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº ejercicio

		if(UtilNumeric.isInteger(arg)) {

			EjercicioContableFiltro filtroNumero = new EjercicioContableFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<EjercicioContable> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		return new ArrayList<EjercicioContable>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public EjercicioContable findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public EjercicioContable findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (EjercicioContable.id) no nulo/vacio.");

		}


		id = id.trim();


		EjercicioContable obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_EjercicioContableById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 7) {

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


	public List<EjercicioContable> find(EjercicioContableFiltro filtro) throws Exception {

		List<EjercicioContable> listado = new ArrayList<EjercicioContable>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_EjercicioContable" + levelString + "(?, ?, ?, ?, ? , ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 7) {

				EjercicioContable obj = mapper7Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private EjercicioContable mapper7Fields(Object[] row) throws Exception {

		int c = -1;

		String idEjercicioContableArg0 = (String) row[++c];
		Integer numeroEjercicioContableArg1 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg2 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg3 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg4 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg5 = (Boolean) row[++c];
		String comentarioEjercicioContableArg6 = (String) row[++c];

		EjercicioContable obj = new EjercicioContable(idEjercicioContableArg0, numeroEjercicioContableArg1, aperturaEjercicioContableArg2, cierreEjercicioContableArg3, cerradoEjercicioContableArg4, cerradoModulosEjercicioContableArg5, comentarioEjercicioContableArg6);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------