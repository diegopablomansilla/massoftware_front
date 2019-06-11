package com.massoftware.service.empresa;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.empresa.DepositoModulo;

public class DepositoModuloService {

	private int levelDefault = 0;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(DepositoModulo obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto DepositoModulo no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();

		String sql = "SELECT * FROM massoftware.i_DepositoModulo(?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre};

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


	public String update(DepositoModulo obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto DepositoModulo no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto DepositoModulo con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();

		String sql = "SELECT * FROM massoftware.u_DepositoModulo(?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre};

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

			throw new IllegalArgumentException("Se esperaba un id (DepositoModulo.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_DepositoModuloById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (DepositoModulo.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_DepositoModulo_numero(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (DepositoModulo.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_DepositoModulo_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_DepositoModulo_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.DepositoModulo;";

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


	public List<DepositoModulo> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (DepositoModulo.numero o DepositoModulo.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº módulo

		if(UtilNumeric.isInteger(arg)) {

			DepositoModuloFiltro filtroNumero = new DepositoModuloFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<DepositoModulo> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		DepositoModuloFiltro filtroNombre = new DepositoModuloFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<DepositoModulo> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<DepositoModulo>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public DepositoModulo findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public DepositoModulo findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (DepositoModulo.id) no nulo/vacio.");

		}


		id = id.trim();


		DepositoModulo obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_DepositoModuloById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 3) {

				obj = mapper3Fields(row);

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


	public List<DepositoModulo> find(DepositoModuloFiltro filtro) throws Exception {

		List<DepositoModulo> listado = new ArrayList<DepositoModulo>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_DepositoModulo" + levelString + "(?, ?, ?, ?, ?, ?, ?, ?)";

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

			if(row.length == 3) {

				DepositoModulo obj = mapper3Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private DepositoModulo mapper3Fields(Object[] row) throws Exception {

		int c = -1;

		String idDepositoModuloArg0 = (String) row[++c];
		Integer numeroDepositoModuloArg1 = (Integer) row[++c];
		String nombreDepositoModuloArg2 = (String) row[++c];

		DepositoModulo obj = new DepositoModulo(idDepositoModuloArg0, numeroDepositoModuloArg1, nombreDepositoModuloArg2);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------