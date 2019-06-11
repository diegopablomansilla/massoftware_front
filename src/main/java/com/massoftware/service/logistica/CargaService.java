package com.massoftware.service.logistica;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.logistica.Carga;

public class CargaService {

	private int levelDefault = 3;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Carga obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Carga no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object transporte = ( obj.getTransporte() != null && obj.getTransporte().getId() != null) ? obj.getTransporte().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_Carga(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, transporte};

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


	public String update(Carga obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Carga no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto Carga con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object transporte = ( obj.getTransporte() != null && obj.getTransporte().getId() != null) ? obj.getTransporte().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_Carga(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, transporte};

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

			throw new IllegalArgumentException("Se esperaba un id (Carga.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_CargaById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Carga.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_Carga_numero(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Carga.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Carga_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_Carga_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.Carga;";

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


	public List<Carga> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Carga.numero o Carga.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº carga

		if(UtilNumeric.isInteger(arg)) {

			CargaFiltro filtroNumero = new CargaFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Carga> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		CargaFiltro filtroNombre = new CargaFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Carga> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Carga>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Carga findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Carga findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (Carga.id) no nulo/vacio.");

		}


		id = id.trim();


		Carga obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_CargaById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 4) {

				obj = mapper4Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 13) {

				obj = mapper13Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 18) {

				obj = mapper18Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 23) {

				obj = mapper23Fields(row);

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


	public List<Carga> find(CargaFiltro filtro) throws Exception {

		List<Carga> listado = new ArrayList<Carga>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_Carga" + levelString + "(?, ?, ?, ?, ?, ?, ?, ?)";

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

			if(row.length == 4) {

				Carga obj = mapper4Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 13) {

				Carga obj = mapper13Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 18) {

				Carga obj = mapper18Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 23) {

				Carga obj = mapper23Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Carga mapper4Fields(Object[] row) throws Exception {

		int c = -1;

		String idCargaArg0 = (String) row[++c];
		Integer numeroCargaArg1 = (Integer) row[++c];
		String nombreCargaArg2 = (String) row[++c];
		String transporteCargaArg3 = (String) row[++c]; // Transporte.id

		Carga obj = new Carga(idCargaArg0, numeroCargaArg1, nombreCargaArg2, transporteCargaArg3);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Carga mapper13Fields(Object[] row) throws Exception {

		int c = -1;

		String idCargaArg0 = (String) row[++c];
		Integer numeroCargaArg1 = (Integer) row[++c];
		String nombreCargaArg2 = (String) row[++c];
		String idTransporteArg3 = (String) row[++c];
		Integer numeroTransporteArg4 = (Integer) row[++c];
		String nombreTransporteArg5 = (String) row[++c];
		Long cuitTransporteArg6 = (Long) row[++c];
		String ingresosBrutosTransporteArg7 = (String) row[++c];
		String telefonoTransporteArg8 = (String) row[++c];
		String faxTransporteArg9 = (String) row[++c];
		String codigoPostalTransporteArg10 = (String) row[++c]; // CodigoPostal.id
		String domicilioTransporteArg11 = (String) row[++c];
		String comentarioTransporteArg12 = (String) row[++c];

		Carga obj = new Carga(idCargaArg0, numeroCargaArg1, nombreCargaArg2, idTransporteArg3, numeroTransporteArg4, nombreTransporteArg5, cuitTransporteArg6, ingresosBrutosTransporteArg7, telefonoTransporteArg8, faxTransporteArg9, codigoPostalTransporteArg10, domicilioTransporteArg11, comentarioTransporteArg12);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Carga mapper18Fields(Object[] row) throws Exception {

		int c = -1;

		String idCargaArg0 = (String) row[++c];
		Integer numeroCargaArg1 = (Integer) row[++c];
		String nombreCargaArg2 = (String) row[++c];
		String idTransporteArg3 = (String) row[++c];
		Integer numeroTransporteArg4 = (Integer) row[++c];
		String nombreTransporteArg5 = (String) row[++c];
		Long cuitTransporteArg6 = (Long) row[++c];
		String ingresosBrutosTransporteArg7 = (String) row[++c];
		String telefonoTransporteArg8 = (String) row[++c];
		String faxTransporteArg9 = (String) row[++c];
		String idCodigoPostalArg10 = (String) row[++c];
		String codigoCodigoPostalArg11 = (String) row[++c];
		Integer numeroCodigoPostalArg12 = (Integer) row[++c];
		String nombreCalleCodigoPostalArg13 = (String) row[++c];
		String numeroCalleCodigoPostalArg14 = (String) row[++c];
		String ciudadCodigoPostalArg15 = (String) row[++c]; // Ciudad.id
		String domicilioTransporteArg16 = (String) row[++c];
		String comentarioTransporteArg17 = (String) row[++c];

		Carga obj = new Carga(idCargaArg0, numeroCargaArg1, nombreCargaArg2, idTransporteArg3, numeroTransporteArg4, nombreTransporteArg5, cuitTransporteArg6, ingresosBrutosTransporteArg7, telefonoTransporteArg8, faxTransporteArg9, idCodigoPostalArg10, codigoCodigoPostalArg11, numeroCodigoPostalArg12, nombreCalleCodigoPostalArg13, numeroCalleCodigoPostalArg14, ciudadCodigoPostalArg15, domicilioTransporteArg16, comentarioTransporteArg17);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Carga mapper23Fields(Object[] row) throws Exception {

		int c = -1;

		String idCargaArg0 = (String) row[++c];
		Integer numeroCargaArg1 = (Integer) row[++c];
		String nombreCargaArg2 = (String) row[++c];
		String idTransporteArg3 = (String) row[++c];
		Integer numeroTransporteArg4 = (Integer) row[++c];
		String nombreTransporteArg5 = (String) row[++c];
		Long cuitTransporteArg6 = (Long) row[++c];
		String ingresosBrutosTransporteArg7 = (String) row[++c];
		String telefonoTransporteArg8 = (String) row[++c];
		String faxTransporteArg9 = (String) row[++c];
		String idCodigoPostalArg10 = (String) row[++c];
		String codigoCodigoPostalArg11 = (String) row[++c];
		Integer numeroCodigoPostalArg12 = (Integer) row[++c];
		String nombreCalleCodigoPostalArg13 = (String) row[++c];
		String numeroCalleCodigoPostalArg14 = (String) row[++c];
		String idCiudadArg15 = (String) row[++c];
		Integer numeroCiudadArg16 = (Integer) row[++c];
		String nombreCiudadArg17 = (String) row[++c];
		String departamentoCiudadArg18 = (String) row[++c];
		Integer numeroAFIPCiudadArg19 = (Integer) row[++c];
		String provinciaCiudadArg20 = (String) row[++c]; // Provincia.id
		String domicilioTransporteArg21 = (String) row[++c];
		String comentarioTransporteArg22 = (String) row[++c];

		Carga obj = new Carga(idCargaArg0, numeroCargaArg1, nombreCargaArg2, idTransporteArg3, numeroTransporteArg4, nombreTransporteArg5, cuitTransporteArg6, ingresosBrutosTransporteArg7, telefonoTransporteArg8, faxTransporteArg9, idCodigoPostalArg10, codigoCodigoPostalArg11, numeroCodigoPostalArg12, nombreCalleCodigoPostalArg13, numeroCalleCodigoPostalArg14, idCiudadArg15, numeroCiudadArg16, nombreCiudadArg17, departamentoCiudadArg18, numeroAFIPCiudadArg19, provinciaCiudadArg20, domicilioTransporteArg21, comentarioTransporteArg22);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------