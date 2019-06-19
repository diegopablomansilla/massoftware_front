package com.massoftware.service.geo;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.geo.Provincia;

public class ProvinciaService {

	private int levelDefault = 1;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Provincia obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Provincia no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();
		Object numeroAFIP = ( obj.getNumeroAFIP() == null ) ? Integer.class : obj.getNumeroAFIP();
		Object numeroIngresosBrutos = ( obj.getNumeroIngresosBrutos() == null ) ? Integer.class : obj.getNumeroIngresosBrutos();
		Object numeroRENATEA = ( obj.getNumeroRENATEA() == null ) ? Integer.class : obj.getNumeroRENATEA();
		Object pais = ( obj.getPais() != null && obj.getPais().getId() != null) ? obj.getPais().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_Provincia(?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura, numeroAFIP, numeroIngresosBrutos, numeroRENATEA, pais};

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


	public String update(Provincia obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Provincia no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto Provincia con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();
		Object numeroAFIP = ( obj.getNumeroAFIP() == null ) ? Integer.class : obj.getNumeroAFIP();
		Object numeroIngresosBrutos = ( obj.getNumeroIngresosBrutos() == null ) ? Integer.class : obj.getNumeroIngresosBrutos();
		Object numeroRENATEA = ( obj.getNumeroRENATEA() == null ) ? Integer.class : obj.getNumeroRENATEA();
		Object pais = ( obj.getPais() != null && obj.getPais().getId() != null) ? obj.getPais().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_Provincia(?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura, numeroAFIP, numeroIngresosBrutos, numeroRENATEA, pais};

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

			throw new IllegalArgumentException("Se esperaba un id (Provincia.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_ProvinciaById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Provincia.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_Provincia_numero(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Provincia.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Provincia_nombre(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Provincia.abreviatura) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Provincia_abreviatura(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_Provincia_numero()";

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

		String sql = "SELECT * FROM massoftware.f_next_Provincia_numeroAFIP()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueNumeroIngresosBrutos() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Provincia_numeroIngresosBrutos()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueNumeroRENATEA() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Provincia_numeroRENATEA()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.Provincia;";

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


	public List<Provincia> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Provincia.numero o Provincia.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº provincia

		if(UtilNumeric.isInteger(arg)) {

			ProvinciaFiltro filtroNumero = new ProvinciaFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Provincia> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		ProvinciaFiltro filtroNombre = new ProvinciaFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Provincia> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Provincia>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Provincia findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Provincia findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (Provincia.id) no nulo/vacio.");

		}


		id = id.trim();


		Provincia obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_ProvinciaById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 8) {

				obj = mapper8Fields(row);

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


	public List<Provincia> find(ProvinciaFiltro filtro) throws Exception {

		List<Provincia> listado = new ArrayList<Provincia>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_Provincia" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();
		Object abreviatura = ( filtro.getAbreviatura() == null ) ? String.class : filtro.getAbreviatura();
		Object pais = ( filtro.getPais() != null && filtro.getPais().getId() != null) ? filtro.getPais().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre, abreviatura, pais};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre, abreviatura, pais};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 8) {

				Provincia obj = mapper8Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 11) {

				Provincia obj = mapper11Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Provincia mapper8Fields(Object[] row) throws Exception {

		int c = -1;

		String idProvinciaArg0 = (String) row[++c];
		Integer numeroProvinciaArg1 = (Integer) row[++c];
		String nombreProvinciaArg2 = (String) row[++c];
		String abreviaturaProvinciaArg3 = (String) row[++c];
		Integer numeroAFIPProvinciaArg4 = (Integer) row[++c];
		Integer numeroIngresosBrutosProvinciaArg5 = (Integer) row[++c];
		Integer numeroRENATEAProvinciaArg6 = (Integer) row[++c];
		String paisProvinciaArg7 = (String) row[++c]; // Pais.id

		Provincia obj = new Provincia(idProvinciaArg0, numeroProvinciaArg1, nombreProvinciaArg2, abreviaturaProvinciaArg3, numeroAFIPProvinciaArg4, numeroIngresosBrutosProvinciaArg5, numeroRENATEAProvinciaArg6, paisProvinciaArg7);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Provincia mapper11Fields(Object[] row) throws Exception {

		int c = -1;

		String idProvinciaArg0 = (String) row[++c];
		Integer numeroProvinciaArg1 = (Integer) row[++c];
		String nombreProvinciaArg2 = (String) row[++c];
		String abreviaturaProvinciaArg3 = (String) row[++c];
		Integer numeroAFIPProvinciaArg4 = (Integer) row[++c];
		Integer numeroIngresosBrutosProvinciaArg5 = (Integer) row[++c];
		Integer numeroRENATEAProvinciaArg6 = (Integer) row[++c];
		String idPaisArg7 = (String) row[++c];
		Integer numeroPaisArg8 = (Integer) row[++c];
		String nombrePaisArg9 = (String) row[++c];
		String abreviaturaPaisArg10 = (String) row[++c];

		Provincia obj = new Provincia(idProvinciaArg0, numeroProvinciaArg1, nombreProvinciaArg2, abreviaturaProvinciaArg3, numeroAFIPProvinciaArg4, numeroIngresosBrutosProvinciaArg5, numeroRENATEAProvinciaArg6, idPaisArg7, numeroPaisArg8, nombrePaisArg9, abreviaturaPaisArg10);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------