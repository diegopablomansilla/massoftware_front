package com.massoftware.dao.geo;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.geo.Ciudad;

public class CiudadDAO {

	private int levelDefault = 2;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Ciudad obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Ciudad no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object departamento = ( obj.getDepartamento() == null ) ? String.class : obj.getDepartamento();
		Object numeroAFIP = ( obj.getNumeroAFIP() == null ) ? Integer.class : obj.getNumeroAFIP();
		Object provincia = ( obj.getProvincia() != null && obj.getProvincia().getId() != null) ? obj.getProvincia().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_Ciudad(?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, departamento, numeroAFIP, provincia};

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


	public String update(Ciudad obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Ciudad no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto Ciudad con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object departamento = ( obj.getDepartamento() == null ) ? String.class : obj.getDepartamento();
		Object numeroAFIP = ( obj.getNumeroAFIP() == null ) ? Integer.class : obj.getNumeroAFIP();
		Object provincia = ( obj.getProvincia() != null && obj.getProvincia().getId() != null) ? obj.getProvincia().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_Ciudad(?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, departamento, numeroAFIP, provincia};

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

			throw new IllegalArgumentException("Se esperaba un id (Ciudad.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_CiudadById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Ciudad.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_Ciudad_numero(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Ciudad.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Ciudad_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_Ciudad_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueNumeroAFIP() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Ciudad_numeroAFIP()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.Ciudad;";

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


	public List<Ciudad> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Ciudad.numero o Ciudad.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº ciudad

		if(UtilNumeric.isInteger(arg)) {

			CiudadFiltro filtroNumero = new CiudadFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Ciudad> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		CiudadFiltro filtroNombre = new CiudadFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Ciudad> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Ciudad>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Ciudad findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Ciudad findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (Ciudad.id) no nulo/vacio.");

		}


		id = id.trim();


		Ciudad obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_CiudadById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 5) {

				obj = mapper5Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 12) {

				obj = mapper12Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 16) {

				obj = mapper16Fields(row);

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


	public List<Ciudad> find(CiudadFiltro filtro) throws Exception {

		List<Ciudad> listado = new ArrayList<Ciudad>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";
		String orderByString = (filtro.getOrderBy() == null || filtro.getOrderBy().equals("id")) ? "" : "_" + filtro.getOrderBy();
		String orderByASCString = "";
		if(orderByString != null && orderByString.trim().length() > 0) {

			orderByString = "Ciudad" + orderByString;
			orderByASCString = "_asc_";
			if(filtro.getOrderByDesc() == true) {
				orderByASCString = "_des_";
			}
			orderByString = orderByASCString + orderByString;
		}
		String params = (filtro.getUnlimited() == true) ? "" : "?, ?, ";

		String sql = "SELECT * FROM massoftware.f_Ciudad" + orderByString + levelString + "(" + params + "?, ?, ?, ?, ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();

		String[] nombreWords = ( filtro.getNombre() == null ) ? new String[0] : filtro.getNombre().split(" ");
		Object nombreWord0 = ( nombreWords.length > 0 && nombreWords[0].trim().length() > 0) ? nombreWords[0].trim() : String.class;
		Object nombreWord1 = ( nombreWords.length > 1 && nombreWords[1].trim().length() > 0) ? nombreWords[1].trim() : String.class;
		Object nombreWord2 = ( nombreWords.length > 2 && nombreWords[2].trim().length() > 0) ? nombreWords[2].trim() : String.class;
		Object nombreWord3 = ( nombreWords.length > 3 && nombreWords[3].trim().length() > 0) ? nombreWords[3].trim() : String.class;
		Object nombreWord4 = ( nombreWords.length > 4 && nombreWords[4].trim().length() > 0) ? nombreWords[4].trim() : String.class;
		Object provincia = ( filtro.getProvincia() != null && filtro.getProvincia().getId() != null) ? filtro.getProvincia().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {numeroFrom, numeroTo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4, provincia};
		} else {
			args = new Object[] {filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4, provincia};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 5) {

				Ciudad obj = mapper5Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 12) {

				Ciudad obj = mapper12Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 16) {

				Ciudad obj = mapper16Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Ciudad mapper5Fields(Object[] row) throws Exception {

		int c = -1;

		String idCiudadArg0 = (String) row[++c];
		Integer numeroCiudadArg1 = (Integer) row[++c];
		String nombreCiudadArg2 = (String) row[++c];
		String departamentoCiudadArg3 = (String) row[++c];
		Integer numeroAFIPCiudadArg4 = (Integer) row[++c];

		Ciudad obj = new Ciudad(idCiudadArg0, numeroCiudadArg1, nombreCiudadArg2, departamentoCiudadArg3, numeroAFIPCiudadArg4);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Ciudad mapper12Fields(Object[] row) throws Exception {

		int c = -1;

		String idCiudadArg0 = (String) row[++c];
		Integer numeroCiudadArg1 = (Integer) row[++c];
		String nombreCiudadArg2 = (String) row[++c];
		String departamentoCiudadArg3 = (String) row[++c];
		Integer numeroAFIPCiudadArg4 = (Integer) row[++c];
		String idProvinciaArg5 = (String) row[++c];
		Integer numeroProvinciaArg6 = (Integer) row[++c];
		String nombreProvinciaArg7 = (String) row[++c];
		String abreviaturaProvinciaArg8 = (String) row[++c];
		Integer numeroAFIPProvinciaArg9 = (Integer) row[++c];
		Integer numeroIngresosBrutosProvinciaArg10 = (Integer) row[++c];
		Integer numeroRENATEAProvinciaArg11 = (Integer) row[++c];

		Ciudad obj = new Ciudad(idCiudadArg0, numeroCiudadArg1, nombreCiudadArg2, departamentoCiudadArg3, numeroAFIPCiudadArg4, idProvinciaArg5, numeroProvinciaArg6, nombreProvinciaArg7, abreviaturaProvinciaArg8, numeroAFIPProvinciaArg9, numeroIngresosBrutosProvinciaArg10, numeroRENATEAProvinciaArg11);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Ciudad mapper16Fields(Object[] row) throws Exception {

		int c = -1;

		String idCiudadArg0 = (String) row[++c];
		Integer numeroCiudadArg1 = (Integer) row[++c];
		String nombreCiudadArg2 = (String) row[++c];
		String departamentoCiudadArg3 = (String) row[++c];
		Integer numeroAFIPCiudadArg4 = (Integer) row[++c];
		String idProvinciaArg5 = (String) row[++c];
		Integer numeroProvinciaArg6 = (Integer) row[++c];
		String nombreProvinciaArg7 = (String) row[++c];
		String abreviaturaProvinciaArg8 = (String) row[++c];
		Integer numeroAFIPProvinciaArg9 = (Integer) row[++c];
		Integer numeroIngresosBrutosProvinciaArg10 = (Integer) row[++c];
		Integer numeroRENATEAProvinciaArg11 = (Integer) row[++c];
		String idPaisArg12 = (String) row[++c];
		Integer numeroPaisArg13 = (Integer) row[++c];
		String nombrePaisArg14 = (String) row[++c];
		String abreviaturaPaisArg15 = (String) row[++c];

		Ciudad obj = new Ciudad(idCiudadArg0, numeroCiudadArg1, nombreCiudadArg2, departamentoCiudadArg3, numeroAFIPCiudadArg4, idProvinciaArg5, numeroProvinciaArg6, nombreProvinciaArg7, abreviaturaProvinciaArg8, numeroAFIPProvinciaArg9, numeroIngresosBrutosProvinciaArg10, numeroRENATEAProvinciaArg11, idPaisArg12, numeroPaisArg13, nombrePaisArg14, abreviaturaPaisArg15);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------