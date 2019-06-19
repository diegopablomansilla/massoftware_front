package com.massoftware.service.geo;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.geo.CodigoPostal;

public class CodigoPostalService {

	private int levelDefault = 3;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(CodigoPostal obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto CodigoPostal no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object codigo = ( obj.getCodigo() == null ) ? String.class : obj.getCodigo();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombreCalle = ( obj.getNombreCalle() == null ) ? String.class : obj.getNombreCalle();
		Object numeroCalle = ( obj.getNumeroCalle() == null ) ? String.class : obj.getNumeroCalle();
		Object ciudad = ( obj.getCiudad() != null && obj.getCiudad().getId() != null) ? obj.getCiudad().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_CodigoPostal(?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, codigo, numero, nombreCalle, numeroCalle, ciudad};

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


	public String update(CodigoPostal obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto CodigoPostal no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto CodigoPostal con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object codigo = ( obj.getCodigo() == null ) ? String.class : obj.getCodigo();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombreCalle = ( obj.getNombreCalle() == null ) ? String.class : obj.getNombreCalle();
		Object numeroCalle = ( obj.getNumeroCalle() == null ) ? String.class : obj.getNumeroCalle();
		Object ciudad = ( obj.getCiudad() != null && obj.getCiudad().getId() != null) ? obj.getCiudad().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_CodigoPostal(?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, codigo, numero, nombreCalle, numeroCalle, ciudad};

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

			throw new IllegalArgumentException("Se esperaba un id (CodigoPostal.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_CodigoPostalById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (CodigoPostal.codigo) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_CodigoPostal_codigo(?)";

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

	public boolean isExistsNumero(Integer arg) throws Exception {


		if(arg == null || arg.toString().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un arg (CodigoPostal.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_CodigoPostal_numero(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_CodigoPostal_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.CodigoPostal;";

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


	public List<CodigoPostal> findByCodigoOrNumero(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (CodigoPostal.codigo o CodigoPostal.numero) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Código

		CodigoPostalFiltro filtroCodigo = new CodigoPostalFiltro();

		filtroCodigo.setUnlimited(true);

		filtroCodigo.setCodigo(arg);

		List<CodigoPostal> listadoCodigo = find(filtroCodigo);

		if(listadoCodigo.size() > 0) {

			return listadoCodigo;

		}


		//------------ buscar por Secuencia

		if(UtilNumeric.isInteger(arg)) {

			CodigoPostalFiltro filtroNumero = new CodigoPostalFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<CodigoPostal> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		return new ArrayList<CodigoPostal>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public CodigoPostal findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public CodigoPostal findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (CodigoPostal.id) no nulo/vacio.");

		}


		id = id.trim();


		CodigoPostal obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_CodigoPostalById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 6) {

				obj = mapper6Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 11) {

				obj = mapper11Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 18) {

				obj = mapper18Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 21) {

				obj = mapper21Fields(row);

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


	public List<CodigoPostal> find(CodigoPostalFiltro filtro) throws Exception {

		List<CodigoPostal> listado = new ArrayList<CodigoPostal>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_CodigoPostal" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?)";

		Object codigo = ( filtro.getCodigo() == null ) ? String.class : filtro.getCodigo();
		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object ciudad = ( filtro.getCiudad() != null && filtro.getCiudad().getId() != null) ? filtro.getCiudad().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, codigo, numeroFrom, numeroTo, ciudad};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), codigo, numeroFrom, numeroTo, ciudad};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 6) {

				CodigoPostal obj = mapper6Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 11) {

				CodigoPostal obj = mapper11Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 18) {

				CodigoPostal obj = mapper18Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 21) {

				CodigoPostal obj = mapper21Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CodigoPostal mapper6Fields(Object[] row) throws Exception {

		int c = -1;

		String idCodigoPostalArg0 = (String) row[++c];
		String codigoCodigoPostalArg1 = (String) row[++c];
		Integer numeroCodigoPostalArg2 = (Integer) row[++c];
		String nombreCalleCodigoPostalArg3 = (String) row[++c];
		String numeroCalleCodigoPostalArg4 = (String) row[++c];
		String ciudadCodigoPostalArg5 = (String) row[++c]; // Ciudad.id

		CodigoPostal obj = new CodigoPostal(idCodigoPostalArg0, codigoCodigoPostalArg1, numeroCodigoPostalArg2, nombreCalleCodigoPostalArg3, numeroCalleCodigoPostalArg4, ciudadCodigoPostalArg5);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CodigoPostal mapper11Fields(Object[] row) throws Exception {

		int c = -1;

		String idCodigoPostalArg0 = (String) row[++c];
		String codigoCodigoPostalArg1 = (String) row[++c];
		Integer numeroCodigoPostalArg2 = (Integer) row[++c];
		String nombreCalleCodigoPostalArg3 = (String) row[++c];
		String numeroCalleCodigoPostalArg4 = (String) row[++c];
		String idCiudadArg5 = (String) row[++c];
		Integer numeroCiudadArg6 = (Integer) row[++c];
		String nombreCiudadArg7 = (String) row[++c];
		String departamentoCiudadArg8 = (String) row[++c];
		Integer numeroAFIPCiudadArg9 = (Integer) row[++c];
		String provinciaCiudadArg10 = (String) row[++c]; // Provincia.id

		CodigoPostal obj = new CodigoPostal(idCodigoPostalArg0, codigoCodigoPostalArg1, numeroCodigoPostalArg2, nombreCalleCodigoPostalArg3, numeroCalleCodigoPostalArg4, idCiudadArg5, numeroCiudadArg6, nombreCiudadArg7, departamentoCiudadArg8, numeroAFIPCiudadArg9, provinciaCiudadArg10);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CodigoPostal mapper18Fields(Object[] row) throws Exception {

		int c = -1;

		String idCodigoPostalArg0 = (String) row[++c];
		String codigoCodigoPostalArg1 = (String) row[++c];
		Integer numeroCodigoPostalArg2 = (Integer) row[++c];
		String nombreCalleCodigoPostalArg3 = (String) row[++c];
		String numeroCalleCodigoPostalArg4 = (String) row[++c];
		String idCiudadArg5 = (String) row[++c];
		Integer numeroCiudadArg6 = (Integer) row[++c];
		String nombreCiudadArg7 = (String) row[++c];
		String departamentoCiudadArg8 = (String) row[++c];
		Integer numeroAFIPCiudadArg9 = (Integer) row[++c];
		String idProvinciaArg10 = (String) row[++c];
		Integer numeroProvinciaArg11 = (Integer) row[++c];
		String nombreProvinciaArg12 = (String) row[++c];
		String abreviaturaProvinciaArg13 = (String) row[++c];
		Integer numeroAFIPProvinciaArg14 = (Integer) row[++c];
		Integer numeroIngresosBrutosProvinciaArg15 = (Integer) row[++c];
		Integer numeroRENATEAProvinciaArg16 = (Integer) row[++c];
		String paisProvinciaArg17 = (String) row[++c]; // Pais.id

		CodigoPostal obj = new CodigoPostal(idCodigoPostalArg0, codigoCodigoPostalArg1, numeroCodigoPostalArg2, nombreCalleCodigoPostalArg3, numeroCalleCodigoPostalArg4, idCiudadArg5, numeroCiudadArg6, nombreCiudadArg7, departamentoCiudadArg8, numeroAFIPCiudadArg9, idProvinciaArg10, numeroProvinciaArg11, nombreProvinciaArg12, abreviaturaProvinciaArg13, numeroAFIPProvinciaArg14, numeroIngresosBrutosProvinciaArg15, numeroRENATEAProvinciaArg16, paisProvinciaArg17);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CodigoPostal mapper21Fields(Object[] row) throws Exception {

		int c = -1;

		String idCodigoPostalArg0 = (String) row[++c];
		String codigoCodigoPostalArg1 = (String) row[++c];
		Integer numeroCodigoPostalArg2 = (Integer) row[++c];
		String nombreCalleCodigoPostalArg3 = (String) row[++c];
		String numeroCalleCodigoPostalArg4 = (String) row[++c];
		String idCiudadArg5 = (String) row[++c];
		Integer numeroCiudadArg6 = (Integer) row[++c];
		String nombreCiudadArg7 = (String) row[++c];
		String departamentoCiudadArg8 = (String) row[++c];
		Integer numeroAFIPCiudadArg9 = (Integer) row[++c];
		String idProvinciaArg10 = (String) row[++c];
		Integer numeroProvinciaArg11 = (Integer) row[++c];
		String nombreProvinciaArg12 = (String) row[++c];
		String abreviaturaProvinciaArg13 = (String) row[++c];
		Integer numeroAFIPProvinciaArg14 = (Integer) row[++c];
		Integer numeroIngresosBrutosProvinciaArg15 = (Integer) row[++c];
		Integer numeroRENATEAProvinciaArg16 = (Integer) row[++c];
		String idPaisArg17 = (String) row[++c];
		Integer numeroPaisArg18 = (Integer) row[++c];
		String nombrePaisArg19 = (String) row[++c];
		String abreviaturaPaisArg20 = (String) row[++c];

		CodigoPostal obj = new CodigoPostal(idCodigoPostalArg0, codigoCodigoPostalArg1, numeroCodigoPostalArg2, nombreCalleCodigoPostalArg3, numeroCalleCodigoPostalArg4, idCiudadArg5, numeroCiudadArg6, nombreCiudadArg7, departamentoCiudadArg8, numeroAFIPCiudadArg9, idProvinciaArg10, numeroProvinciaArg11, nombreProvinciaArg12, abreviaturaProvinciaArg13, numeroAFIPProvinciaArg14, numeroIngresosBrutosProvinciaArg15, numeroRENATEAProvinciaArg16, idPaisArg17, numeroPaisArg18, nombrePaisArg19, abreviaturaPaisArg20);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------