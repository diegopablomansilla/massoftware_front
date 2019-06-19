package com.massoftware.service.contabilidad;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.CentroCostoContable;

public class CentroCostoContableService {

	private int levelDefault = 1;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(CentroCostoContable obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto CentroCostoContable no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_CentroCostoContable(?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura, ejercicioContable};

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


	public String update(CentroCostoContable obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto CentroCostoContable no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto CentroCostoContable con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_CentroCostoContable(?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura, ejercicioContable};

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

			throw new IllegalArgumentException("Se esperaba un id (CentroCostoContable.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_CentroCostoContableById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (CentroCostoContable.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_CentroCostoContable_numero(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (CentroCostoContable.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_CentroCostoContable_nombre(?)";

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

	public boolean isExistsAbreviatura(String arg) throws Exception {


		if(arg == null || arg.toString().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un arg (CentroCostoContable.abreviatura) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_CentroCostoContable_abreviatura(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_CentroCostoContable_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.CentroCostoContable;";

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


	public List<CentroCostoContable> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (CentroCostoContable.numero o CentroCostoContable.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº cc

		if(UtilNumeric.isInteger(arg)) {

			CentroCostoContableFiltro filtroNumero = new CentroCostoContableFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<CentroCostoContable> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		CentroCostoContableFiltro filtroNombre = new CentroCostoContableFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<CentroCostoContable> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<CentroCostoContable>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public CentroCostoContable findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public CentroCostoContable findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (CentroCostoContable.id) no nulo/vacio.");

		}


		id = id.trim();


		CentroCostoContable obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_CentroCostoContableById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 5) {

				obj = mapper5Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 11) {

				obj = mapper11Fields(row);

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


	public List<CentroCostoContable> find(CentroCostoContableFiltro filtro) throws Exception {

		List<CentroCostoContable> listado = new ArrayList<CentroCostoContable>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_CentroCostoContable" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();
		Object abreviatura = ( filtro.getAbreviatura() == null ) ? String.class : filtro.getAbreviatura();
		Object ejercicioContable = ( filtro.getEjercicioContable() != null && filtro.getEjercicioContable().getId() != null) ? filtro.getEjercicioContable().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre, abreviatura, ejercicioContable};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre, abreviatura, ejercicioContable};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 5) {

				CentroCostoContable obj = mapper5Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 11) {

				CentroCostoContable obj = mapper11Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CentroCostoContable mapper5Fields(Object[] row) throws Exception {

		int c = -1;

		String idCentroCostoContableArg0 = (String) row[++c];
		Integer numeroCentroCostoContableArg1 = (Integer) row[++c];
		String nombreCentroCostoContableArg2 = (String) row[++c];
		String abreviaturaCentroCostoContableArg3 = (String) row[++c];
		String ejercicioContableCentroCostoContableArg4 = (String) row[++c]; // EjercicioContable.id

		CentroCostoContable obj = new CentroCostoContable(idCentroCostoContableArg0, numeroCentroCostoContableArg1, nombreCentroCostoContableArg2, abreviaturaCentroCostoContableArg3, ejercicioContableCentroCostoContableArg4);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CentroCostoContable mapper11Fields(Object[] row) throws Exception {

		int c = -1;

		String idCentroCostoContableArg0 = (String) row[++c];
		Integer numeroCentroCostoContableArg1 = (Integer) row[++c];
		String nombreCentroCostoContableArg2 = (String) row[++c];
		String abreviaturaCentroCostoContableArg3 = (String) row[++c];
		String idEjercicioContableArg4 = (String) row[++c];
		Integer numeroEjercicioContableArg5 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg6 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg7 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg8 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg9 = (Boolean) row[++c];
		String comentarioEjercicioContableArg10 = (String) row[++c];

		CentroCostoContable obj = new CentroCostoContable(idCentroCostoContableArg0, numeroCentroCostoContableArg1, nombreCentroCostoContableArg2, abreviaturaCentroCostoContableArg3, idEjercicioContableArg4, numeroEjercicioContableArg5, aperturaEjercicioContableArg6, cierreEjercicioContableArg7, cerradoEjercicioContableArg8, cerradoModulosEjercicioContableArg9, comentarioEjercicioContableArg10);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------