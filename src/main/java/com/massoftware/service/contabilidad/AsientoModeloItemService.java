package com.massoftware.service.contabilidad;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.AsientoModeloItem;

public class AsientoModeloItemService {

	private int levelDefault = 3;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(AsientoModeloItem obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto AsientoModeloItem no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object asientoModelo = ( obj.getAsientoModelo() != null && obj.getAsientoModelo().getId() != null) ? obj.getAsientoModelo().getId() : String.class;
		Object cuentaContable = ( obj.getCuentaContable() != null && obj.getCuentaContable().getId() != null) ? obj.getCuentaContable().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_AsientoModeloItem(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, asientoModelo, cuentaContable};

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


	public String update(AsientoModeloItem obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto AsientoModeloItem no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto AsientoModeloItem con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object asientoModelo = ( obj.getAsientoModelo() != null && obj.getAsientoModelo().getId() != null) ? obj.getAsientoModelo().getId() : String.class;
		Object cuentaContable = ( obj.getCuentaContable() != null && obj.getCuentaContable().getId() != null) ? obj.getCuentaContable().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_AsientoModeloItem(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, asientoModelo, cuentaContable};

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

			throw new IllegalArgumentException("Se esperaba un id (AsientoModeloItem.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_AsientoModeloItemById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (AsientoModeloItem.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_AsientoModeloItem_numero(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_AsientoModeloItem_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.AsientoModeloItem;";

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


	public AsientoModeloItem findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public AsientoModeloItem findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (AsientoModeloItem.id) no nulo/vacio.");

		}


		id = id.trim();


		AsientoModeloItem obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_AsientoModeloItemById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 4) {

				obj = mapper4Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 22) {

				obj = mapper22Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 50) {

				obj = mapper50Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 66) {

				obj = mapper66Fields(row);

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


	public List<AsientoModeloItem> find(AsientoModeloItemFiltro filtro) throws Exception {

		List<AsientoModeloItem> listado = new ArrayList<AsientoModeloItem>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_AsientoModeloItem" + levelString + "(?, ?, ?, ?, ?, ?)";

		Object asientoModelo = ( filtro.getAsientoModelo() != null && filtro.getAsientoModelo().getId() != null) ? filtro.getAsientoModelo().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, asientoModelo};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), asientoModelo};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 4) {

				AsientoModeloItem obj = mapper4Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 22) {

				AsientoModeloItem obj = mapper22Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 50) {

				AsientoModeloItem obj = mapper50Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 66) {

				AsientoModeloItem obj = mapper66Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoModeloItem mapper4Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoModeloItemArg0 = (String) row[++c];
		Integer numeroAsientoModeloItemArg1 = (Integer) row[++c];
		String asientoModeloAsientoModeloItemArg2 = (String) row[++c]; // AsientoModelo.id
		String cuentaContableAsientoModeloItemArg3 = (String) row[++c]; // CuentaContable.id

		AsientoModeloItem obj = new AsientoModeloItem(idAsientoModeloItemArg0, numeroAsientoModeloItemArg1, asientoModeloAsientoModeloItemArg2, cuentaContableAsientoModeloItemArg3);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoModeloItem mapper22Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoModeloItemArg0 = (String) row[++c];
		Integer numeroAsientoModeloItemArg1 = (Integer) row[++c];
		String idAsientoModeloArg2 = (String) row[++c];
		Integer numeroAsientoModeloArg3 = (Integer) row[++c];
		String nombreAsientoModeloArg4 = (String) row[++c];
		String ejercicioContableAsientoModeloArg5 = (String) row[++c]; // EjercicioContable.id
		String idCuentaContableArg6 = (String) row[++c];
		String codigoCuentaContableArg7 = (String) row[++c];
		String nombreCuentaContableArg8 = (String) row[++c];
		String ejercicioContableCuentaContableArg9 = (String) row[++c]; // EjercicioContable.id
		String integraCuentaContableArg10 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg11 = (String) row[++c];
		Boolean imputableCuentaContableArg12 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg13 = (Boolean) row[++c];
		String cuentaContableEstadoCuentaContableArg14 = (String) row[++c]; // CuentaContableEstado.id
		Boolean cuentaConApropiacionCuentaContableArg15 = (Boolean) row[++c];
		String centroCostoContableCuentaContableArg16 = (String) row[++c]; // CentroCostoContable.id
		String cuentaAgrupadoraCuentaContableArg17 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg18 = (java.math.BigDecimal) row[++c];
		String puntoEquilibrioCuentaContableArg19 = (String) row[++c]; // PuntoEquilibrio.id
		String costoVentaCuentaContableArg20 = (String) row[++c]; // CostoVenta.id
		String seguridadPuertaCuentaContableArg21 = (String) row[++c]; // SeguridadPuerta.id

		AsientoModeloItem obj = new AsientoModeloItem(idAsientoModeloItemArg0, numeroAsientoModeloItemArg1, idAsientoModeloArg2, numeroAsientoModeloArg3, nombreAsientoModeloArg4, ejercicioContableAsientoModeloArg5, idCuentaContableArg6, codigoCuentaContableArg7, nombreCuentaContableArg8, ejercicioContableCuentaContableArg9, integraCuentaContableArg10, cuentaJerarquiaCuentaContableArg11, imputableCuentaContableArg12, ajustaPorInflacionCuentaContableArg13, cuentaContableEstadoCuentaContableArg14, cuentaConApropiacionCuentaContableArg15, centroCostoContableCuentaContableArg16, cuentaAgrupadoraCuentaContableArg17, porcentajeCuentaContableArg18, puntoEquilibrioCuentaContableArg19, costoVentaCuentaContableArg20, seguridadPuertaCuentaContableArg21);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoModeloItem mapper50Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoModeloItemArg0 = (String) row[++c];
		Integer numeroAsientoModeloItemArg1 = (Integer) row[++c];
		String idAsientoModeloArg2 = (String) row[++c];
		Integer numeroAsientoModeloArg3 = (Integer) row[++c];
		String nombreAsientoModeloArg4 = (String) row[++c];
		String idEjercicioContableArg5 = (String) row[++c];
		Integer numeroEjercicioContableArg6 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg7 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg8 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg9 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg10 = (Boolean) row[++c];
		String comentarioEjercicioContableArg11 = (String) row[++c];
		String idCuentaContableArg12 = (String) row[++c];
		String codigoCuentaContableArg13 = (String) row[++c];
		String nombreCuentaContableArg14 = (String) row[++c];
		String idEjercicioContableArg15 = (String) row[++c];
		Integer numeroEjercicioContableArg16 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg17 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg18 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg19 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg20 = (Boolean) row[++c];
		String comentarioEjercicioContableArg21 = (String) row[++c];
		String integraCuentaContableArg22 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg23 = (String) row[++c];
		Boolean imputableCuentaContableArg24 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg25 = (Boolean) row[++c];
		String idCuentaContableEstadoArg26 = (String) row[++c];
		Integer numeroCuentaContableEstadoArg27 = (Integer) row[++c];
		String nombreCuentaContableEstadoArg28 = (String) row[++c];
		Boolean cuentaConApropiacionCuentaContableArg29 = (Boolean) row[++c];
		String idCentroCostoContableArg30 = (String) row[++c];
		Integer numeroCentroCostoContableArg31 = (Integer) row[++c];
		String nombreCentroCostoContableArg32 = (String) row[++c];
		String abreviaturaCentroCostoContableArg33 = (String) row[++c];
		String ejercicioContableCentroCostoContableArg34 = (String) row[++c]; // EjercicioContable.id
		String cuentaAgrupadoraCuentaContableArg35 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg36 = (java.math.BigDecimal) row[++c];
		String idPuntoEquilibrioArg37 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg38 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg39 = (String) row[++c];
		String tipoPuntoEquilibrioPuntoEquilibrioArg40 = (String) row[++c]; // TipoPuntoEquilibrio.id
		String ejercicioContablePuntoEquilibrioArg41 = (String) row[++c]; // EjercicioContable.id
		String idCostoVentaArg42 = (String) row[++c];
		Integer numeroCostoVentaArg43 = (Integer) row[++c];
		String nombreCostoVentaArg44 = (String) row[++c];
		String idSeguridadPuertaArg45 = (String) row[++c];
		Integer numeroSeguridadPuertaArg46 = (Integer) row[++c];
		String nombreSeguridadPuertaArg47 = (String) row[++c];
		String equateSeguridadPuertaArg48 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg49 = (String) row[++c]; // SeguridadModulo.id

		AsientoModeloItem obj = new AsientoModeloItem(idAsientoModeloItemArg0, numeroAsientoModeloItemArg1, idAsientoModeloArg2, numeroAsientoModeloArg3, nombreAsientoModeloArg4, idEjercicioContableArg5, numeroEjercicioContableArg6, aperturaEjercicioContableArg7, cierreEjercicioContableArg8, cerradoEjercicioContableArg9, cerradoModulosEjercicioContableArg10, comentarioEjercicioContableArg11, idCuentaContableArg12, codigoCuentaContableArg13, nombreCuentaContableArg14, idEjercicioContableArg15, numeroEjercicioContableArg16, aperturaEjercicioContableArg17, cierreEjercicioContableArg18, cerradoEjercicioContableArg19, cerradoModulosEjercicioContableArg20, comentarioEjercicioContableArg21, integraCuentaContableArg22, cuentaJerarquiaCuentaContableArg23, imputableCuentaContableArg24, ajustaPorInflacionCuentaContableArg25, idCuentaContableEstadoArg26, numeroCuentaContableEstadoArg27, nombreCuentaContableEstadoArg28, cuentaConApropiacionCuentaContableArg29, idCentroCostoContableArg30, numeroCentroCostoContableArg31, nombreCentroCostoContableArg32, abreviaturaCentroCostoContableArg33, ejercicioContableCentroCostoContableArg34, cuentaAgrupadoraCuentaContableArg35, porcentajeCuentaContableArg36, idPuntoEquilibrioArg37, numeroPuntoEquilibrioArg38, nombrePuntoEquilibrioArg39, tipoPuntoEquilibrioPuntoEquilibrioArg40, ejercicioContablePuntoEquilibrioArg41, idCostoVentaArg42, numeroCostoVentaArg43, nombreCostoVentaArg44, idSeguridadPuertaArg45, numeroSeguridadPuertaArg46, nombreSeguridadPuertaArg47, equateSeguridadPuertaArg48, seguridadModuloSeguridadPuertaArg49);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private AsientoModeloItem mapper66Fields(Object[] row) throws Exception {

		int c = -1;

		String idAsientoModeloItemArg0 = (String) row[++c];
		Integer numeroAsientoModeloItemArg1 = (Integer) row[++c];
		String idAsientoModeloArg2 = (String) row[++c];
		Integer numeroAsientoModeloArg3 = (Integer) row[++c];
		String nombreAsientoModeloArg4 = (String) row[++c];
		String idEjercicioContableArg5 = (String) row[++c];
		Integer numeroEjercicioContableArg6 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg7 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg8 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg9 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg10 = (Boolean) row[++c];
		String comentarioEjercicioContableArg11 = (String) row[++c];
		String idCuentaContableArg12 = (String) row[++c];
		String codigoCuentaContableArg13 = (String) row[++c];
		String nombreCuentaContableArg14 = (String) row[++c];
		String idEjercicioContableArg15 = (String) row[++c];
		Integer numeroEjercicioContableArg16 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg17 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg18 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg19 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg20 = (Boolean) row[++c];
		String comentarioEjercicioContableArg21 = (String) row[++c];
		String integraCuentaContableArg22 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg23 = (String) row[++c];
		Boolean imputableCuentaContableArg24 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg25 = (Boolean) row[++c];
		String idCuentaContableEstadoArg26 = (String) row[++c];
		Integer numeroCuentaContableEstadoArg27 = (Integer) row[++c];
		String nombreCuentaContableEstadoArg28 = (String) row[++c];
		Boolean cuentaConApropiacionCuentaContableArg29 = (Boolean) row[++c];
		String idCentroCostoContableArg30 = (String) row[++c];
		Integer numeroCentroCostoContableArg31 = (Integer) row[++c];
		String nombreCentroCostoContableArg32 = (String) row[++c];
		String abreviaturaCentroCostoContableArg33 = (String) row[++c];
		String idEjercicioContableArg34 = (String) row[++c];
		Integer numeroEjercicioContableArg35 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg36 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg37 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg38 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg39 = (Boolean) row[++c];
		String comentarioEjercicioContableArg40 = (String) row[++c];
		String cuentaAgrupadoraCuentaContableArg41 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg42 = (java.math.BigDecimal) row[++c];
		String idPuntoEquilibrioArg43 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg44 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg45 = (String) row[++c];
		String idTipoPuntoEquilibrioArg46 = (String) row[++c];
		Integer numeroTipoPuntoEquilibrioArg47 = (Integer) row[++c];
		String nombreTipoPuntoEquilibrioArg48 = (String) row[++c];
		String idEjercicioContableArg49 = (String) row[++c];
		Integer numeroEjercicioContableArg50 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg51 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg52 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg53 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg54 = (Boolean) row[++c];
		String comentarioEjercicioContableArg55 = (String) row[++c];
		String idCostoVentaArg56 = (String) row[++c];
		Integer numeroCostoVentaArg57 = (Integer) row[++c];
		String nombreCostoVentaArg58 = (String) row[++c];
		String idSeguridadPuertaArg59 = (String) row[++c];
		Integer numeroSeguridadPuertaArg60 = (Integer) row[++c];
		String nombreSeguridadPuertaArg61 = (String) row[++c];
		String equateSeguridadPuertaArg62 = (String) row[++c];
		String idSeguridadModuloArg63 = (String) row[++c];
		Integer numeroSeguridadModuloArg64 = (Integer) row[++c];
		String nombreSeguridadModuloArg65 = (String) row[++c];

		AsientoModeloItem obj = new AsientoModeloItem(idAsientoModeloItemArg0, numeroAsientoModeloItemArg1, idAsientoModeloArg2, numeroAsientoModeloArg3, nombreAsientoModeloArg4, idEjercicioContableArg5, numeroEjercicioContableArg6, aperturaEjercicioContableArg7, cierreEjercicioContableArg8, cerradoEjercicioContableArg9, cerradoModulosEjercicioContableArg10, comentarioEjercicioContableArg11, idCuentaContableArg12, codigoCuentaContableArg13, nombreCuentaContableArg14, idEjercicioContableArg15, numeroEjercicioContableArg16, aperturaEjercicioContableArg17, cierreEjercicioContableArg18, cerradoEjercicioContableArg19, cerradoModulosEjercicioContableArg20, comentarioEjercicioContableArg21, integraCuentaContableArg22, cuentaJerarquiaCuentaContableArg23, imputableCuentaContableArg24, ajustaPorInflacionCuentaContableArg25, idCuentaContableEstadoArg26, numeroCuentaContableEstadoArg27, nombreCuentaContableEstadoArg28, cuentaConApropiacionCuentaContableArg29, idCentroCostoContableArg30, numeroCentroCostoContableArg31, nombreCentroCostoContableArg32, abreviaturaCentroCostoContableArg33, idEjercicioContableArg34, numeroEjercicioContableArg35, aperturaEjercicioContableArg36, cierreEjercicioContableArg37, cerradoEjercicioContableArg38, cerradoModulosEjercicioContableArg39, comentarioEjercicioContableArg40, cuentaAgrupadoraCuentaContableArg41, porcentajeCuentaContableArg42, idPuntoEquilibrioArg43, numeroPuntoEquilibrioArg44, nombrePuntoEquilibrioArg45, idTipoPuntoEquilibrioArg46, numeroTipoPuntoEquilibrioArg47, nombreTipoPuntoEquilibrioArg48, idEjercicioContableArg49, numeroEjercicioContableArg50, aperturaEjercicioContableArg51, cierreEjercicioContableArg52, cerradoEjercicioContableArg53, cerradoModulosEjercicioContableArg54, comentarioEjercicioContableArg55, idCostoVentaArg56, numeroCostoVentaArg57, nombreCostoVentaArg58, idSeguridadPuertaArg59, numeroSeguridadPuertaArg60, nombreSeguridadPuertaArg61, equateSeguridadPuertaArg62, idSeguridadModuloArg63, numeroSeguridadModuloArg64, nombreSeguridadModuloArg65);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------