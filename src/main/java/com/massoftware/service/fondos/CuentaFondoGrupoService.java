package com.massoftware.service.fondos;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.CuentaFondoGrupo;
import com.massoftware.service.UtilNumeric;

public class CuentaFondoGrupoService {

	private int levelDefault = 1;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(CuentaFondoGrupo obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto CuentaFondoGrupo no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object cuentaFondoRubro = ( obj.getCuentaFondoRubro() != null && obj.getCuentaFondoRubro().getId() != null) ? obj.getCuentaFondoRubro().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_CuentaFondoGrupo(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, cuentaFondoRubro};

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


	public String update(CuentaFondoGrupo obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto CuentaFondoGrupo no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto CuentaFondoGrupo con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object cuentaFondoRubro = ( obj.getCuentaFondoRubro() != null && obj.getCuentaFondoRubro().getId() != null) ? obj.getCuentaFondoRubro().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_CuentaFondoGrupo(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, cuentaFondoRubro};

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
			throw new IllegalArgumentException("Se esperaba un id (CuentaFondoGrupo.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_CuentaFondoGrupoById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (CuentaFondoGrupo.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_CuentaFondoGrupo_numero(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (CuentaFondoGrupo.nombre) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_CuentaFondoGrupo_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_CuentaFondoGrupo_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.CuentaFondoGrupo;";

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


	public List<CuentaFondoGrupo> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (CuentaFondoGrupo.numero o CuentaFondoGrupo.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº grupo

		if(UtilNumeric.isInteger(arg)) {

			CuentaFondoGrupoFiltro filtroNumero = new CuentaFondoGrupoFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<CuentaFondoGrupo> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		CuentaFondoGrupoFiltro filtroNombre = new CuentaFondoGrupoFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<CuentaFondoGrupo> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<CuentaFondoGrupo>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public CuentaFondoGrupo findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public CuentaFondoGrupo findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (CuentaFondoGrupo.id) no nulo/vacio.");
		}

		id = id.trim();

		CuentaFondoGrupo obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_CuentaFondoGrupoById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 4) {

				obj = mapper4Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 6) {

				obj = mapper6Fields(row);

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


	public List<CuentaFondoGrupo> find(CuentaFondoGrupoFiltro filtro) throws Exception {

		List<CuentaFondoGrupo> listado = new ArrayList<CuentaFondoGrupo>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_CuentaFondoGrupo" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();
		Object cuentaFondoRubro = ( filtro.getCuentaFondoRubro() != null && filtro.getCuentaFondoRubro().getId() != null) ? filtro.getCuentaFondoRubro().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre, cuentaFondoRubro};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre, cuentaFondoRubro};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 4) {

				CuentaFondoGrupo obj = mapper4Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 6) {

				CuentaFondoGrupo obj = mapper6Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CuentaFondoGrupo mapper4Fields(Object[] row) throws Exception {

		int c = -1;

		String idCuentaFondoGrupoArg0 = (String) row[++c];
		Integer numeroCuentaFondoGrupoArg1 = (Integer) row[++c];
		String nombreCuentaFondoGrupoArg2 = (String) row[++c];
		String cuentaFondoRubroCuentaFondoGrupoArg3 = (String) row[++c]; // CuentaFondoRubro.id

		CuentaFondoGrupo obj = new CuentaFondoGrupo(idCuentaFondoGrupoArg0, numeroCuentaFondoGrupoArg1, nombreCuentaFondoGrupoArg2, cuentaFondoRubroCuentaFondoGrupoArg3);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CuentaFondoGrupo mapper6Fields(Object[] row) throws Exception {

		int c = -1;

		String idCuentaFondoGrupoArg0 = (String) row[++c];
		Integer numeroCuentaFondoGrupoArg1 = (Integer) row[++c];
		String nombreCuentaFondoGrupoArg2 = (String) row[++c];
		String idCuentaFondoRubroArg3 = (String) row[++c];
		Integer numeroCuentaFondoRubroArg4 = (Integer) row[++c];
		String nombreCuentaFondoRubroArg5 = (String) row[++c];

		CuentaFondoGrupo obj = new CuentaFondoGrupo(idCuentaFondoGrupoArg0, numeroCuentaFondoGrupoArg1, nombreCuentaFondoGrupoArg2, idCuentaFondoRubroArg3, numeroCuentaFondoRubroArg4, nombreCuentaFondoRubroArg5);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------