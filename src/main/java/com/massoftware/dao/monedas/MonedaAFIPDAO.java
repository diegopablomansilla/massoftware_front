package com.massoftware.dao.monedas;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.monedas.MonedaAFIP;

public class MonedaAFIPDAO {

	private int levelDefault = 0;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(MonedaAFIP obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto MonedaAFIP no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object codigo = ( obj.getCodigo() == null ) ? String.class : obj.getCodigo();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();

		String sql = "SELECT * FROM massoftware.i_MonedaAFIP(?, ?, ?)";

		Object[] args = new Object[] {id, codigo, nombre};

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


	public String update(MonedaAFIP obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto MonedaAFIP no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto MonedaAFIP con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object codigo = ( obj.getCodigo() == null ) ? String.class : obj.getCodigo();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();

		String sql = "SELECT * FROM massoftware.u_MonedaAFIP(?, ?, ?)";

		Object[] args = new Object[] {id, codigo, nombre};

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

			throw new IllegalArgumentException("Se esperaba un id (MonedaAFIP.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_MonedaAFIPById(?)";

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


	public boolean isExistsCodigo(String arg) throws Exception {


		if(arg == null || arg.toString().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un arg (MonedaAFIP.codigo) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_MonedaAFIP_codigo(?)";

		Object[] args = new Object[] {arg};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Boolean) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public boolean isExistsNombre(String arg) throws Exception {


		if(arg == null || arg.toString().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un arg (MonedaAFIP.nombre) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_MonedaAFIP_nombre(?)";

		Object[] args = new Object[] {arg};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Boolean) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	// ---------------------------------------------------------------------------------------------------------------------------


	public Long count() throws Exception {

		String sql = "SELECT COUNT(*) FROM massoftware.MonedaAFIP;";

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


	public List<MonedaAFIP> findByCodigoOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (MonedaAFIP.codigo o MonedaAFIP.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Código

		MonedaAFIPFiltro filtroCodigo = new MonedaAFIPFiltro();

		filtroCodigo.setUnlimited(true);

		filtroCodigo.setCodigo(arg);

		List<MonedaAFIP> listadoCodigo = find(filtroCodigo);

		if(listadoCodigo.size() > 0) {

			return listadoCodigo;

		}


		//------------ buscar por Nombre

		MonedaAFIPFiltro filtroNombre = new MonedaAFIPFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<MonedaAFIP> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<MonedaAFIP>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public MonedaAFIP findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public MonedaAFIP findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (MonedaAFIP.id) no nulo/vacio.");

		}


		id = id.trim();


		MonedaAFIP obj = null;

		level = (level == null || level < 0) ? levelDefault : level;
		level = (level != null && level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_MonedaAFIPById" + levelString + "(?)";

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


	public List<MonedaAFIP> find(MonedaAFIPFiltro filtro) throws Exception {

		List<MonedaAFIP> listado = new ArrayList<MonedaAFIP>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";
		String orderByString = (filtro.getOrderBy() == null) ? "" : "_" + filtro.getOrderBy();
		String params = (filtro.getUnlimited() == true) ? "" : "?, ?, ";

		String sql = "SELECT * FROM massoftware.f_MonedaAFIP" + orderByString + levelString + "(" + params + "?, ?, ?, ?, ?, ?)";

		Object codigo = ( filtro.getCodigo() == null ) ? String.class : filtro.getCodigo();

		String[] nombreWords = ( filtro.getNombre() == null ) ? new String[0] : filtro.getNombre().split(" ");
		Object nombreWord0 = ( nombreWords.length > 0 && nombreWords[0].trim().length() > 0) ? nombreWords[0].trim() : String.class;
		Object nombreWord1 = ( nombreWords.length > 1 && nombreWords[1].trim().length() > 0) ? nombreWords[1].trim() : String.class;
		Object nombreWord2 = ( nombreWords.length > 2 && nombreWords[2].trim().length() > 0) ? nombreWords[2].trim() : String.class;
		Object nombreWord3 = ( nombreWords.length > 3 && nombreWords[3].trim().length() > 0) ? nombreWords[3].trim() : String.class;
		Object nombreWord4 = ( nombreWords.length > 4 && nombreWords[4].trim().length() > 0) ? nombreWords[4].trim() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {codigo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4};
		} else {
			args = new Object[] {filtro.getLimit(), filtro.getOffset(), codigo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 3) {

				MonedaAFIP obj = mapper3Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private MonedaAFIP mapper3Fields(Object[] row) throws Exception {

		int c = -1;

		String idMonedaAFIPArg0 = (String) row[++c];
		String codigoMonedaAFIPArg1 = (String) row[++c];
		String nombreMonedaAFIPArg2 = (String) row[++c];

		MonedaAFIP obj = new MonedaAFIP(idMonedaAFIPArg0, codigoMonedaAFIPArg1, nombreMonedaAFIPArg2);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------