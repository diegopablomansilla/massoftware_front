package com.massoftware.service.empresa;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.empresa.Deposito;

public class DepositoService {

	private int levelDefault = 2;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Deposito obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Deposito no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();
		Object sucursal = ( obj.getSucursal() != null && obj.getSucursal().getId() != null) ? obj.getSucursal().getId() : String.class;
		Object depositoModulo = ( obj.getDepositoModulo() != null && obj.getDepositoModulo().getId() != null) ? obj.getDepositoModulo().getId() : String.class;
		Object puertaOperativo = ( obj.getPuertaOperativo() != null && obj.getPuertaOperativo().getId() != null) ? obj.getPuertaOperativo().getId() : String.class;
		Object puertaConsulta = ( obj.getPuertaConsulta() != null && obj.getPuertaConsulta().getId() != null) ? obj.getPuertaConsulta().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_Deposito(?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura, sucursal, depositoModulo, puertaOperativo, puertaConsulta};

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


	public String update(Deposito obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Deposito no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto Deposito con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();
		Object sucursal = ( obj.getSucursal() != null && obj.getSucursal().getId() != null) ? obj.getSucursal().getId() : String.class;
		Object depositoModulo = ( obj.getDepositoModulo() != null && obj.getDepositoModulo().getId() != null) ? obj.getDepositoModulo().getId() : String.class;
		Object puertaOperativo = ( obj.getPuertaOperativo() != null && obj.getPuertaOperativo().getId() != null) ? obj.getPuertaOperativo().getId() : String.class;
		Object puertaConsulta = ( obj.getPuertaConsulta() != null && obj.getPuertaConsulta().getId() != null) ? obj.getPuertaConsulta().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_Deposito(?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura, sucursal, depositoModulo, puertaOperativo, puertaConsulta};

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

			throw new IllegalArgumentException("Se esperaba un id (Deposito.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_DepositoById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Deposito.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_Deposito_numero(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Deposito.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Deposito_nombre(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Deposito.abreviatura) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Deposito_abreviatura(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_Deposito_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.Deposito;";

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


	public List<Deposito> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Deposito.numero o Deposito.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº depósito

		if(UtilNumeric.isInteger(arg)) {

			DepositoFiltro filtroNumero = new DepositoFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Deposito> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		DepositoFiltro filtroNombre = new DepositoFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Deposito> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Deposito>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Deposito findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Deposito findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (Deposito.id) no nulo/vacio.");

		}


		id = id.trim();


		Deposito obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_DepositoById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 8) {

				obj = mapper8Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 36) {

				obj = mapper36Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 42) {

				obj = mapper42Fields(row);

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


	public List<Deposito> find(DepositoFiltro filtro) throws Exception {

		List<Deposito> listado = new ArrayList<Deposito>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_Deposito" + levelString + "(?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();
		Object sucursal = ( filtro.getSucursal() != null && filtro.getSucursal().getId() != null) ? filtro.getSucursal().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre, sucursal};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre, sucursal};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 8) {

				Deposito obj = mapper8Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 36) {

				Deposito obj = mapper36Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 42) {

				Deposito obj = mapper42Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Deposito mapper8Fields(Object[] row) throws Exception {

		int c = -1;

		String idDepositoArg0 = (String) row[++c];
		Integer numeroDepositoArg1 = (Integer) row[++c];
		String nombreDepositoArg2 = (String) row[++c];
		String abreviaturaDepositoArg3 = (String) row[++c];
		String sucursalDepositoArg4 = (String) row[++c]; // Sucursal.id
		String depositoModuloDepositoArg5 = (String) row[++c]; // DepositoModulo.id
		String puertaOperativoDepositoArg6 = (String) row[++c]; // SeguridadPuerta.id
		String puertaConsultaDepositoArg7 = (String) row[++c]; // SeguridadPuerta.id

		Deposito obj = new Deposito(idDepositoArg0, numeroDepositoArg1, nombreDepositoArg2, abreviaturaDepositoArg3, sucursalDepositoArg4, depositoModuloDepositoArg5, puertaOperativoDepositoArg6, puertaConsultaDepositoArg7);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Deposito mapper36Fields(Object[] row) throws Exception {

		int c = -1;

		String idDepositoArg0 = (String) row[++c];
		Integer numeroDepositoArg1 = (Integer) row[++c];
		String nombreDepositoArg2 = (String) row[++c];
		String abreviaturaDepositoArg3 = (String) row[++c];
		String idSucursalArg4 = (String) row[++c];
		Integer numeroSucursalArg5 = (Integer) row[++c];
		String nombreSucursalArg6 = (String) row[++c];
		String abreviaturaSucursalArg7 = (String) row[++c];
		String tipoSucursalSucursalArg8 = (String) row[++c]; // TipoSucursal.id
		String cuentaClientesDesdeSucursalArg9 = (String) row[++c];
		String cuentaClientesHastaSucursalArg10 = (String) row[++c];
		Integer cantidadCaracteresClientesSucursalArg11 = (Integer) row[++c];
		Boolean identificacionNumericaClientesSucursalArg12 = (Boolean) row[++c];
		Boolean permiteCambiarClientesSucursalArg13 = (Boolean) row[++c];
		String cuentaProveedoresDesdeSucursalArg14 = (String) row[++c];
		String cuentaProveedoresHastaSucursalArg15 = (String) row[++c];
		Integer cantidadCaracteresProveedoresSucursalArg16 = (Integer) row[++c];
		Boolean identificacionNumericaProveedoresSucursalArg17 = (Boolean) row[++c];
		Boolean permiteCambiarProveedoresSucursalArg18 = (Boolean) row[++c];
		Integer clientesOcacionalesDesdeSucursalArg19 = (Integer) row[++c];
		Integer clientesOcacionalesHastaSucursalArg20 = (Integer) row[++c];
		Integer numeroCobranzaDesdeSucursalArg21 = (Integer) row[++c];
		Integer numeroCobranzaHastaSucursalArg22 = (Integer) row[++c];
		String idDepositoModuloArg23 = (String) row[++c];
		Integer numeroDepositoModuloArg24 = (Integer) row[++c];
		String nombreDepositoModuloArg25 = (String) row[++c];
		String idSeguridadPuertaArg26 = (String) row[++c];
		Integer numeroSeguridadPuertaArg27 = (Integer) row[++c];
		String nombreSeguridadPuertaArg28 = (String) row[++c];
		String equateSeguridadPuertaArg29 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg30 = (String) row[++c]; // SeguridadModulo.id
		String idSeguridadPuertaArg31 = (String) row[++c];
		Integer numeroSeguridadPuertaArg32 = (Integer) row[++c];
		String nombreSeguridadPuertaArg33 = (String) row[++c];
		String equateSeguridadPuertaArg34 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg35 = (String) row[++c]; // SeguridadModulo.id

		Deposito obj = new Deposito(idDepositoArg0, numeroDepositoArg1, nombreDepositoArg2, abreviaturaDepositoArg3, idSucursalArg4, numeroSucursalArg5, nombreSucursalArg6, abreviaturaSucursalArg7, tipoSucursalSucursalArg8, cuentaClientesDesdeSucursalArg9, cuentaClientesHastaSucursalArg10, cantidadCaracteresClientesSucursalArg11, identificacionNumericaClientesSucursalArg12, permiteCambiarClientesSucursalArg13, cuentaProveedoresDesdeSucursalArg14, cuentaProveedoresHastaSucursalArg15, cantidadCaracteresProveedoresSucursalArg16, identificacionNumericaProveedoresSucursalArg17, permiteCambiarProveedoresSucursalArg18, clientesOcacionalesDesdeSucursalArg19, clientesOcacionalesHastaSucursalArg20, numeroCobranzaDesdeSucursalArg21, numeroCobranzaHastaSucursalArg22, idDepositoModuloArg23, numeroDepositoModuloArg24, nombreDepositoModuloArg25, idSeguridadPuertaArg26, numeroSeguridadPuertaArg27, nombreSeguridadPuertaArg28, equateSeguridadPuertaArg29, seguridadModuloSeguridadPuertaArg30, idSeguridadPuertaArg31, numeroSeguridadPuertaArg32, nombreSeguridadPuertaArg33, equateSeguridadPuertaArg34, seguridadModuloSeguridadPuertaArg35);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Deposito mapper42Fields(Object[] row) throws Exception {

		int c = -1;

		String idDepositoArg0 = (String) row[++c];
		Integer numeroDepositoArg1 = (Integer) row[++c];
		String nombreDepositoArg2 = (String) row[++c];
		String abreviaturaDepositoArg3 = (String) row[++c];
		String idSucursalArg4 = (String) row[++c];
		Integer numeroSucursalArg5 = (Integer) row[++c];
		String nombreSucursalArg6 = (String) row[++c];
		String abreviaturaSucursalArg7 = (String) row[++c];
		String idTipoSucursalArg8 = (String) row[++c];
		Integer numeroTipoSucursalArg9 = (Integer) row[++c];
		String nombreTipoSucursalArg10 = (String) row[++c];
		String cuentaClientesDesdeSucursalArg11 = (String) row[++c];
		String cuentaClientesHastaSucursalArg12 = (String) row[++c];
		Integer cantidadCaracteresClientesSucursalArg13 = (Integer) row[++c];
		Boolean identificacionNumericaClientesSucursalArg14 = (Boolean) row[++c];
		Boolean permiteCambiarClientesSucursalArg15 = (Boolean) row[++c];
		String cuentaProveedoresDesdeSucursalArg16 = (String) row[++c];
		String cuentaProveedoresHastaSucursalArg17 = (String) row[++c];
		Integer cantidadCaracteresProveedoresSucursalArg18 = (Integer) row[++c];
		Boolean identificacionNumericaProveedoresSucursalArg19 = (Boolean) row[++c];
		Boolean permiteCambiarProveedoresSucursalArg20 = (Boolean) row[++c];
		Integer clientesOcacionalesDesdeSucursalArg21 = (Integer) row[++c];
		Integer clientesOcacionalesHastaSucursalArg22 = (Integer) row[++c];
		Integer numeroCobranzaDesdeSucursalArg23 = (Integer) row[++c];
		Integer numeroCobranzaHastaSucursalArg24 = (Integer) row[++c];
		String idDepositoModuloArg25 = (String) row[++c];
		Integer numeroDepositoModuloArg26 = (Integer) row[++c];
		String nombreDepositoModuloArg27 = (String) row[++c];
		String idSeguridadPuertaArg28 = (String) row[++c];
		Integer numeroSeguridadPuertaArg29 = (Integer) row[++c];
		String nombreSeguridadPuertaArg30 = (String) row[++c];
		String equateSeguridadPuertaArg31 = (String) row[++c];
		String idSeguridadModuloArg32 = (String) row[++c];
		Integer numeroSeguridadModuloArg33 = (Integer) row[++c];
		String nombreSeguridadModuloArg34 = (String) row[++c];
		String idSeguridadPuertaArg35 = (String) row[++c];
		Integer numeroSeguridadPuertaArg36 = (Integer) row[++c];
		String nombreSeguridadPuertaArg37 = (String) row[++c];
		String equateSeguridadPuertaArg38 = (String) row[++c];
		String idSeguridadModuloArg39 = (String) row[++c];
		Integer numeroSeguridadModuloArg40 = (Integer) row[++c];
		String nombreSeguridadModuloArg41 = (String) row[++c];

		Deposito obj = new Deposito(idDepositoArg0, numeroDepositoArg1, nombreDepositoArg2, abreviaturaDepositoArg3, idSucursalArg4, numeroSucursalArg5, nombreSucursalArg6, abreviaturaSucursalArg7, idTipoSucursalArg8, numeroTipoSucursalArg9, nombreTipoSucursalArg10, cuentaClientesDesdeSucursalArg11, cuentaClientesHastaSucursalArg12, cantidadCaracteresClientesSucursalArg13, identificacionNumericaClientesSucursalArg14, permiteCambiarClientesSucursalArg15, cuentaProveedoresDesdeSucursalArg16, cuentaProveedoresHastaSucursalArg17, cantidadCaracteresProveedoresSucursalArg18, identificacionNumericaProveedoresSucursalArg19, permiteCambiarProveedoresSucursalArg20, clientesOcacionalesDesdeSucursalArg21, clientesOcacionalesHastaSucursalArg22, numeroCobranzaDesdeSucursalArg23, numeroCobranzaHastaSucursalArg24, idDepositoModuloArg25, numeroDepositoModuloArg26, nombreDepositoModuloArg27, idSeguridadPuertaArg28, numeroSeguridadPuertaArg29, nombreSeguridadPuertaArg30, equateSeguridadPuertaArg31, idSeguridadModuloArg32, numeroSeguridadModuloArg33, nombreSeguridadModuloArg34, idSeguridadPuertaArg35, numeroSeguridadPuertaArg36, nombreSeguridadPuertaArg37, equateSeguridadPuertaArg38, idSeguridadModuloArg39, numeroSeguridadModuloArg40, nombreSeguridadModuloArg41);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------