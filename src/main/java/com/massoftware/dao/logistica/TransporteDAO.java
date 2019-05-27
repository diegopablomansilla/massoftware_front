package com.massoftware.dao.logistica;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.logistica.Transporte;

public class TransporteDAO {

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

			if(row.length == 9) {

				obj = mapper9Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 14) {

				obj = mapper14Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 19) {

				obj = mapper19Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 26) {

				obj = mapper26Fields(row);

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
		String orderByString = (filtro.getOrderBy() == null || filtro.getOrderBy().equals("id")) ? "" : "_" + filtro.getOrderBy();
		String orderByASCString = "";
		if(orderByString != null && orderByString.trim().length() > 0) {

			orderByString = "Transporte" + orderByString;
			orderByASCString = "_asc_";
			if(filtro.getOrderByDesc() == true) {
				orderByASCString = "_des_";
			}
			orderByString = orderByASCString + orderByString;
		}
		String params = (filtro.getUnlimited() == true) ? "" : "?, ?, ";

		String sql = "SELECT * FROM massoftware.f_Transporte" + orderByString + levelString + "(" + params + "?, ?, ?, ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();

		String[] nombreWords = ( filtro.getNombre() == null ) ? new String[0] : filtro.getNombre().split(" ");
		Object nombreWord0 = ( nombreWords.length > 0 && nombreWords[0].trim().length() > 0) ? nombreWords[0].trim() : String.class;
		Object nombreWord1 = ( nombreWords.length > 1 && nombreWords[1].trim().length() > 0) ? nombreWords[1].trim() : String.class;
		Object nombreWord2 = ( nombreWords.length > 2 && nombreWords[2].trim().length() > 0) ? nombreWords[2].trim() : String.class;
		Object nombreWord3 = ( nombreWords.length > 3 && nombreWords[3].trim().length() > 0) ? nombreWords[3].trim() : String.class;
		Object nombreWord4 = ( nombreWords.length > 4 && nombreWords[4].trim().length() > 0) ? nombreWords[4].trim() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {numeroFrom, numeroTo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4};
		} else {
			args = new Object[] {filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 9) {

				Transporte obj = mapper9Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 14) {

				Transporte obj = mapper14Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 19) {

				Transporte obj = mapper19Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 26) {

				Transporte obj = mapper26Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Transporte mapper9Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteArg0 = (String) row[++c];
		Integer numeroTransporteArg1 = (Integer) row[++c];
		String nombreTransporteArg2 = (String) row[++c];
		Long cuitTransporteArg3 = (Long) row[++c];
		String ingresosBrutosTransporteArg4 = (String) row[++c];
		String telefonoTransporteArg5 = (String) row[++c];
		String faxTransporteArg6 = (String) row[++c];
		String domicilioTransporteArg7 = (String) row[++c];
		String comentarioTransporteArg8 = (String) row[++c];

		Transporte obj = new Transporte(idTransporteArg0, numeroTransporteArg1, nombreTransporteArg2, cuitTransporteArg3, ingresosBrutosTransporteArg4, telefonoTransporteArg5, faxTransporteArg6, domicilioTransporteArg7, comentarioTransporteArg8);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Transporte mapper14Fields(Object[] row) throws Exception {

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
		String domicilioTransporteArg12 = (String) row[++c];
		String comentarioTransporteArg13 = (String) row[++c];

		Transporte obj = new Transporte(idTransporteArg0, numeroTransporteArg1, nombreTransporteArg2, cuitTransporteArg3, ingresosBrutosTransporteArg4, telefonoTransporteArg5, faxTransporteArg6, idCodigoPostalArg7, codigoCodigoPostalArg8, numeroCodigoPostalArg9, nombreCalleCodigoPostalArg10, numeroCalleCodigoPostalArg11, domicilioTransporteArg12, comentarioTransporteArg13);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Transporte mapper19Fields(Object[] row) throws Exception {

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
		String domicilioTransporteArg17 = (String) row[++c];
		String comentarioTransporteArg18 = (String) row[++c];

		Transporte obj = new Transporte(idTransporteArg0, numeroTransporteArg1, nombreTransporteArg2, cuitTransporteArg3, ingresosBrutosTransporteArg4, telefonoTransporteArg5, faxTransporteArg6, idCodigoPostalArg7, codigoCodigoPostalArg8, numeroCodigoPostalArg9, nombreCalleCodigoPostalArg10, numeroCalleCodigoPostalArg11, idCiudadArg12, numeroCiudadArg13, nombreCiudadArg14, departamentoCiudadArg15, numeroAFIPCiudadArg16, domicilioTransporteArg17, comentarioTransporteArg18);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Transporte mapper26Fields(Object[] row) throws Exception {

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
		String domicilioTransporteArg24 = (String) row[++c];
		String comentarioTransporteArg25 = (String) row[++c];

		Transporte obj = new Transporte(idTransporteArg0, numeroTransporteArg1, nombreTransporteArg2, cuitTransporteArg3, ingresosBrutosTransporteArg4, telefonoTransporteArg5, faxTransporteArg6, idCodigoPostalArg7, codigoCodigoPostalArg8, numeroCodigoPostalArg9, nombreCalleCodigoPostalArg10, numeroCalleCodigoPostalArg11, idCiudadArg12, numeroCiudadArg13, nombreCiudadArg14, departamentoCiudadArg15, numeroAFIPCiudadArg16, idProvinciaArg17, numeroProvinciaArg18, nombreProvinciaArg19, abreviaturaProvinciaArg20, numeroAFIPProvinciaArg21, numeroIngresosBrutosProvinciaArg22, numeroRENATEAProvinciaArg23, domicilioTransporteArg24, comentarioTransporteArg25);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------