package com.massoftware.dao.geo;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.geo.Pais;

public class PaisDAO {

	private int levelDefault = 0;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Pais obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Pais no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();

		String sql = "SELECT * FROM massoftware.i_Pais(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura};

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


	public String update(Pais obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Pais no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto Pais con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();

		String sql = "SELECT * FROM massoftware.u_Pais(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura};

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

			throw new IllegalArgumentException("Se esperaba un id (Pais.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_PaisById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Pais.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_Pais_numero(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Pais.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Pais_nombre(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Pais.abreviatura) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Pais_abreviatura(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_Pais_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.Pais;";

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


	public List<Pais> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Pais.numero o Pais.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº país

		if(UtilNumeric.isInteger(arg)) {

			PaisFiltro filtroNumero = new PaisFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Pais> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		PaisFiltro filtroNombre = new PaisFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Pais> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Pais>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Pais findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Pais findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (Pais.id) no nulo/vacio.");

		}


		id = id.trim();


		Pais obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_PaisById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 4) {

				obj = mapper4Fields(row);

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


	public List<Pais> find(PaisFiltro filtro) throws Exception {

		List<Pais> listado = new ArrayList<Pais>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";
		String orderByString = (filtro.getOrderBy() == null || filtro.getOrderBy().equals("id")) ? "" : "_" + filtro.getOrderBy();
		String orderByASCString = "";
		if(orderByString != null && orderByString.trim().length() > 0) {

			orderByString = "Pais" + orderByString;
			orderByASCString = "_asc_";
			if(filtro.getOrderByDesc() == true) {
				orderByASCString = "_des_";
			}
			orderByString = orderByASCString + orderByString;
		}
		String params = (filtro.getUnlimited() == true) ? "" : "?, ?, ";

		String sql = "SELECT * FROM massoftware.f_Pais" + orderByString + levelString + "(" + params + "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();

		String[] nombreWords = ( filtro.getNombre() == null ) ? new String[0] : filtro.getNombre().split(" ");
		Object nombreWord0 = ( nombreWords.length > 0 && nombreWords[0].trim().length() > 0) ? nombreWords[0].trim() : String.class;
		Object nombreWord1 = ( nombreWords.length > 1 && nombreWords[1].trim().length() > 0) ? nombreWords[1].trim() : String.class;
		Object nombreWord2 = ( nombreWords.length > 2 && nombreWords[2].trim().length() > 0) ? nombreWords[2].trim() : String.class;
		Object nombreWord3 = ( nombreWords.length > 3 && nombreWords[3].trim().length() > 0) ? nombreWords[3].trim() : String.class;
		Object nombreWord4 = ( nombreWords.length > 4 && nombreWords[4].trim().length() > 0) ? nombreWords[4].trim() : String.class;

		String[] abreviaturaWords = ( filtro.getAbreviatura() == null ) ? new String[0] : filtro.getAbreviatura().split(" ");
		Object abreviaturaWord0 = ( abreviaturaWords.length > 0 && abreviaturaWords[0].trim().length() > 0) ? abreviaturaWords[0].trim() : String.class;
		Object abreviaturaWord1 = ( abreviaturaWords.length > 1 && abreviaturaWords[1].trim().length() > 0) ? abreviaturaWords[1].trim() : String.class;
		Object abreviaturaWord2 = ( abreviaturaWords.length > 2 && abreviaturaWords[2].trim().length() > 0) ? abreviaturaWords[2].trim() : String.class;
		Object abreviaturaWord3 = ( abreviaturaWords.length > 3 && abreviaturaWords[3].trim().length() > 0) ? abreviaturaWords[3].trim() : String.class;
		Object abreviaturaWord4 = ( abreviaturaWords.length > 4 && abreviaturaWords[4].trim().length() > 0) ? abreviaturaWords[4].trim() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {numeroFrom, numeroTo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4, abreviaturaWord0, abreviaturaWord1, abreviaturaWord2, abreviaturaWord3, abreviaturaWord4};
		} else {
			args = new Object[] {filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4, abreviaturaWord0, abreviaturaWord1, abreviaturaWord2, abreviaturaWord3, abreviaturaWord4};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 4) {

				Pais obj = mapper4Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Pais mapper4Fields(Object[] row) throws Exception {

		int c = -1;

		String idPaisArg0 = (String) row[++c];
		Integer numeroPaisArg1 = (Integer) row[++c];
		String nombrePaisArg2 = (String) row[++c];
		String abreviaturaPaisArg3 = (String) row[++c];

		Pais obj = new Pais(idPaisArg0, numeroPaisArg1, nombrePaisArg2, abreviaturaPaisArg3);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------