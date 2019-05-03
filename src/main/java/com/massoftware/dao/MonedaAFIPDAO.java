package com.massoftware.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.dao.model.MonedaAFIPFiltro;
import com.massoftware.model.MonedaAFIP;

public class MonedaAFIPDAO {

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


	public boolean deleteById(String id) throws Exception {

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


	public MonedaAFIP findById(String id, Integer level) throws Exception {

		MonedaAFIP obj = null;

		level = (level == null || level < 0) ? 0 : level;
		level = (level != null && level > 3) ? 3 : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_MonedaAFIPById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 3) {

				obj = mapper3Fields(row);

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

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	// ---------------------------------------------------------------------------------------------------------------------------


	private MonedaAFIP mapper3Fields(Object[] row) {

		int c = -1;

		String idMonedaAFIPArg0 = (String) row[++c];
		String codigoMonedaAFIPArg1 = (String) row[++c];
		String nombreMonedaAFIPArg2 = (String) row[++c];

		MonedaAFIP obj = new MonedaAFIP(idMonedaAFIPArg0, codigoMonedaAFIPArg1, nombreMonedaAFIPArg2);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------