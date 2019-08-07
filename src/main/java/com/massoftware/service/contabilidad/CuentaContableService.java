package com.massoftware.service.contabilidad;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.CuentaContable;

public class CuentaContableService {

	private int levelDefault = 2;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(CuentaContable obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto CuentaContable no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object codigo = ( obj.getCodigo() == null ) ? String.class : obj.getCodigo();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;
		Object integra = ( obj.getIntegra() == null ) ? String.class : obj.getIntegra();
		Object cuentaJerarquia = ( obj.getCuentaJerarquia() == null ) ? String.class : obj.getCuentaJerarquia();
		Object imputable = ( obj.getImputable() == null ) ? Boolean.class : obj.getImputable();
		Object ajustaPorInflacion = ( obj.getAjustaPorInflacion() == null ) ? Boolean.class : obj.getAjustaPorInflacion();
		Object cuentaContableEstado = ( obj.getCuentaContableEstado() != null && obj.getCuentaContableEstado().getId() != null) ? obj.getCuentaContableEstado().getId() : String.class;
		Object cuentaConApropiacion = ( obj.getCuentaConApropiacion() == null ) ? Boolean.class : obj.getCuentaConApropiacion();
		Object centroCostoContable = ( obj.getCentroCostoContable() != null && obj.getCentroCostoContable().getId() != null) ? obj.getCentroCostoContable().getId() : String.class;
		Object cuentaAgrupadora = ( obj.getCuentaAgrupadora() == null ) ? String.class : obj.getCuentaAgrupadora();
		Object porcentaje = ( obj.getPorcentaje() == null ) ? java.math.BigDecimal.class : obj.getPorcentaje();
		Object puntoEquilibrio = ( obj.getPuntoEquilibrio() != null && obj.getPuntoEquilibrio().getId() != null) ? obj.getPuntoEquilibrio().getId() : String.class;
		Object costoVenta = ( obj.getCostoVenta() != null && obj.getCostoVenta().getId() != null) ? obj.getCostoVenta().getId() : String.class;
		Object seguridadPuerta = ( obj.getSeguridadPuerta() != null && obj.getSeguridadPuerta().getId() != null) ? obj.getSeguridadPuerta().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_CuentaContable(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, codigo, nombre, ejercicioContable, integra, cuentaJerarquia, imputable, ajustaPorInflacion, cuentaContableEstado, cuentaConApropiacion, centroCostoContable, cuentaAgrupadora, porcentaje, puntoEquilibrio, costoVenta, seguridadPuerta};

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


	public String update(CuentaContable obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto CuentaContable no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto CuentaContable con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object codigo = ( obj.getCodigo() == null ) ? String.class : obj.getCodigo();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;
		Object integra = ( obj.getIntegra() == null ) ? String.class : obj.getIntegra();
		Object cuentaJerarquia = ( obj.getCuentaJerarquia() == null ) ? String.class : obj.getCuentaJerarquia();
		Object imputable = ( obj.getImputable() == null ) ? Boolean.class : obj.getImputable();
		Object ajustaPorInflacion = ( obj.getAjustaPorInflacion() == null ) ? Boolean.class : obj.getAjustaPorInflacion();
		Object cuentaContableEstado = ( obj.getCuentaContableEstado() != null && obj.getCuentaContableEstado().getId() != null) ? obj.getCuentaContableEstado().getId() : String.class;
		Object cuentaConApropiacion = ( obj.getCuentaConApropiacion() == null ) ? Boolean.class : obj.getCuentaConApropiacion();
		Object centroCostoContable = ( obj.getCentroCostoContable() != null && obj.getCentroCostoContable().getId() != null) ? obj.getCentroCostoContable().getId() : String.class;
		Object cuentaAgrupadora = ( obj.getCuentaAgrupadora() == null ) ? String.class : obj.getCuentaAgrupadora();
		Object porcentaje = ( obj.getPorcentaje() == null ) ? java.math.BigDecimal.class : obj.getPorcentaje();
		Object puntoEquilibrio = ( obj.getPuntoEquilibrio() != null && obj.getPuntoEquilibrio().getId() != null) ? obj.getPuntoEquilibrio().getId() : String.class;
		Object costoVenta = ( obj.getCostoVenta() != null && obj.getCostoVenta().getId() != null) ? obj.getCostoVenta().getId() : String.class;
		Object seguridadPuerta = ( obj.getSeguridadPuerta() != null && obj.getSeguridadPuerta().getId() != null) ? obj.getSeguridadPuerta().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_CuentaContable(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, codigo, nombre, ejercicioContable, integra, cuentaJerarquia, imputable, ajustaPorInflacion, cuentaContableEstado, cuentaConApropiacion, centroCostoContable, cuentaAgrupadora, porcentaje, puntoEquilibrio, costoVenta, seguridadPuerta};

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
			throw new IllegalArgumentException("Se esperaba un id (CuentaContable.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_CuentaContableById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (CuentaContable.codigo) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_CuentaContable_codigo(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (CuentaContable.nombre) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_CuentaContable_nombre(?)";

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


	public java.math.BigDecimal nextValuePorcentaje() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_CuentaContable_porcentaje()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.CuentaContable;";

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


	public List<CuentaContable> findByCodigoOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (CuentaContable.codigo o CuentaContable.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Cuenta contable

		CuentaContableFiltro filtroCodigo = new CuentaContableFiltro();

		filtroCodigo.setUnlimited(true);

		filtroCodigo.setCodigo(arg);

		List<CuentaContable> listadoCodigo = find(filtroCodigo);

		if(listadoCodigo.size() > 0) {

			return listadoCodigo;

		}


		//------------ buscar por Nombre

		CuentaContableFiltro filtroNombre = new CuentaContableFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<CuentaContable> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<CuentaContable>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public CuentaContable findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public CuentaContable findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (CuentaContable.id) no nulo/vacio.");
		}

		id = id.trim();

		CuentaContable obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_CuentaContableById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 16) {

				obj = mapper16Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 38) {

				obj = mapper38Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 54) {

				obj = mapper54Fields(row);

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


	public List<CuentaContable> find(CuentaContableFiltro filtro) throws Exception {

		List<CuentaContable> listado = new ArrayList<CuentaContable>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_CuentaContable" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?)";

		Object codigo = ( filtro.getCodigo() == null ) ? String.class : filtro.getCodigo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();
		Object ejercicioContable = ( filtro.getEjercicioContable() != null && filtro.getEjercicioContable().getId() != null) ? filtro.getEjercicioContable().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, codigo, nombre, ejercicioContable};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), codigo, nombre, ejercicioContable};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 16) {

				CuentaContable obj = mapper16Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 38) {

				CuentaContable obj = mapper38Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 54) {

				CuentaContable obj = mapper54Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CuentaContable mapper16Fields(Object[] row) throws Exception {

		int c = -1;

		String idCuentaContableArg0 = (String) row[++c];
		String codigoCuentaContableArg1 = (String) row[++c];
		String nombreCuentaContableArg2 = (String) row[++c];
		String ejercicioContableCuentaContableArg3 = (String) row[++c]; // EjercicioContable.id
		String integraCuentaContableArg4 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg5 = (String) row[++c];
		Boolean imputableCuentaContableArg6 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg7 = (Boolean) row[++c];
		String cuentaContableEstadoCuentaContableArg8 = (String) row[++c]; // CuentaContableEstado.id
		Boolean cuentaConApropiacionCuentaContableArg9 = (Boolean) row[++c];
		String centroCostoContableCuentaContableArg10 = (String) row[++c]; // CentroCostoContable.id
		String cuentaAgrupadoraCuentaContableArg11 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg12 = (java.math.BigDecimal) row[++c];
		String puntoEquilibrioCuentaContableArg13 = (String) row[++c]; // PuntoEquilibrio.id
		String costoVentaCuentaContableArg14 = (String) row[++c]; // CostoVenta.id
		String seguridadPuertaCuentaContableArg15 = (String) row[++c]; // SeguridadPuerta.id

		CuentaContable obj = new CuentaContable(idCuentaContableArg0, codigoCuentaContableArg1, nombreCuentaContableArg2, ejercicioContableCuentaContableArg3, integraCuentaContableArg4, cuentaJerarquiaCuentaContableArg5, imputableCuentaContableArg6, ajustaPorInflacionCuentaContableArg7, cuentaContableEstadoCuentaContableArg8, cuentaConApropiacionCuentaContableArg9, centroCostoContableCuentaContableArg10, cuentaAgrupadoraCuentaContableArg11, porcentajeCuentaContableArg12, puntoEquilibrioCuentaContableArg13, costoVentaCuentaContableArg14, seguridadPuertaCuentaContableArg15);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CuentaContable mapper38Fields(Object[] row) throws Exception {

		int c = -1;

		String idCuentaContableArg0 = (String) row[++c];
		String codigoCuentaContableArg1 = (String) row[++c];
		String nombreCuentaContableArg2 = (String) row[++c];
		String idEjercicioContableArg3 = (String) row[++c];
		Integer numeroEjercicioContableArg4 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg5 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg6 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg7 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg8 = (Boolean) row[++c];
		String comentarioEjercicioContableArg9 = (String) row[++c];
		String integraCuentaContableArg10 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg11 = (String) row[++c];
		Boolean imputableCuentaContableArg12 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg13 = (Boolean) row[++c];
		String idCuentaContableEstadoArg14 = (String) row[++c];
		Integer numeroCuentaContableEstadoArg15 = (Integer) row[++c];
		String nombreCuentaContableEstadoArg16 = (String) row[++c];
		Boolean cuentaConApropiacionCuentaContableArg17 = (Boolean) row[++c];
		String idCentroCostoContableArg18 = (String) row[++c];
		Integer numeroCentroCostoContableArg19 = (Integer) row[++c];
		String nombreCentroCostoContableArg20 = (String) row[++c];
		String abreviaturaCentroCostoContableArg21 = (String) row[++c];
		String ejercicioContableCentroCostoContableArg22 = (String) row[++c]; // EjercicioContable.id
		String cuentaAgrupadoraCuentaContableArg23 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg24 = (java.math.BigDecimal) row[++c];
		String idPuntoEquilibrioArg25 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg26 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg27 = (String) row[++c];
		String tipoPuntoEquilibrioPuntoEquilibrioArg28 = (String) row[++c]; // TipoPuntoEquilibrio.id
		String ejercicioContablePuntoEquilibrioArg29 = (String) row[++c]; // EjercicioContable.id
		String idCostoVentaArg30 = (String) row[++c];
		Integer numeroCostoVentaArg31 = (Integer) row[++c];
		String nombreCostoVentaArg32 = (String) row[++c];
		String idSeguridadPuertaArg33 = (String) row[++c];
		Integer numeroSeguridadPuertaArg34 = (Integer) row[++c];
		String nombreSeguridadPuertaArg35 = (String) row[++c];
		String equateSeguridadPuertaArg36 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg37 = (String) row[++c]; // SeguridadModulo.id

		CuentaContable obj = new CuentaContable(idCuentaContableArg0, codigoCuentaContableArg1, nombreCuentaContableArg2, idEjercicioContableArg3, numeroEjercicioContableArg4, aperturaEjercicioContableArg5, cierreEjercicioContableArg6, cerradoEjercicioContableArg7, cerradoModulosEjercicioContableArg8, comentarioEjercicioContableArg9, integraCuentaContableArg10, cuentaJerarquiaCuentaContableArg11, imputableCuentaContableArg12, ajustaPorInflacionCuentaContableArg13, idCuentaContableEstadoArg14, numeroCuentaContableEstadoArg15, nombreCuentaContableEstadoArg16, cuentaConApropiacionCuentaContableArg17, idCentroCostoContableArg18, numeroCentroCostoContableArg19, nombreCentroCostoContableArg20, abreviaturaCentroCostoContableArg21, ejercicioContableCentroCostoContableArg22, cuentaAgrupadoraCuentaContableArg23, porcentajeCuentaContableArg24, idPuntoEquilibrioArg25, numeroPuntoEquilibrioArg26, nombrePuntoEquilibrioArg27, tipoPuntoEquilibrioPuntoEquilibrioArg28, ejercicioContablePuntoEquilibrioArg29, idCostoVentaArg30, numeroCostoVentaArg31, nombreCostoVentaArg32, idSeguridadPuertaArg33, numeroSeguridadPuertaArg34, nombreSeguridadPuertaArg35, equateSeguridadPuertaArg36, seguridadModuloSeguridadPuertaArg37);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CuentaContable mapper54Fields(Object[] row) throws Exception {

		int c = -1;

		String idCuentaContableArg0 = (String) row[++c];
		String codigoCuentaContableArg1 = (String) row[++c];
		String nombreCuentaContableArg2 = (String) row[++c];
		String idEjercicioContableArg3 = (String) row[++c];
		Integer numeroEjercicioContableArg4 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg5 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg6 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg7 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg8 = (Boolean) row[++c];
		String comentarioEjercicioContableArg9 = (String) row[++c];
		String integraCuentaContableArg10 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg11 = (String) row[++c];
		Boolean imputableCuentaContableArg12 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg13 = (Boolean) row[++c];
		String idCuentaContableEstadoArg14 = (String) row[++c];
		Integer numeroCuentaContableEstadoArg15 = (Integer) row[++c];
		String nombreCuentaContableEstadoArg16 = (String) row[++c];
		Boolean cuentaConApropiacionCuentaContableArg17 = (Boolean) row[++c];
		String idCentroCostoContableArg18 = (String) row[++c];
		Integer numeroCentroCostoContableArg19 = (Integer) row[++c];
		String nombreCentroCostoContableArg20 = (String) row[++c];
		String abreviaturaCentroCostoContableArg21 = (String) row[++c];
		String idEjercicioContableArg22 = (String) row[++c];
		Integer numeroEjercicioContableArg23 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg24 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg25 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg26 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg27 = (Boolean) row[++c];
		String comentarioEjercicioContableArg28 = (String) row[++c];
		String cuentaAgrupadoraCuentaContableArg29 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg30 = (java.math.BigDecimal) row[++c];
		String idPuntoEquilibrioArg31 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg32 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg33 = (String) row[++c];
		String idTipoPuntoEquilibrioArg34 = (String) row[++c];
		Integer numeroTipoPuntoEquilibrioArg35 = (Integer) row[++c];
		String nombreTipoPuntoEquilibrioArg36 = (String) row[++c];
		String idEjercicioContableArg37 = (String) row[++c];
		Integer numeroEjercicioContableArg38 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg39 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg40 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg41 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg42 = (Boolean) row[++c];
		String comentarioEjercicioContableArg43 = (String) row[++c];
		String idCostoVentaArg44 = (String) row[++c];
		Integer numeroCostoVentaArg45 = (Integer) row[++c];
		String nombreCostoVentaArg46 = (String) row[++c];
		String idSeguridadPuertaArg47 = (String) row[++c];
		Integer numeroSeguridadPuertaArg48 = (Integer) row[++c];
		String nombreSeguridadPuertaArg49 = (String) row[++c];
		String equateSeguridadPuertaArg50 = (String) row[++c];
		String idSeguridadModuloArg51 = (String) row[++c];
		Integer numeroSeguridadModuloArg52 = (Integer) row[++c];
		String nombreSeguridadModuloArg53 = (String) row[++c];

		CuentaContable obj = new CuentaContable(idCuentaContableArg0, codigoCuentaContableArg1, nombreCuentaContableArg2, idEjercicioContableArg3, numeroEjercicioContableArg4, aperturaEjercicioContableArg5, cierreEjercicioContableArg6, cerradoEjercicioContableArg7, cerradoModulosEjercicioContableArg8, comentarioEjercicioContableArg9, integraCuentaContableArg10, cuentaJerarquiaCuentaContableArg11, imputableCuentaContableArg12, ajustaPorInflacionCuentaContableArg13, idCuentaContableEstadoArg14, numeroCuentaContableEstadoArg15, nombreCuentaContableEstadoArg16, cuentaConApropiacionCuentaContableArg17, idCentroCostoContableArg18, numeroCentroCostoContableArg19, nombreCentroCostoContableArg20, abreviaturaCentroCostoContableArg21, idEjercicioContableArg22, numeroEjercicioContableArg23, aperturaEjercicioContableArg24, cierreEjercicioContableArg25, cerradoEjercicioContableArg26, cerradoModulosEjercicioContableArg27, comentarioEjercicioContableArg28, cuentaAgrupadoraCuentaContableArg29, porcentajeCuentaContableArg30, idPuntoEquilibrioArg31, numeroPuntoEquilibrioArg32, nombrePuntoEquilibrioArg33, idTipoPuntoEquilibrioArg34, numeroTipoPuntoEquilibrioArg35, nombreTipoPuntoEquilibrioArg36, idEjercicioContableArg37, numeroEjercicioContableArg38, aperturaEjercicioContableArg39, cierreEjercicioContableArg40, cerradoEjercicioContableArg41, cerradoModulosEjercicioContableArg42, comentarioEjercicioContableArg43, idCostoVentaArg44, numeroCostoVentaArg45, nombreCostoVentaArg46, idSeguridadPuertaArg47, numeroSeguridadPuertaArg48, nombreSeguridadPuertaArg49, equateSeguridadPuertaArg50, idSeguridadModuloArg51, numeroSeguridadModuloArg52, nombreSeguridadModuloArg53);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------