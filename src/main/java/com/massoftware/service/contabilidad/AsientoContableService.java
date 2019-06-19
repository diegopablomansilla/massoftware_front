package com.massoftware.service.contabilidad;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.AsientoContable;

public class AsientoContableService {

	private int levelDefault = 2;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(AsientoContable obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto AsientoContable no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object fecha = ( obj.getFecha() == null ) ? java.util.Date.class : obj.getFecha();
		Object detalle = ( obj.getDetalle() == null ) ? String.class : obj.getDetalle();
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;
		Object minutaContable = ( obj.getMinutaContable() != null && obj.getMinutaContable().getId() != null) ? obj.getMinutaContable().getId() : String.class;
		Object sucursal = ( obj.getSucursal() != null && obj.getSucursal().getId() != null) ? obj.getSucursal().getId() : String.class;
		Object asientoContableModulo = ( obj.getAsientoContableModulo() != null && obj.getAsientoContableModulo().getId() != null) ? obj.getAsientoContableModulo().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_AsientoContable(?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, fecha, detalle, ejercicioContable, minutaContable, sucursal, asientoContableModulo};

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


	public String update(AsientoContable obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto AsientoContable no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto AsientoContable con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object fecha = ( obj.getFecha() == null ) ? java.util.Date.class : obj.getFecha();
		Object detalle = ( obj.getDetalle() == null ) ? String.class : obj.getDetalle();
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;
		Object minutaContable = ( obj.getMinutaContable() != null && obj.getMinutaContable().getId() != null) ? obj.getMinutaContable().getId() : String.class;
		Object sucursal = ( obj.getSucursal() != null && obj.getSucursal().getId() != null) ? obj.getSucursal().getId() : String.class;
		Object asientoContableModulo = ( obj.getAsientoContableModulo() != null && obj.getAsientoContableModulo().getId() != null) ? obj.getAsientoContableModulo().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_AsientoContable(?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, fecha, detalle, ejercicioContable, minutaContable, sucursal, asientoContableModulo};

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

			throw new IllegalArgumentException("Se esperaba un id (AsientoContable.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_AsientoContableById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (AsientoContable.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_AsientoContable_numero(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_AsientoContable_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.AsientoContable;";

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


	public List<AsientoContable> findByNumeroOrDetalle(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (AsientoContable.numero o AsientoContable.detalle) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº asiento

		if(UtilNumeric.isInteger(arg)) {

			AsientoContableFiltro filtroNumero = new AsientoContableFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<AsientoContable> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Detalle

		AsientoContableFiltro filtroDetalle = new AsientoContableFiltro();

		filtroDetalle.setUnlimited(true);

		filtroDetalle.setDetalle(arg);

		List<AsientoContable> listadoDetalle = find(filtroDetalle);

		if(listadoDetalle.size() > 0) {

			return listadoDetalle;

		}


		return new ArrayList<AsientoContable>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public AsientoContable findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public AsientoContable findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (AsientoContable.id) no nulo/vacio.");

		}


		id = id.trim();


		AsientoContable obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_AsientoContableById" + levelString + "(?)";

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

			} else if(row.length == 38) {

				obj = mapper38Fields(row);

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


	public List<AsientoContable> find(AsientoContableFiltro filtro) throws Exception {

		List<AsientoContable> listado = new ArrayList<AsientoContable>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_AsientoContable" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object detalle = ( filtro.getDetalle() == null ) ? String.class : filtro.getDetalle();
		Object fechaFrom = ( filtro.getFechaFrom() == null ) ? java.util.Date.class : filtro.getFechaFrom();
		Object fechaTo = ( filtro.getFechaTo() == null ) ? java.util.Date.class : filtro.getFechaTo();
		Object ejercicioContable = ( filtro.getEjercicioContable() != null && filtro.getEjercicioContable().getId() != null) ? filtro.getEjercicioContable().getId() : String.class;
		Object minutaContable = ( filtro.getMinutaContable() != null && filtro.getMinutaContable().getId() != null) ? filtro.getMinutaContable().getId() : String.class;
		Object asientoContableModulo = ( filtro.getAsientoContableModulo() != null && filtro.getAsientoContableModulo().getId() != null) ? filtro.getAsientoContableModulo().getId() : String.class;
		Object sucursal = ( filtro.getSucursal() != null && filtro.getSucursal().getId() != null) ? filtro.getSucursal().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, detalle, fechaFrom, fechaTo, ejercicioContable, minutaContable, asientoContableModulo, sucursal};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, detalle, fechaFrom, fechaTo, ejercicioContable, minutaContable, asientoContableModulo, sucursal};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 8) {

				AsientoContable obj = mapper8Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 36) {

				AsientoContable obj = mapper36Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 38) {

				AsientoContable obj = mapper38Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoContable mapper8Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoContableArg0 = (String) row[++c];
		Integer numeroAsientoContableArg1 = (Integer) row[++c];
		java.util.Date fechaAsientoContableArg2 = (java.util.Date) row[++c];
		String detalleAsientoContableArg3 = (String) row[++c];
		String ejercicioContableAsientoContableArg4 = (String) row[++c]; // EjercicioContable.id
		String minutaContableAsientoContableArg5 = (String) row[++c]; // MinutaContable.id
		String sucursalAsientoContableArg6 = (String) row[++c]; // Sucursal.id
		String asientoContableModuloAsientoContableArg7 = (String) row[++c]; // AsientoContableModulo.id

		AsientoContable obj = new AsientoContable(idAsientoContableArg0, numeroAsientoContableArg1, fechaAsientoContableArg2, detalleAsientoContableArg3, ejercicioContableAsientoContableArg4, minutaContableAsientoContableArg5, sucursalAsientoContableArg6, asientoContableModuloAsientoContableArg7);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoContable mapper36Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoContableArg0 = (String) row[++c];
		Integer numeroAsientoContableArg1 = (Integer) row[++c];
		java.util.Date fechaAsientoContableArg2 = (java.util.Date) row[++c];
		String detalleAsientoContableArg3 = (String) row[++c];
		String idEjercicioContableArg4 = (String) row[++c];
		Integer numeroEjercicioContableArg5 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg6 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg7 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg8 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg9 = (Boolean) row[++c];
		String comentarioEjercicioContableArg10 = (String) row[++c];
		String idMinutaContableArg11 = (String) row[++c];
		Integer numeroMinutaContableArg12 = (Integer) row[++c];
		String nombreMinutaContableArg13 = (String) row[++c];
		String idSucursalArg14 = (String) row[++c];
		Integer numeroSucursalArg15 = (Integer) row[++c];
		String nombreSucursalArg16 = (String) row[++c];
		String abreviaturaSucursalArg17 = (String) row[++c];
		String tipoSucursalSucursalArg18 = (String) row[++c]; // TipoSucursal.id
		String cuentaClientesDesdeSucursalArg19 = (String) row[++c];
		String cuentaClientesHastaSucursalArg20 = (String) row[++c];
		Integer cantidadCaracteresClientesSucursalArg21 = (Integer) row[++c];
		Boolean identificacionNumericaClientesSucursalArg22 = (Boolean) row[++c];
		Boolean permiteCambiarClientesSucursalArg23 = (Boolean) row[++c];
		String cuentaProveedoresDesdeSucursalArg24 = (String) row[++c];
		String cuentaProveedoresHastaSucursalArg25 = (String) row[++c];
		Integer cantidadCaracteresProveedoresSucursalArg26 = (Integer) row[++c];
		Boolean identificacionNumericaProveedoresSucursalArg27 = (Boolean) row[++c];
		Boolean permiteCambiarProveedoresSucursalArg28 = (Boolean) row[++c];
		Integer clientesOcacionalesDesdeSucursalArg29 = (Integer) row[++c];
		Integer clientesOcacionalesHastaSucursalArg30 = (Integer) row[++c];
		Integer numeroCobranzaDesdeSucursalArg31 = (Integer) row[++c];
		Integer numeroCobranzaHastaSucursalArg32 = (Integer) row[++c];
		String idAsientoContableModuloArg33 = (String) row[++c];
		Integer numeroAsientoContableModuloArg34 = (Integer) row[++c];
		String nombreAsientoContableModuloArg35 = (String) row[++c];

		AsientoContable obj = new AsientoContable(idAsientoContableArg0, numeroAsientoContableArg1, fechaAsientoContableArg2, detalleAsientoContableArg3, idEjercicioContableArg4, numeroEjercicioContableArg5, aperturaEjercicioContableArg6, cierreEjercicioContableArg7, cerradoEjercicioContableArg8, cerradoModulosEjercicioContableArg9, comentarioEjercicioContableArg10, idMinutaContableArg11, numeroMinutaContableArg12, nombreMinutaContableArg13, idSucursalArg14, numeroSucursalArg15, nombreSucursalArg16, abreviaturaSucursalArg17, tipoSucursalSucursalArg18, cuentaClientesDesdeSucursalArg19, cuentaClientesHastaSucursalArg20, cantidadCaracteresClientesSucursalArg21, identificacionNumericaClientesSucursalArg22, permiteCambiarClientesSucursalArg23, cuentaProveedoresDesdeSucursalArg24, cuentaProveedoresHastaSucursalArg25, cantidadCaracteresProveedoresSucursalArg26, identificacionNumericaProveedoresSucursalArg27, permiteCambiarProveedoresSucursalArg28, clientesOcacionalesDesdeSucursalArg29, clientesOcacionalesHastaSucursalArg30, numeroCobranzaDesdeSucursalArg31, numeroCobranzaHastaSucursalArg32, idAsientoContableModuloArg33, numeroAsientoContableModuloArg34, nombreAsientoContableModuloArg35);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoContable mapper38Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoContableArg0 = (String) row[++c];
		Integer numeroAsientoContableArg1 = (Integer) row[++c];
		java.util.Date fechaAsientoContableArg2 = (java.util.Date) row[++c];
		String detalleAsientoContableArg3 = (String) row[++c];
		String idEjercicioContableArg4 = (String) row[++c];
		Integer numeroEjercicioContableArg5 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg6 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg7 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg8 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg9 = (Boolean) row[++c];
		String comentarioEjercicioContableArg10 = (String) row[++c];
		String idMinutaContableArg11 = (String) row[++c];
		Integer numeroMinutaContableArg12 = (Integer) row[++c];
		String nombreMinutaContableArg13 = (String) row[++c];
		String idSucursalArg14 = (String) row[++c];
		Integer numeroSucursalArg15 = (Integer) row[++c];
		String nombreSucursalArg16 = (String) row[++c];
		String abreviaturaSucursalArg17 = (String) row[++c];
		String idTipoSucursalArg18 = (String) row[++c];
		Integer numeroTipoSucursalArg19 = (Integer) row[++c];
		String nombreTipoSucursalArg20 = (String) row[++c];
		String cuentaClientesDesdeSucursalArg21 = (String) row[++c];
		String cuentaClientesHastaSucursalArg22 = (String) row[++c];
		Integer cantidadCaracteresClientesSucursalArg23 = (Integer) row[++c];
		Boolean identificacionNumericaClientesSucursalArg24 = (Boolean) row[++c];
		Boolean permiteCambiarClientesSucursalArg25 = (Boolean) row[++c];
		String cuentaProveedoresDesdeSucursalArg26 = (String) row[++c];
		String cuentaProveedoresHastaSucursalArg27 = (String) row[++c];
		Integer cantidadCaracteresProveedoresSucursalArg28 = (Integer) row[++c];
		Boolean identificacionNumericaProveedoresSucursalArg29 = (Boolean) row[++c];
		Boolean permiteCambiarProveedoresSucursalArg30 = (Boolean) row[++c];
		Integer clientesOcacionalesDesdeSucursalArg31 = (Integer) row[++c];
		Integer clientesOcacionalesHastaSucursalArg32 = (Integer) row[++c];
		Integer numeroCobranzaDesdeSucursalArg33 = (Integer) row[++c];
		Integer numeroCobranzaHastaSucursalArg34 = (Integer) row[++c];
		String idAsientoContableModuloArg35 = (String) row[++c];
		Integer numeroAsientoContableModuloArg36 = (Integer) row[++c];
		String nombreAsientoContableModuloArg37 = (String) row[++c];

		AsientoContable obj = new AsientoContable(idAsientoContableArg0, numeroAsientoContableArg1, fechaAsientoContableArg2, detalleAsientoContableArg3, idEjercicioContableArg4, numeroEjercicioContableArg5, aperturaEjercicioContableArg6, cierreEjercicioContableArg7, cerradoEjercicioContableArg8, cerradoModulosEjercicioContableArg9, comentarioEjercicioContableArg10, idMinutaContableArg11, numeroMinutaContableArg12, nombreMinutaContableArg13, idSucursalArg14, numeroSucursalArg15, nombreSucursalArg16, abreviaturaSucursalArg17, idTipoSucursalArg18, numeroTipoSucursalArg19, nombreTipoSucursalArg20, cuentaClientesDesdeSucursalArg21, cuentaClientesHastaSucursalArg22, cantidadCaracteresClientesSucursalArg23, identificacionNumericaClientesSucursalArg24, permiteCambiarClientesSucursalArg25, cuentaProveedoresDesdeSucursalArg26, cuentaProveedoresHastaSucursalArg27, cantidadCaracteresProveedoresSucursalArg28, identificacionNumericaProveedoresSucursalArg29, permiteCambiarProveedoresSucursalArg30, clientesOcacionalesDesdeSucursalArg31, clientesOcacionalesHastaSucursalArg32, numeroCobranzaDesdeSucursalArg33, numeroCobranzaHastaSucursalArg34, idAsientoContableModuloArg35, numeroAsientoContableModuloArg36, nombreAsientoContableModuloArg37);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------