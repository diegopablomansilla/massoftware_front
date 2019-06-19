package com.massoftware.service.logistica;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.logistica.Transporte;

public class TransporteService {

	private int levelDefault = 3;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Transporte obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Transporte no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object cuit = ( obj.getCuit() == null ) ? Long.class : obj.getCuit();
		Object ingresosBrutos = ( obj.getIngresosBrutos() == null ) ? String.class : obj.getIngresosBrutos();
		Object telefono = ( obj.getTelefono() == null ) ? String.class : obj.getTelefono();
		Object fax = ( obj.getFax() == null ) ? String.class : obj.getFax();
		Object codigoPostal = ( obj.getCodigoPostal() != null && obj.getCodigoPostal().getId() != null) ? obj.getCodigoPostal().getId() : String.class;
		Object domicilio = ( obj.getDomicilio() == null ) ? String.class : obj.getDomicilio();
		Object comentario = ( obj.getComentario() == null ) ? String.class : obj.getComentario();

		String sql = "SELECT * FROM massoftware.i_Transporte(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, cuit, ingresosBrutos, telefono, fax, codigoPostal, domicilio, comentario};

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


	public String update(Transporte obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Transporte no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto Transporte con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object cuit = ( obj.getCuit() == null ) ? Long.class : obj.getCuit();
		Object ingresosBrutos = ( obj.getIngresosBrutos() == null ) ? String.class : obj.getIngresosBrutos();
		Object telefono = ( obj.getTelefono() == null ) ? String.class : obj.getTelefono();
		Object fax = ( obj.getFax() == null ) ? String.class : obj.getFax();
		Object codigoPostal = ( obj.getCodigoPostal() != null && obj.getCodigoPostal().getId() != null) ? obj.getCodigoPostal().getId() : String.class;
		Object domicilio = ( obj.getDomicilio() == null ) ? String.class : obj.getDomicilio();
		Object comentario = ( obj.getComentario() == null ) ? String.class : obj.getComentario();

		String sql = "SELECT * FROM massoftware.u_Transporte(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, cuit, ingresosBrutos, telefono, fax, codigoPostal, domicilio, comentario};

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

			throw new IllegalArgumentException("Se esperaba un id (Transporte.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_TransporteById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Transporte.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_Transporte_numero(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Transporte.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Transporte_nombre(?)";

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

	public boolean isExistsCuit(Long arg) throws Exception {


		if(arg == null || arg.toString().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un arg (Transporte.cuit) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_Transporte_cuit(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_Transporte_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Long nextValueCuit() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Transporte_cuit()";

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


	public Long count() throws Exception {

		String sql = "SELECT COUNT(*) FROM massoftware.Transporte;";

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


	public List<Transporte> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Transporte.numero o Transporte.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº transporte

		if(UtilNumeric.isInteger(arg)) {

			TransporteFiltro filtroNumero = new TransporteFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Transporte> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		TransporteFiltro filtroNombre = new TransporteFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Transporte> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Transporte>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Transporte findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Transporte findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (Transporte.id) no nulo/vacio.");

		}


		id = id.trim();


		Transporte obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_TransporteById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 10) {

				obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 15) {

				obj = mapper15Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 20) {

				obj = mapper20Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 27) {

				obj = mapper27Fields(row);

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


	public List<Transporte> find(TransporteFiltro filtro) throws Exception {

		List<Transporte> listado = new ArrayList<Transporte>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_Transporte" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?)";

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

			if(row.length == 10) {

				Transporte obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 15) {

				Transporte obj = mapper15Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 20) {

				Transporte obj = mapper20Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 27) {

				Transporte obj = mapper27Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Transporte mapper10Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteArg0 = (String) row[++c];
		Integer numeroTransporteArg1 = (Integer) row[++c];
		String nombreTransporteArg2 = (String) row[++c];
		Long cuitTransporteArg3 = (Long) row[++c];
		String ingresosBrutosTransporteArg4 = (String) row[++c];
		String telefonoTransporteArg5 = (String) row[++c];
		String faxTransporteArg6 = (String) row[++c];
		String codigoPostalTransporteArg7 = (String) row[++c]; // CodigoPostal.id
		String domicilioTransporteArg8 = (String) row[++c];
		String comentarioTransporteArg9 = (String) row[++c];

		Transporte obj = new Transporte(idTransporteArg0, numeroTransporteArg1, nombreTransporteArg2, cuitTransporteArg3, ingresosBrutosTransporteArg4, telefonoTransporteArg5, faxTransporteArg6, codigoPostalTransporteArg7, domicilioTransporteArg8, comentarioTransporteArg9);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Transporte mapper15Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteArg0 = (String) row[++c];
		Integer numeroTransporteArg1 = (Integer) row[++c];
		String nombreTransporteArg2 = (String) row[++c];
		Long cuitTransporteArg3 = (Long) row[++c];
		String ingresosBrutosTransporteArg4 = (String) row[++c];
		String telefonoTransporteArg5 = (String) row[++c];
		String faxTransporteArg6 = (String) row[++c];
		String idCodigoPostalArg7 = (String) row[++c];
		String codigoCodigoPostalArg8 = (String) row[++c];
		Integer numeroCodigoPostalArg9 = (Integer) row[++c];
		String nombreCalleCodigoPostalArg10 = (String) row[++c];
		String numeroCalleCodigoPostalArg11 = (String) row[++c];
		String ciudadCodigoPostalArg12 = (String) row[++c]; // Ciudad.id
		String domicilioTransporteArg13 = (String) row[++c];
		String comentarioTransporteArg14 = (String) row[++c];

		Transporte obj = new Transporte(idTransporteArg0, numeroTransporteArg1, nombreTransporteArg2, cuitTransporteArg3, ingresosBrutosTransporteArg4, telefonoTransporteArg5, faxTransporteArg6, idCodigoPostalArg7, codigoCodigoPostalArg8, numeroCodigoPostalArg9, nombreCalleCodigoPostalArg10, numeroCalleCodigoPostalArg11, ciudadCodigoPostalArg12, domicilioTransporteArg13, comentarioTransporteArg14);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Transporte mapper20Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteArg0 = (String) row[++c];
		Integer numeroTransporteArg1 = (Integer) row[++c];
		String nombreTransporteArg2 = (String) row[++c];
		Long cuitTransporteArg3 = (Long) row[++c];
		String ingresosBrutosTransporteArg4 = (String) row[++c];
		String telefonoTransporteArg5 = (String) row[++c];
		String faxTransporteArg6 = (String) row[++c];
		String idCodigoPostalArg7 = (String) row[++c];
		String codigoCodigoPostalArg8 = (String) row[++c];
		Integer numeroCodigoPostalArg9 = (Integer) row[++c];
		String nombreCalleCodigoPostalArg10 = (String) row[++c];
		String numeroCalleCodigoPostalArg11 = (String) row[++c];
		String idCiudadArg12 = (String) row[++c];
		Integer numeroCiudadArg13 = (Integer) row[++c];
		String nombreCiudadArg14 = (String) row[++c];
		String departamentoCiudadArg15 = (String) row[++c];
		Integer numeroAFIPCiudadArg16 = (Integer) row[++c];
		String provinciaCiudadArg17 = (String) row[++c]; // Provincia.id
		String domicilioTransporteArg18 = (String) row[++c];
		String comentarioTransporteArg19 = (String) row[++c];

		Transporte obj = new Transporte(idTransporteArg0, numeroTransporteArg1, nombreTransporteArg2, cuitTransporteArg3, ingresosBrutosTransporteArg4, telefonoTransporteArg5, faxTransporteArg6, idCodigoPostalArg7, codigoCodigoPostalArg8, numeroCodigoPostalArg9, nombreCalleCodigoPostalArg10, numeroCalleCodigoPostalArg11, idCiudadArg12, numeroCiudadArg13, nombreCiudadArg14, departamentoCiudadArg15, numeroAFIPCiudadArg16, provinciaCiudadArg17, domicilioTransporteArg18, comentarioTransporteArg19);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Transporte mapper27Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteArg0 = (String) row[++c];
		Integer numeroTransporteArg1 = (Integer) row[++c];
		String nombreTransporteArg2 = (String) row[++c];
		Long cuitTransporteArg3 = (Long) row[++c];
		String ingresosBrutosTransporteArg4 = (String) row[++c];
		String telefonoTransporteArg5 = (String) row[++c];
		String faxTransporteArg6 = (String) row[++c];
		String idCodigoPostalArg7 = (String) row[++c];
		String codigoCodigoPostalArg8 = (String) row[++c];
		Integer numeroCodigoPostalArg9 = (Integer) row[++c];
		String nombreCalleCodigoPostalArg10 = (String) row[++c];
		String numeroCalleCodigoPostalArg11 = (String) row[++c];
		String idCiudadArg12 = (String) row[++c];
		Integer numeroCiudadArg13 = (Integer) row[++c];
		String nombreCiudadArg14 = (String) row[++c];
		String departamentoCiudadArg15 = (String) row[++c];
		Integer numeroAFIPCiudadArg16 = (Integer) row[++c];
		String idProvinciaArg17 = (String) row[++c];
		Integer numeroProvinciaArg18 = (Integer) row[++c];
		String nombreProvinciaArg19 = (String) row[++c];
		String abreviaturaProvinciaArg20 = (String) row[++c];
		Integer numeroAFIPProvinciaArg21 = (Integer) row[++c];
		Integer numeroIngresosBrutosProvinciaArg22 = (Integer) row[++c];
		Integer numeroRENATEAProvinciaArg23 = (Integer) row[++c];
		String paisProvinciaArg24 = (String) row[++c]; // Pais.id
		String domicilioTransporteArg25 = (String) row[++c];
		String comentarioTransporteArg26 = (String) row[++c];

		Transporte obj = new Transporte(idTransporteArg0, numeroTransporteArg1, nombreTransporteArg2, cuitTransporteArg3, ingresosBrutosTransporteArg4, telefonoTransporteArg5, faxTransporteArg6, idCodigoPostalArg7, codigoCodigoPostalArg8, numeroCodigoPostalArg9, nombreCalleCodigoPostalArg10, numeroCalleCodigoPostalArg11, idCiudadArg12, numeroCiudadArg13, nombreCiudadArg14, departamentoCiudadArg15, numeroAFIPCiudadArg16, idProvinciaArg17, numeroProvinciaArg18, nombreProvinciaArg19, abreviaturaProvinciaArg20, numeroAFIPProvinciaArg21, numeroIngresosBrutosProvinciaArg22, numeroRENATEAProvinciaArg23, paisProvinciaArg24, domicilioTransporteArg25, comentarioTransporteArg26);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------