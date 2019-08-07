package com.massoftware.service.contabilidad;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.AsientoContableItem;
import com.massoftware.service.UtilNumeric;

public class AsientoContableItemService {

	private int levelDefault = 3;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(AsientoContableItem obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto AsientoContableItem no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object fecha = ( obj.getFecha() == null ) ? java.util.Date.class : obj.getFecha();
		Object detalle = ( obj.getDetalle() == null ) ? String.class : obj.getDetalle();
		Object asientoContable = ( obj.getAsientoContable() != null && obj.getAsientoContable().getId() != null) ? obj.getAsientoContable().getId() : String.class;
		Object cuentaContable = ( obj.getCuentaContable() != null && obj.getCuentaContable().getId() != null) ? obj.getCuentaContable().getId() : String.class;
		Object debe = ( obj.getDebe() == null ) ? java.math.BigDecimal.class : obj.getDebe();
		Object haber = ( obj.getHaber() == null ) ? java.math.BigDecimal.class : obj.getHaber();

		String sql = "SELECT * FROM massoftware.i_AsientoContableItem(?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, fecha, detalle, asientoContable, cuentaContable, debe, haber};

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


	public String update(AsientoContableItem obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto AsientoContableItem no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto AsientoContableItem con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object fecha = ( obj.getFecha() == null ) ? java.util.Date.class : obj.getFecha();
		Object detalle = ( obj.getDetalle() == null ) ? String.class : obj.getDetalle();
		Object asientoContable = ( obj.getAsientoContable() != null && obj.getAsientoContable().getId() != null) ? obj.getAsientoContable().getId() : String.class;
		Object cuentaContable = ( obj.getCuentaContable() != null && obj.getCuentaContable().getId() != null) ? obj.getCuentaContable().getId() : String.class;
		Object debe = ( obj.getDebe() == null ) ? java.math.BigDecimal.class : obj.getDebe();
		Object haber = ( obj.getHaber() == null ) ? java.math.BigDecimal.class : obj.getHaber();

		String sql = "SELECT * FROM massoftware.u_AsientoContableItem(?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, fecha, detalle, asientoContable, cuentaContable, debe, haber};

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
			throw new IllegalArgumentException("Se esperaba un id (AsientoContableItem.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_AsientoContableItemById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (AsientoContableItem.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_AsientoContableItem_numero(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_AsientoContableItem_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public java.math.BigDecimal nextValueDebe() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_AsientoContableItem_debe()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public java.math.BigDecimal nextValueHaber() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_AsientoContableItem_haber()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Long count() throws Exception {

		String sql = "SELECT COUNT(*) FROM massoftware.AsientoContableItem;";

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


	public List<AsientoContableItem> findByNumeroOrDetalle(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (AsientoContableItem.numero o AsientoContableItem.detalle) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº item

		if(UtilNumeric.isInteger(arg)) {

			AsientoContableItemFiltro filtroNumero = new AsientoContableItemFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<AsientoContableItem> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Detalle

		AsientoContableItemFiltro filtroDetalle = new AsientoContableItemFiltro();

		filtroDetalle.setUnlimited(true);

		filtroDetalle.setDetalle(arg);

		List<AsientoContableItem> listadoDetalle = find(filtroDetalle);

		if(listadoDetalle.size() > 0) {

			return listadoDetalle;

		}


		return new ArrayList<AsientoContableItem>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public AsientoContableItem findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public AsientoContableItem findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (AsientoContableItem.id) no nulo/vacio.");
		}

		id = id.trim();

		AsientoContableItem obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_AsientoContableItemById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 8) {

				obj = mapper8Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 30) {

				obj = mapper30Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 80) {

				obj = mapper80Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 98) {

				obj = mapper98Fields(row);

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


	public List<AsientoContableItem> find(AsientoContableItemFiltro filtro) throws Exception {

		List<AsientoContableItem> listado = new ArrayList<AsientoContableItem>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_AsientoContableItem" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object detalle = ( filtro.getDetalle() == null ) ? String.class : filtro.getDetalle();
		Object asientoContable = ( filtro.getAsientoContable() != null && filtro.getAsientoContable().getId() != null) ? filtro.getAsientoContable().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, detalle, asientoContable};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, detalle, asientoContable};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 8) {

				AsientoContableItem obj = mapper8Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 30) {

				AsientoContableItem obj = mapper30Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 80) {

				AsientoContableItem obj = mapper80Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 98) {

				AsientoContableItem obj = mapper98Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoContableItem mapper8Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoContableItemArg0 = (String) row[++c];
		Integer numeroAsientoContableItemArg1 = (Integer) row[++c];
		java.util.Date fechaAsientoContableItemArg2 = (java.util.Date) row[++c];
		String detalleAsientoContableItemArg3 = (String) row[++c];
		String asientoContableAsientoContableItemArg4 = (String) row[++c]; // AsientoContable.id
		String cuentaContableAsientoContableItemArg5 = (String) row[++c]; // CuentaContable.id
		java.math.BigDecimal debeAsientoContableItemArg6 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal haberAsientoContableItemArg7 = (java.math.BigDecimal) row[++c];

		AsientoContableItem obj = new AsientoContableItem(idAsientoContableItemArg0, numeroAsientoContableItemArg1, fechaAsientoContableItemArg2, detalleAsientoContableItemArg3, asientoContableAsientoContableItemArg4, cuentaContableAsientoContableItemArg5, debeAsientoContableItemArg6, haberAsientoContableItemArg7);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoContableItem mapper30Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoContableItemArg0 = (String) row[++c];
		Integer numeroAsientoContableItemArg1 = (Integer) row[++c];
		java.util.Date fechaAsientoContableItemArg2 = (java.util.Date) row[++c];
		String detalleAsientoContableItemArg3 = (String) row[++c];
		String idAsientoContableArg4 = (String) row[++c];
		Integer numeroAsientoContableArg5 = (Integer) row[++c];
		java.util.Date fechaAsientoContableArg6 = (java.util.Date) row[++c];
		String detalleAsientoContableArg7 = (String) row[++c];
		String ejercicioContableAsientoContableArg8 = (String) row[++c]; // EjercicioContable.id
		String minutaContableAsientoContableArg9 = (String) row[++c]; // MinutaContable.id
		String sucursalAsientoContableArg10 = (String) row[++c]; // Sucursal.id
		String asientoContableModuloAsientoContableArg11 = (String) row[++c]; // AsientoContableModulo.id
		String idCuentaContableArg12 = (String) row[++c];
		String codigoCuentaContableArg13 = (String) row[++c];
		String nombreCuentaContableArg14 = (String) row[++c];
		String ejercicioContableCuentaContableArg15 = (String) row[++c]; // EjercicioContable.id
		String integraCuentaContableArg16 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg17 = (String) row[++c];
		Boolean imputableCuentaContableArg18 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg19 = (Boolean) row[++c];
		String cuentaContableEstadoCuentaContableArg20 = (String) row[++c]; // CuentaContableEstado.id
		Boolean cuentaConApropiacionCuentaContableArg21 = (Boolean) row[++c];
		String centroCostoContableCuentaContableArg22 = (String) row[++c]; // CentroCostoContable.id
		String cuentaAgrupadoraCuentaContableArg23 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg24 = (java.math.BigDecimal) row[++c];
		String puntoEquilibrioCuentaContableArg25 = (String) row[++c]; // PuntoEquilibrio.id
		String costoVentaCuentaContableArg26 = (String) row[++c]; // CostoVenta.id
		String seguridadPuertaCuentaContableArg27 = (String) row[++c]; // SeguridadPuerta.id
		java.math.BigDecimal debeAsientoContableItemArg28 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal haberAsientoContableItemArg29 = (java.math.BigDecimal) row[++c];

		AsientoContableItem obj = new AsientoContableItem(idAsientoContableItemArg0, numeroAsientoContableItemArg1, fechaAsientoContableItemArg2, detalleAsientoContableItemArg3, idAsientoContableArg4, numeroAsientoContableArg5, fechaAsientoContableArg6, detalleAsientoContableArg7, ejercicioContableAsientoContableArg8, minutaContableAsientoContableArg9, sucursalAsientoContableArg10, asientoContableModuloAsientoContableArg11, idCuentaContableArg12, codigoCuentaContableArg13, nombreCuentaContableArg14, ejercicioContableCuentaContableArg15, integraCuentaContableArg16, cuentaJerarquiaCuentaContableArg17, imputableCuentaContableArg18, ajustaPorInflacionCuentaContableArg19, cuentaContableEstadoCuentaContableArg20, cuentaConApropiacionCuentaContableArg21, centroCostoContableCuentaContableArg22, cuentaAgrupadoraCuentaContableArg23, porcentajeCuentaContableArg24, puntoEquilibrioCuentaContableArg25, costoVentaCuentaContableArg26, seguridadPuertaCuentaContableArg27, debeAsientoContableItemArg28, haberAsientoContableItemArg29);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoContableItem mapper80Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoContableItemArg0 = (String) row[++c];
		Integer numeroAsientoContableItemArg1 = (Integer) row[++c];
		java.util.Date fechaAsientoContableItemArg2 = (java.util.Date) row[++c];
		String detalleAsientoContableItemArg3 = (String) row[++c];
		String idAsientoContableArg4 = (String) row[++c];
		Integer numeroAsientoContableArg5 = (Integer) row[++c];
		java.util.Date fechaAsientoContableArg6 = (java.util.Date) row[++c];
		String detalleAsientoContableArg7 = (String) row[++c];
		String idEjercicioContableArg8 = (String) row[++c];
		Integer numeroEjercicioContableArg9 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg10 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg11 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg12 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg13 = (Boolean) row[++c];
		String comentarioEjercicioContableArg14 = (String) row[++c];
		String idMinutaContableArg15 = (String) row[++c];
		Integer numeroMinutaContableArg16 = (Integer) row[++c];
		String nombreMinutaContableArg17 = (String) row[++c];
		String idSucursalArg18 = (String) row[++c];
		Integer numeroSucursalArg19 = (Integer) row[++c];
		String nombreSucursalArg20 = (String) row[++c];
		String abreviaturaSucursalArg21 = (String) row[++c];
		String tipoSucursalSucursalArg22 = (String) row[++c]; // TipoSucursal.id
		String cuentaClientesDesdeSucursalArg23 = (String) row[++c];
		String cuentaClientesHastaSucursalArg24 = (String) row[++c];
		Integer cantidadCaracteresClientesSucursalArg25 = (Integer) row[++c];
		Boolean identificacionNumericaClientesSucursalArg26 = (Boolean) row[++c];
		Boolean permiteCambiarClientesSucursalArg27 = (Boolean) row[++c];
		String cuentaProveedoresDesdeSucursalArg28 = (String) row[++c];
		String cuentaProveedoresHastaSucursalArg29 = (String) row[++c];
		Integer cantidadCaracteresProveedoresSucursalArg30 = (Integer) row[++c];
		Boolean identificacionNumericaProveedoresSucursalArg31 = (Boolean) row[++c];
		Boolean permiteCambiarProveedoresSucursalArg32 = (Boolean) row[++c];
		Integer clientesOcacionalesDesdeSucursalArg33 = (Integer) row[++c];
		Integer clientesOcacionalesHastaSucursalArg34 = (Integer) row[++c];
		Integer numeroCobranzaDesdeSucursalArg35 = (Integer) row[++c];
		Integer numeroCobranzaHastaSucursalArg36 = (Integer) row[++c];
		String idAsientoContableModuloArg37 = (String) row[++c];
		Integer numeroAsientoContableModuloArg38 = (Integer) row[++c];
		String nombreAsientoContableModuloArg39 = (String) row[++c];
		String idCuentaContableArg40 = (String) row[++c];
		String codigoCuentaContableArg41 = (String) row[++c];
		String nombreCuentaContableArg42 = (String) row[++c];
		String idEjercicioContableArg43 = (String) row[++c];
		Integer numeroEjercicioContableArg44 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg45 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg46 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg47 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg48 = (Boolean) row[++c];
		String comentarioEjercicioContableArg49 = (String) row[++c];
		String integraCuentaContableArg50 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg51 = (String) row[++c];
		Boolean imputableCuentaContableArg52 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg53 = (Boolean) row[++c];
		String idCuentaContableEstadoArg54 = (String) row[++c];
		Integer numeroCuentaContableEstadoArg55 = (Integer) row[++c];
		String nombreCuentaContableEstadoArg56 = (String) row[++c];
		Boolean cuentaConApropiacionCuentaContableArg57 = (Boolean) row[++c];
		String idCentroCostoContableArg58 = (String) row[++c];
		Integer numeroCentroCostoContableArg59 = (Integer) row[++c];
		String nombreCentroCostoContableArg60 = (String) row[++c];
		String abreviaturaCentroCostoContableArg61 = (String) row[++c];
		String ejercicioContableCentroCostoContableArg62 = (String) row[++c]; // EjercicioContable.id
		String cuentaAgrupadoraCuentaContableArg63 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg64 = (java.math.BigDecimal) row[++c];
		String idPuntoEquilibrioArg65 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg66 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg67 = (String) row[++c];
		String tipoPuntoEquilibrioPuntoEquilibrioArg68 = (String) row[++c]; // TipoPuntoEquilibrio.id
		String ejercicioContablePuntoEquilibrioArg69 = (String) row[++c]; // EjercicioContable.id
		String idCostoVentaArg70 = (String) row[++c];
		Integer numeroCostoVentaArg71 = (Integer) row[++c];
		String nombreCostoVentaArg72 = (String) row[++c];
		String idSeguridadPuertaArg73 = (String) row[++c];
		Integer numeroSeguridadPuertaArg74 = (Integer) row[++c];
		String nombreSeguridadPuertaArg75 = (String) row[++c];
		String equateSeguridadPuertaArg76 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg77 = (String) row[++c]; // SeguridadModulo.id
		java.math.BigDecimal debeAsientoContableItemArg78 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal haberAsientoContableItemArg79 = (java.math.BigDecimal) row[++c];

		AsientoContableItem obj = new AsientoContableItem(idAsientoContableItemArg0, numeroAsientoContableItemArg1, fechaAsientoContableItemArg2, detalleAsientoContableItemArg3, idAsientoContableArg4, numeroAsientoContableArg5, fechaAsientoContableArg6, detalleAsientoContableArg7, idEjercicioContableArg8, numeroEjercicioContableArg9, aperturaEjercicioContableArg10, cierreEjercicioContableArg11, cerradoEjercicioContableArg12, cerradoModulosEjercicioContableArg13, comentarioEjercicioContableArg14, idMinutaContableArg15, numeroMinutaContableArg16, nombreMinutaContableArg17, idSucursalArg18, numeroSucursalArg19, nombreSucursalArg20, abreviaturaSucursalArg21, tipoSucursalSucursalArg22, cuentaClientesDesdeSucursalArg23, cuentaClientesHastaSucursalArg24, cantidadCaracteresClientesSucursalArg25, identificacionNumericaClientesSucursalArg26, permiteCambiarClientesSucursalArg27, cuentaProveedoresDesdeSucursalArg28, cuentaProveedoresHastaSucursalArg29, cantidadCaracteresProveedoresSucursalArg30, identificacionNumericaProveedoresSucursalArg31, permiteCambiarProveedoresSucursalArg32, clientesOcacionalesDesdeSucursalArg33, clientesOcacionalesHastaSucursalArg34, numeroCobranzaDesdeSucursalArg35, numeroCobranzaHastaSucursalArg36, idAsientoContableModuloArg37, numeroAsientoContableModuloArg38, nombreAsientoContableModuloArg39, idCuentaContableArg40, codigoCuentaContableArg41, nombreCuentaContableArg42, idEjercicioContableArg43, numeroEjercicioContableArg44, aperturaEjercicioContableArg45, cierreEjercicioContableArg46, cerradoEjercicioContableArg47, cerradoModulosEjercicioContableArg48, comentarioEjercicioContableArg49, integraCuentaContableArg50, cuentaJerarquiaCuentaContableArg51, imputableCuentaContableArg52, ajustaPorInflacionCuentaContableArg53, idCuentaContableEstadoArg54, numeroCuentaContableEstadoArg55, nombreCuentaContableEstadoArg56, cuentaConApropiacionCuentaContableArg57, idCentroCostoContableArg58, numeroCentroCostoContableArg59, nombreCentroCostoContableArg60, abreviaturaCentroCostoContableArg61, ejercicioContableCentroCostoContableArg62, cuentaAgrupadoraCuentaContableArg63, porcentajeCuentaContableArg64, idPuntoEquilibrioArg65, numeroPuntoEquilibrioArg66, nombrePuntoEquilibrioArg67, tipoPuntoEquilibrioPuntoEquilibrioArg68, ejercicioContablePuntoEquilibrioArg69, idCostoVentaArg70, numeroCostoVentaArg71, nombreCostoVentaArg72, idSeguridadPuertaArg73, numeroSeguridadPuertaArg74, nombreSeguridadPuertaArg75, equateSeguridadPuertaArg76, seguridadModuloSeguridadPuertaArg77, debeAsientoContableItemArg78, haberAsientoContableItemArg79);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoContableItem mapper98Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoContableItemArg0 = (String) row[++c];
		Integer numeroAsientoContableItemArg1 = (Integer) row[++c];
		java.util.Date fechaAsientoContableItemArg2 = (java.util.Date) row[++c];
		String detalleAsientoContableItemArg3 = (String) row[++c];
		String idAsientoContableArg4 = (String) row[++c];
		Integer numeroAsientoContableArg5 = (Integer) row[++c];
		java.util.Date fechaAsientoContableArg6 = (java.util.Date) row[++c];
		String detalleAsientoContableArg7 = (String) row[++c];
		String idEjercicioContableArg8 = (String) row[++c];
		Integer numeroEjercicioContableArg9 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg10 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg11 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg12 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg13 = (Boolean) row[++c];
		String comentarioEjercicioContableArg14 = (String) row[++c];
		String idMinutaContableArg15 = (String) row[++c];
		Integer numeroMinutaContableArg16 = (Integer) row[++c];
		String nombreMinutaContableArg17 = (String) row[++c];
		String idSucursalArg18 = (String) row[++c];
		Integer numeroSucursalArg19 = (Integer) row[++c];
		String nombreSucursalArg20 = (String) row[++c];
		String abreviaturaSucursalArg21 = (String) row[++c];
		String idTipoSucursalArg22 = (String) row[++c];
		Integer numeroTipoSucursalArg23 = (Integer) row[++c];
		String nombreTipoSucursalArg24 = (String) row[++c];
		String cuentaClientesDesdeSucursalArg25 = (String) row[++c];
		String cuentaClientesHastaSucursalArg26 = (String) row[++c];
		Integer cantidadCaracteresClientesSucursalArg27 = (Integer) row[++c];
		Boolean identificacionNumericaClientesSucursalArg28 = (Boolean) row[++c];
		Boolean permiteCambiarClientesSucursalArg29 = (Boolean) row[++c];
		String cuentaProveedoresDesdeSucursalArg30 = (String) row[++c];
		String cuentaProveedoresHastaSucursalArg31 = (String) row[++c];
		Integer cantidadCaracteresProveedoresSucursalArg32 = (Integer) row[++c];
		Boolean identificacionNumericaProveedoresSucursalArg33 = (Boolean) row[++c];
		Boolean permiteCambiarProveedoresSucursalArg34 = (Boolean) row[++c];
		Integer clientesOcacionalesDesdeSucursalArg35 = (Integer) row[++c];
		Integer clientesOcacionalesHastaSucursalArg36 = (Integer) row[++c];
		Integer numeroCobranzaDesdeSucursalArg37 = (Integer) row[++c];
		Integer numeroCobranzaHastaSucursalArg38 = (Integer) row[++c];
		String idAsientoContableModuloArg39 = (String) row[++c];
		Integer numeroAsientoContableModuloArg40 = (Integer) row[++c];
		String nombreAsientoContableModuloArg41 = (String) row[++c];
		String idCuentaContableArg42 = (String) row[++c];
		String codigoCuentaContableArg43 = (String) row[++c];
		String nombreCuentaContableArg44 = (String) row[++c];
		String idEjercicioContableArg45 = (String) row[++c];
		Integer numeroEjercicioContableArg46 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg47 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg48 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg49 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg50 = (Boolean) row[++c];
		String comentarioEjercicioContableArg51 = (String) row[++c];
		String integraCuentaContableArg52 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg53 = (String) row[++c];
		Boolean imputableCuentaContableArg54 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg55 = (Boolean) row[++c];
		String idCuentaContableEstadoArg56 = (String) row[++c];
		Integer numeroCuentaContableEstadoArg57 = (Integer) row[++c];
		String nombreCuentaContableEstadoArg58 = (String) row[++c];
		Boolean cuentaConApropiacionCuentaContableArg59 = (Boolean) row[++c];
		String idCentroCostoContableArg60 = (String) row[++c];
		Integer numeroCentroCostoContableArg61 = (Integer) row[++c];
		String nombreCentroCostoContableArg62 = (String) row[++c];
		String abreviaturaCentroCostoContableArg63 = (String) row[++c];
		String idEjercicioContableArg64 = (String) row[++c];
		Integer numeroEjercicioContableArg65 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg66 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg67 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg68 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg69 = (Boolean) row[++c];
		String comentarioEjercicioContableArg70 = (String) row[++c];
		String cuentaAgrupadoraCuentaContableArg71 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg72 = (java.math.BigDecimal) row[++c];
		String idPuntoEquilibrioArg73 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg74 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg75 = (String) row[++c];
		String idTipoPuntoEquilibrioArg76 = (String) row[++c];
		Integer numeroTipoPuntoEquilibrioArg77 = (Integer) row[++c];
		String nombreTipoPuntoEquilibrioArg78 = (String) row[++c];
		String idEjercicioContableArg79 = (String) row[++c];
		Integer numeroEjercicioContableArg80 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg81 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg82 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg83 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg84 = (Boolean) row[++c];
		String comentarioEjercicioContableArg85 = (String) row[++c];
		String idCostoVentaArg86 = (String) row[++c];
		Integer numeroCostoVentaArg87 = (Integer) row[++c];
		String nombreCostoVentaArg88 = (String) row[++c];
		String idSeguridadPuertaArg89 = (String) row[++c];
		Integer numeroSeguridadPuertaArg90 = (Integer) row[++c];
		String nombreSeguridadPuertaArg91 = (String) row[++c];
		String equateSeguridadPuertaArg92 = (String) row[++c];
		String idSeguridadModuloArg93 = (String) row[++c];
		Integer numeroSeguridadModuloArg94 = (Integer) row[++c];
		String nombreSeguridadModuloArg95 = (String) row[++c];
		java.math.BigDecimal debeAsientoContableItemArg96 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal haberAsientoContableItemArg97 = (java.math.BigDecimal) row[++c];

		AsientoContableItem obj = new AsientoContableItem(idAsientoContableItemArg0, numeroAsientoContableItemArg1, fechaAsientoContableItemArg2, detalleAsientoContableItemArg3, idAsientoContableArg4, numeroAsientoContableArg5, fechaAsientoContableArg6, detalleAsientoContableArg7, idEjercicioContableArg8, numeroEjercicioContableArg9, aperturaEjercicioContableArg10, cierreEjercicioContableArg11, cerradoEjercicioContableArg12, cerradoModulosEjercicioContableArg13, comentarioEjercicioContableArg14, idMinutaContableArg15, numeroMinutaContableArg16, nombreMinutaContableArg17, idSucursalArg18, numeroSucursalArg19, nombreSucursalArg20, abreviaturaSucursalArg21, idTipoSucursalArg22, numeroTipoSucursalArg23, nombreTipoSucursalArg24, cuentaClientesDesdeSucursalArg25, cuentaClientesHastaSucursalArg26, cantidadCaracteresClientesSucursalArg27, identificacionNumericaClientesSucursalArg28, permiteCambiarClientesSucursalArg29, cuentaProveedoresDesdeSucursalArg30, cuentaProveedoresHastaSucursalArg31, cantidadCaracteresProveedoresSucursalArg32, identificacionNumericaProveedoresSucursalArg33, permiteCambiarProveedoresSucursalArg34, clientesOcacionalesDesdeSucursalArg35, clientesOcacionalesHastaSucursalArg36, numeroCobranzaDesdeSucursalArg37, numeroCobranzaHastaSucursalArg38, idAsientoContableModuloArg39, numeroAsientoContableModuloArg40, nombreAsientoContableModuloArg41, idCuentaContableArg42, codigoCuentaContableArg43, nombreCuentaContableArg44, idEjercicioContableArg45, numeroEjercicioContableArg46, aperturaEjercicioContableArg47, cierreEjercicioContableArg48, cerradoEjercicioContableArg49, cerradoModulosEjercicioContableArg50, comentarioEjercicioContableArg51, integraCuentaContableArg52, cuentaJerarquiaCuentaContableArg53, imputableCuentaContableArg54, ajustaPorInflacionCuentaContableArg55, idCuentaContableEstadoArg56, numeroCuentaContableEstadoArg57, nombreCuentaContableEstadoArg58, cuentaConApropiacionCuentaContableArg59, idCentroCostoContableArg60, numeroCentroCostoContableArg61, nombreCentroCostoContableArg62, abreviaturaCentroCostoContableArg63, idEjercicioContableArg64, numeroEjercicioContableArg65, aperturaEjercicioContableArg66, cierreEjercicioContableArg67, cerradoEjercicioContableArg68, cerradoModulosEjercicioContableArg69, comentarioEjercicioContableArg70, cuentaAgrupadoraCuentaContableArg71, porcentajeCuentaContableArg72, idPuntoEquilibrioArg73, numeroPuntoEquilibrioArg74, nombrePuntoEquilibrioArg75, idTipoPuntoEquilibrioArg76, numeroTipoPuntoEquilibrioArg77, nombreTipoPuntoEquilibrioArg78, idEjercicioContableArg79, numeroEjercicioContableArg80, aperturaEjercicioContableArg81, cierreEjercicioContableArg82, cerradoEjercicioContableArg83, cerradoModulosEjercicioContableArg84, comentarioEjercicioContableArg85, idCostoVentaArg86, numeroCostoVentaArg87, nombreCostoVentaArg88, idSeguridadPuertaArg89, numeroSeguridadPuertaArg90, nombreSeguridadPuertaArg91, equateSeguridadPuertaArg92, idSeguridadModuloArg93, numeroSeguridadModuloArg94, nombreSeguridadModuloArg95, debeAsientoContableItemArg96, haberAsientoContableItemArg97);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------