package com.massoftware.service.fondos;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.ComprobanteFondoModeloItem;
import com.massoftware.service.UtilNumeric;

public class ComprobanteFondoModeloItemService {

	private int levelDefault = 3;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(ComprobanteFondoModeloItem obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto ComprobanteFondoModeloItem no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object debe = ( obj.getDebe() == null ) ? Boolean.class : obj.getDebe();
		Object comprobanteFondoModelo = ( obj.getComprobanteFondoModelo() != null && obj.getComprobanteFondoModelo().getId() != null) ? obj.getComprobanteFondoModelo().getId() : String.class;
		Object cuentaFondo = ( obj.getCuentaFondo() != null && obj.getCuentaFondo().getId() != null) ? obj.getCuentaFondo().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_ComprobanteFondoModeloItem(?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, debe, comprobanteFondoModelo, cuentaFondo};

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


	public String update(ComprobanteFondoModeloItem obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto ComprobanteFondoModeloItem no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto ComprobanteFondoModeloItem con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object debe = ( obj.getDebe() == null ) ? Boolean.class : obj.getDebe();
		Object comprobanteFondoModelo = ( obj.getComprobanteFondoModelo() != null && obj.getComprobanteFondoModelo().getId() != null) ? obj.getComprobanteFondoModelo().getId() : String.class;
		Object cuentaFondo = ( obj.getCuentaFondo() != null && obj.getCuentaFondo().getId() != null) ? obj.getCuentaFondo().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_ComprobanteFondoModeloItem(?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, debe, comprobanteFondoModelo, cuentaFondo};

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
			throw new IllegalArgumentException("Se esperaba un id (ComprobanteFondoModeloItem.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_ComprobanteFondoModeloItemById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (ComprobanteFondoModeloItem.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_ComprobanteFondoModeloItem_numero(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_ComprobanteFondoModeloItem_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.ComprobanteFondoModeloItem;";

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


	public List<ComprobanteFondoModeloItem> findByNumero(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (ComprobanteFondoModeloItem.numero) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº modelo

		if(UtilNumeric.isInteger(arg)) {

			ComprobanteFondoModeloItemFiltro filtroNumero = new ComprobanteFondoModeloItemFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<ComprobanteFondoModeloItem> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		return new ArrayList<ComprobanteFondoModeloItem>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public ComprobanteFondoModeloItem findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public ComprobanteFondoModeloItem findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (ComprobanteFondoModeloItem.id) no nulo/vacio.");
		}

		id = id.trim();

		ComprobanteFondoModeloItem obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_ComprobanteFondoModeloItemById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 5) {

				obj = mapper5Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 34) {

				obj = mapper34Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 93) {

				obj = mapper93Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 129) {

				obj = mapper129Fields(row);

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


	public List<ComprobanteFondoModeloItem> find(ComprobanteFondoModeloItemFiltro filtro) throws Exception {

		List<ComprobanteFondoModeloItem> listado = new ArrayList<ComprobanteFondoModeloItem>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_ComprobanteFondoModeloItem" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object cuentaFondo = ( filtro.getCuentaFondo() != null && filtro.getCuentaFondo().getId() != null) ? filtro.getCuentaFondo().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, cuentaFondo};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, cuentaFondo};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 5) {

				ComprobanteFondoModeloItem obj = mapper5Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 34) {

				ComprobanteFondoModeloItem obj = mapper34Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 93) {

				ComprobanteFondoModeloItem obj = mapper93Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 129) {

				ComprobanteFondoModeloItem obj = mapper129Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private ComprobanteFondoModeloItem mapper5Fields(Object[] row) throws Exception {

		int c = -1;

		String idComprobanteFondoModeloItemArg0 = (String) row[++c];
		Integer numeroComprobanteFondoModeloItemArg1 = (Integer) row[++c];
		Boolean debeComprobanteFondoModeloItemArg2 = (Boolean) row[++c];
		String comprobanteFondoModeloComprobanteFondoModeloItemArg3 = (String) row[++c]; // ComprobanteFondoModelo.id
		String cuentaFondoComprobanteFondoModeloItemArg4 = (String) row[++c]; // CuentaFondo.id

		ComprobanteFondoModeloItem obj = new ComprobanteFondoModeloItem(idComprobanteFondoModeloItemArg0, numeroComprobanteFondoModeloItemArg1, debeComprobanteFondoModeloItemArg2, comprobanteFondoModeloComprobanteFondoModeloItemArg3, cuentaFondoComprobanteFondoModeloItemArg4);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private ComprobanteFondoModeloItem mapper34Fields(Object[] row) throws Exception {

		int c = -1;

		String idComprobanteFondoModeloItemArg0 = (String) row[++c];
		Integer numeroComprobanteFondoModeloItemArg1 = (Integer) row[++c];
		Boolean debeComprobanteFondoModeloItemArg2 = (Boolean) row[++c];
		String idComprobanteFondoModeloArg3 = (String) row[++c];
		Integer numeroComprobanteFondoModeloArg4 = (Integer) row[++c];
		String nombreComprobanteFondoModeloArg5 = (String) row[++c];
		String idCuentaFondoArg6 = (String) row[++c];
		Integer numeroCuentaFondoArg7 = (Integer) row[++c];
		String nombreCuentaFondoArg8 = (String) row[++c];
		String cuentaContableCuentaFondoArg9 = (String) row[++c]; // CuentaContable.id
		String cuentaFondoGrupoCuentaFondoArg10 = (String) row[++c]; // CuentaFondoGrupo.id
		String cuentaFondoTipoCuentaFondoArg11 = (String) row[++c]; // CuentaFondoTipo.id
		Boolean obsoletoCuentaFondoArg12 = (Boolean) row[++c];
		Boolean noImprimeCajaCuentaFondoArg13 = (Boolean) row[++c];
		Boolean ventasCuentaFondoArg14 = (Boolean) row[++c];
		Boolean fondosCuentaFondoArg15 = (Boolean) row[++c];
		Boolean comprasCuentaFondoArg16 = (Boolean) row[++c];
		String monedaCuentaFondoArg17 = (String) row[++c]; // Moneda.id
		String cajaCuentaFondoArg18 = (String) row[++c]; // Caja.id
		Boolean rechazadosCuentaFondoArg19 = (Boolean) row[++c];
		Boolean conciliacionCuentaFondoArg20 = (Boolean) row[++c];
		String cuentaFondoTipoBancoCuentaFondoArg21 = (String) row[++c]; // CuentaFondoTipoBanco.id
		String bancoCuentaFondoArg22 = (String) row[++c]; // Banco.id
		String cuentaBancariaCuentaFondoArg23 = (String) row[++c];
		String cbuCuentaFondoArg24 = (String) row[++c];
		java.math.BigDecimal limiteDescubiertoCuentaFondoArg25 = (java.math.BigDecimal) row[++c];
		String cuentaFondoCaucionCuentaFondoArg26 = (String) row[++c];
		String cuentaFondoDiferidosCuentaFondoArg27 = (String) row[++c];
		String formatoCuentaFondoArg28 = (String) row[++c];
		String cuentaFondoBancoCopiaCuentaFondoArg29 = (String) row[++c]; // CuentaFondoBancoCopia.id
		java.math.BigDecimal limiteOperacionIndividualCuentaFondoArg30 = (java.math.BigDecimal) row[++c];
		String seguridadPuertaUsoCuentaFondoArg31 = (String) row[++c]; // SeguridadPuerta.id
		String seguridadPuertaConsultaCuentaFondoArg32 = (String) row[++c]; // SeguridadPuerta.id
		String seguridadPuertaLimiteCuentaFondoArg33 = (String) row[++c]; // SeguridadPuerta.id

		ComprobanteFondoModeloItem obj = new ComprobanteFondoModeloItem(idComprobanteFondoModeloItemArg0, numeroComprobanteFondoModeloItemArg1, debeComprobanteFondoModeloItemArg2, idComprobanteFondoModeloArg3, numeroComprobanteFondoModeloArg4, nombreComprobanteFondoModeloArg5, idCuentaFondoArg6, numeroCuentaFondoArg7, nombreCuentaFondoArg8, cuentaContableCuentaFondoArg9, cuentaFondoGrupoCuentaFondoArg10, cuentaFondoTipoCuentaFondoArg11, obsoletoCuentaFondoArg12, noImprimeCajaCuentaFondoArg13, ventasCuentaFondoArg14, fondosCuentaFondoArg15, comprasCuentaFondoArg16, monedaCuentaFondoArg17, cajaCuentaFondoArg18, rechazadosCuentaFondoArg19, conciliacionCuentaFondoArg20, cuentaFondoTipoBancoCuentaFondoArg21, bancoCuentaFondoArg22, cuentaBancariaCuentaFondoArg23, cbuCuentaFondoArg24, limiteDescubiertoCuentaFondoArg25, cuentaFondoCaucionCuentaFondoArg26, cuentaFondoDiferidosCuentaFondoArg27, formatoCuentaFondoArg28, cuentaFondoBancoCopiaCuentaFondoArg29, limiteOperacionIndividualCuentaFondoArg30, seguridadPuertaUsoCuentaFondoArg31, seguridadPuertaConsultaCuentaFondoArg32, seguridadPuertaLimiteCuentaFondoArg33);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private ComprobanteFondoModeloItem mapper93Fields(Object[] row) throws Exception {

		int c = -1;

		String idComprobanteFondoModeloItemArg0 = (String) row[++c];
		Integer numeroComprobanteFondoModeloItemArg1 = (Integer) row[++c];
		Boolean debeComprobanteFondoModeloItemArg2 = (Boolean) row[++c];
		String idComprobanteFondoModeloArg3 = (String) row[++c];
		Integer numeroComprobanteFondoModeloArg4 = (Integer) row[++c];
		String nombreComprobanteFondoModeloArg5 = (String) row[++c];
		String idCuentaFondoArg6 = (String) row[++c];
		Integer numeroCuentaFondoArg7 = (Integer) row[++c];
		String nombreCuentaFondoArg8 = (String) row[++c];
		String idCuentaContableArg9 = (String) row[++c];
		String codigoCuentaContableArg10 = (String) row[++c];
		String nombreCuentaContableArg11 = (String) row[++c];
		String ejercicioContableCuentaContableArg12 = (String) row[++c]; // EjercicioContable.id
		String integraCuentaContableArg13 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg14 = (String) row[++c];
		Boolean imputableCuentaContableArg15 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg16 = (Boolean) row[++c];
		String cuentaContableEstadoCuentaContableArg17 = (String) row[++c]; // CuentaContableEstado.id
		Boolean cuentaConApropiacionCuentaContableArg18 = (Boolean) row[++c];
		String centroCostoContableCuentaContableArg19 = (String) row[++c]; // CentroCostoContable.id
		String cuentaAgrupadoraCuentaContableArg20 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg21 = (java.math.BigDecimal) row[++c];
		String puntoEquilibrioCuentaContableArg22 = (String) row[++c]; // PuntoEquilibrio.id
		String costoVentaCuentaContableArg23 = (String) row[++c]; // CostoVenta.id
		String seguridadPuertaCuentaContableArg24 = (String) row[++c]; // SeguridadPuerta.id
		String idCuentaFondoGrupoArg25 = (String) row[++c];
		Integer numeroCuentaFondoGrupoArg26 = (Integer) row[++c];
		String nombreCuentaFondoGrupoArg27 = (String) row[++c];
		String cuentaFondoRubroCuentaFondoGrupoArg28 = (String) row[++c]; // CuentaFondoRubro.id
		String idCuentaFondoTipoArg29 = (String) row[++c];
		Integer numeroCuentaFondoTipoArg30 = (Integer) row[++c];
		String nombreCuentaFondoTipoArg31 = (String) row[++c];
		Boolean obsoletoCuentaFondoArg32 = (Boolean) row[++c];
		Boolean noImprimeCajaCuentaFondoArg33 = (Boolean) row[++c];
		Boolean ventasCuentaFondoArg34 = (Boolean) row[++c];
		Boolean fondosCuentaFondoArg35 = (Boolean) row[++c];
		Boolean comprasCuentaFondoArg36 = (Boolean) row[++c];
		String idMonedaArg37 = (String) row[++c];
		Integer numeroMonedaArg38 = (Integer) row[++c];
		String nombreMonedaArg39 = (String) row[++c];
		String abreviaturaMonedaArg40 = (String) row[++c];
		java.math.BigDecimal cotizacionMonedaArg41 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaArg42 = (java.sql.Timestamp) row[++c];
		Boolean controlActualizacionMonedaArg43 = (Boolean) row[++c];
		String monedaAFIPMonedaArg44 = (String) row[++c]; // MonedaAFIP.id
		String idCajaArg45 = (String) row[++c];
		Integer numeroCajaArg46 = (Integer) row[++c];
		String nombreCajaArg47 = (String) row[++c];
		String seguridadPuertaCajaArg48 = (String) row[++c]; // SeguridadPuerta.id
		Boolean rechazadosCuentaFondoArg49 = (Boolean) row[++c];
		Boolean conciliacionCuentaFondoArg50 = (Boolean) row[++c];
		String idCuentaFondoTipoBancoArg51 = (String) row[++c];
		Integer numeroCuentaFondoTipoBancoArg52 = (Integer) row[++c];
		String nombreCuentaFondoTipoBancoArg53 = (String) row[++c];
		String idBancoArg54 = (String) row[++c];
		Integer numeroBancoArg55 = (Integer) row[++c];
		String nombreBancoArg56 = (String) row[++c];
		Long cuitBancoArg57 = (Long) row[++c];
		Boolean bloqueadoBancoArg58 = (Boolean) row[++c];
		Integer hojaBancoArg59 = (Integer) row[++c];
		Integer primeraFilaBancoArg60 = (Integer) row[++c];
		Integer ultimaFilaBancoArg61 = (Integer) row[++c];
		String fechaBancoArg62 = (String) row[++c];
		String descripcionBancoArg63 = (String) row[++c];
		String referencia1BancoArg64 = (String) row[++c];
		String importeBancoArg65 = (String) row[++c];
		String referencia2BancoArg66 = (String) row[++c];
		String saldoBancoArg67 = (String) row[++c];
		String cuentaBancariaCuentaFondoArg68 = (String) row[++c];
		String cbuCuentaFondoArg69 = (String) row[++c];
		java.math.BigDecimal limiteDescubiertoCuentaFondoArg70 = (java.math.BigDecimal) row[++c];
		String cuentaFondoCaucionCuentaFondoArg71 = (String) row[++c];
		String cuentaFondoDiferidosCuentaFondoArg72 = (String) row[++c];
		String formatoCuentaFondoArg73 = (String) row[++c];
		String idCuentaFondoBancoCopiaArg74 = (String) row[++c];
		Integer numeroCuentaFondoBancoCopiaArg75 = (Integer) row[++c];
		String nombreCuentaFondoBancoCopiaArg76 = (String) row[++c];
		java.math.BigDecimal limiteOperacionIndividualCuentaFondoArg77 = (java.math.BigDecimal) row[++c];
		String idSeguridadPuertaArg78 = (String) row[++c];
		Integer numeroSeguridadPuertaArg79 = (Integer) row[++c];
		String nombreSeguridadPuertaArg80 = (String) row[++c];
		String equateSeguridadPuertaArg81 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg82 = (String) row[++c]; // SeguridadModulo.id
		String idSeguridadPuertaArg83 = (String) row[++c];
		Integer numeroSeguridadPuertaArg84 = (Integer) row[++c];
		String nombreSeguridadPuertaArg85 = (String) row[++c];
		String equateSeguridadPuertaArg86 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg87 = (String) row[++c]; // SeguridadModulo.id
		String idSeguridadPuertaArg88 = (String) row[++c];
		Integer numeroSeguridadPuertaArg89 = (Integer) row[++c];
		String nombreSeguridadPuertaArg90 = (String) row[++c];
		String equateSeguridadPuertaArg91 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg92 = (String) row[++c]; // SeguridadModulo.id

		ComprobanteFondoModeloItem obj = new ComprobanteFondoModeloItem(idComprobanteFondoModeloItemArg0, numeroComprobanteFondoModeloItemArg1, debeComprobanteFondoModeloItemArg2, idComprobanteFondoModeloArg3, numeroComprobanteFondoModeloArg4, nombreComprobanteFondoModeloArg5, idCuentaFondoArg6, numeroCuentaFondoArg7, nombreCuentaFondoArg8, idCuentaContableArg9, codigoCuentaContableArg10, nombreCuentaContableArg11, ejercicioContableCuentaContableArg12, integraCuentaContableArg13, cuentaJerarquiaCuentaContableArg14, imputableCuentaContableArg15, ajustaPorInflacionCuentaContableArg16, cuentaContableEstadoCuentaContableArg17, cuentaConApropiacionCuentaContableArg18, centroCostoContableCuentaContableArg19, cuentaAgrupadoraCuentaContableArg20, porcentajeCuentaContableArg21, puntoEquilibrioCuentaContableArg22, costoVentaCuentaContableArg23, seguridadPuertaCuentaContableArg24, idCuentaFondoGrupoArg25, numeroCuentaFondoGrupoArg26, nombreCuentaFondoGrupoArg27, cuentaFondoRubroCuentaFondoGrupoArg28, idCuentaFondoTipoArg29, numeroCuentaFondoTipoArg30, nombreCuentaFondoTipoArg31, obsoletoCuentaFondoArg32, noImprimeCajaCuentaFondoArg33, ventasCuentaFondoArg34, fondosCuentaFondoArg35, comprasCuentaFondoArg36, idMonedaArg37, numeroMonedaArg38, nombreMonedaArg39, abreviaturaMonedaArg40, cotizacionMonedaArg41, cotizacionFechaMonedaArg42, controlActualizacionMonedaArg43, monedaAFIPMonedaArg44, idCajaArg45, numeroCajaArg46, nombreCajaArg47, seguridadPuertaCajaArg48, rechazadosCuentaFondoArg49, conciliacionCuentaFondoArg50, idCuentaFondoTipoBancoArg51, numeroCuentaFondoTipoBancoArg52, nombreCuentaFondoTipoBancoArg53, idBancoArg54, numeroBancoArg55, nombreBancoArg56, cuitBancoArg57, bloqueadoBancoArg58, hojaBancoArg59, primeraFilaBancoArg60, ultimaFilaBancoArg61, fechaBancoArg62, descripcionBancoArg63, referencia1BancoArg64, importeBancoArg65, referencia2BancoArg66, saldoBancoArg67, cuentaBancariaCuentaFondoArg68, cbuCuentaFondoArg69, limiteDescubiertoCuentaFondoArg70, cuentaFondoCaucionCuentaFondoArg71, cuentaFondoDiferidosCuentaFondoArg72, formatoCuentaFondoArg73, idCuentaFondoBancoCopiaArg74, numeroCuentaFondoBancoCopiaArg75, nombreCuentaFondoBancoCopiaArg76, limiteOperacionIndividualCuentaFondoArg77, idSeguridadPuertaArg78, numeroSeguridadPuertaArg79, nombreSeguridadPuertaArg80, equateSeguridadPuertaArg81, seguridadModuloSeguridadPuertaArg82, idSeguridadPuertaArg83, numeroSeguridadPuertaArg84, nombreSeguridadPuertaArg85, equateSeguridadPuertaArg86, seguridadModuloSeguridadPuertaArg87, idSeguridadPuertaArg88, numeroSeguridadPuertaArg89, nombreSeguridadPuertaArg90, equateSeguridadPuertaArg91, seguridadModuloSeguridadPuertaArg92);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private ComprobanteFondoModeloItem mapper129Fields(Object[] row) throws Exception {

		int c = -1;

		String idComprobanteFondoModeloItemArg0 = (String) row[++c];
		Integer numeroComprobanteFondoModeloItemArg1 = (Integer) row[++c];
		Boolean debeComprobanteFondoModeloItemArg2 = (Boolean) row[++c];
		String idComprobanteFondoModeloArg3 = (String) row[++c];
		Integer numeroComprobanteFondoModeloArg4 = (Integer) row[++c];
		String nombreComprobanteFondoModeloArg5 = (String) row[++c];
		String idCuentaFondoArg6 = (String) row[++c];
		Integer numeroCuentaFondoArg7 = (Integer) row[++c];
		String nombreCuentaFondoArg8 = (String) row[++c];
		String idCuentaContableArg9 = (String) row[++c];
		String codigoCuentaContableArg10 = (String) row[++c];
		String nombreCuentaContableArg11 = (String) row[++c];
		String idEjercicioContableArg12 = (String) row[++c];
		Integer numeroEjercicioContableArg13 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg14 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg15 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg16 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg17 = (Boolean) row[++c];
		String comentarioEjercicioContableArg18 = (String) row[++c];
		String integraCuentaContableArg19 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg20 = (String) row[++c];
		Boolean imputableCuentaContableArg21 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg22 = (Boolean) row[++c];
		String idCuentaContableEstadoArg23 = (String) row[++c];
		Integer numeroCuentaContableEstadoArg24 = (Integer) row[++c];
		String nombreCuentaContableEstadoArg25 = (String) row[++c];
		Boolean cuentaConApropiacionCuentaContableArg26 = (Boolean) row[++c];
		String idCentroCostoContableArg27 = (String) row[++c];
		Integer numeroCentroCostoContableArg28 = (Integer) row[++c];
		String nombreCentroCostoContableArg29 = (String) row[++c];
		String abreviaturaCentroCostoContableArg30 = (String) row[++c];
		String ejercicioContableCentroCostoContableArg31 = (String) row[++c]; // EjercicioContable.id
		String cuentaAgrupadoraCuentaContableArg32 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg33 = (java.math.BigDecimal) row[++c];
		String idPuntoEquilibrioArg34 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg35 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg36 = (String) row[++c];
		String tipoPuntoEquilibrioPuntoEquilibrioArg37 = (String) row[++c]; // TipoPuntoEquilibrio.id
		String ejercicioContablePuntoEquilibrioArg38 = (String) row[++c]; // EjercicioContable.id
		String idCostoVentaArg39 = (String) row[++c];
		Integer numeroCostoVentaArg40 = (Integer) row[++c];
		String nombreCostoVentaArg41 = (String) row[++c];
		String idSeguridadPuertaArg42 = (String) row[++c];
		Integer numeroSeguridadPuertaArg43 = (Integer) row[++c];
		String nombreSeguridadPuertaArg44 = (String) row[++c];
		String equateSeguridadPuertaArg45 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg46 = (String) row[++c]; // SeguridadModulo.id
		String idCuentaFondoGrupoArg47 = (String) row[++c];
		Integer numeroCuentaFondoGrupoArg48 = (Integer) row[++c];
		String nombreCuentaFondoGrupoArg49 = (String) row[++c];
		String idCuentaFondoRubroArg50 = (String) row[++c];
		Integer numeroCuentaFondoRubroArg51 = (Integer) row[++c];
		String nombreCuentaFondoRubroArg52 = (String) row[++c];
		String idCuentaFondoTipoArg53 = (String) row[++c];
		Integer numeroCuentaFondoTipoArg54 = (Integer) row[++c];
		String nombreCuentaFondoTipoArg55 = (String) row[++c];
		Boolean obsoletoCuentaFondoArg56 = (Boolean) row[++c];
		Boolean noImprimeCajaCuentaFondoArg57 = (Boolean) row[++c];
		Boolean ventasCuentaFondoArg58 = (Boolean) row[++c];
		Boolean fondosCuentaFondoArg59 = (Boolean) row[++c];
		Boolean comprasCuentaFondoArg60 = (Boolean) row[++c];
		String idMonedaArg61 = (String) row[++c];
		Integer numeroMonedaArg62 = (Integer) row[++c];
		String nombreMonedaArg63 = (String) row[++c];
		String abreviaturaMonedaArg64 = (String) row[++c];
		java.math.BigDecimal cotizacionMonedaArg65 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaArg66 = (java.sql.Timestamp) row[++c];
		Boolean controlActualizacionMonedaArg67 = (Boolean) row[++c];
		String idMonedaAFIPArg68 = (String) row[++c];
		String codigoMonedaAFIPArg69 = (String) row[++c];
		String nombreMonedaAFIPArg70 = (String) row[++c];
		String idCajaArg71 = (String) row[++c];
		Integer numeroCajaArg72 = (Integer) row[++c];
		String nombreCajaArg73 = (String) row[++c];
		String idSeguridadPuertaArg74 = (String) row[++c];
		Integer numeroSeguridadPuertaArg75 = (Integer) row[++c];
		String nombreSeguridadPuertaArg76 = (String) row[++c];
		String equateSeguridadPuertaArg77 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg78 = (String) row[++c]; // SeguridadModulo.id
		Boolean rechazadosCuentaFondoArg79 = (Boolean) row[++c];
		Boolean conciliacionCuentaFondoArg80 = (Boolean) row[++c];
		String idCuentaFondoTipoBancoArg81 = (String) row[++c];
		Integer numeroCuentaFondoTipoBancoArg82 = (Integer) row[++c];
		String nombreCuentaFondoTipoBancoArg83 = (String) row[++c];
		String idBancoArg84 = (String) row[++c];
		Integer numeroBancoArg85 = (Integer) row[++c];
		String nombreBancoArg86 = (String) row[++c];
		Long cuitBancoArg87 = (Long) row[++c];
		Boolean bloqueadoBancoArg88 = (Boolean) row[++c];
		Integer hojaBancoArg89 = (Integer) row[++c];
		Integer primeraFilaBancoArg90 = (Integer) row[++c];
		Integer ultimaFilaBancoArg91 = (Integer) row[++c];
		String fechaBancoArg92 = (String) row[++c];
		String descripcionBancoArg93 = (String) row[++c];
		String referencia1BancoArg94 = (String) row[++c];
		String importeBancoArg95 = (String) row[++c];
		String referencia2BancoArg96 = (String) row[++c];
		String saldoBancoArg97 = (String) row[++c];
		String cuentaBancariaCuentaFondoArg98 = (String) row[++c];
		String cbuCuentaFondoArg99 = (String) row[++c];
		java.math.BigDecimal limiteDescubiertoCuentaFondoArg100 = (java.math.BigDecimal) row[++c];
		String cuentaFondoCaucionCuentaFondoArg101 = (String) row[++c];
		String cuentaFondoDiferidosCuentaFondoArg102 = (String) row[++c];
		String formatoCuentaFondoArg103 = (String) row[++c];
		String idCuentaFondoBancoCopiaArg104 = (String) row[++c];
		Integer numeroCuentaFondoBancoCopiaArg105 = (Integer) row[++c];
		String nombreCuentaFondoBancoCopiaArg106 = (String) row[++c];
		java.math.BigDecimal limiteOperacionIndividualCuentaFondoArg107 = (java.math.BigDecimal) row[++c];
		String idSeguridadPuertaArg108 = (String) row[++c];
		Integer numeroSeguridadPuertaArg109 = (Integer) row[++c];
		String nombreSeguridadPuertaArg110 = (String) row[++c];
		String equateSeguridadPuertaArg111 = (String) row[++c];
		String idSeguridadModuloArg112 = (String) row[++c];
		Integer numeroSeguridadModuloArg113 = (Integer) row[++c];
		String nombreSeguridadModuloArg114 = (String) row[++c];
		String idSeguridadPuertaArg115 = (String) row[++c];
		Integer numeroSeguridadPuertaArg116 = (Integer) row[++c];
		String nombreSeguridadPuertaArg117 = (String) row[++c];
		String equateSeguridadPuertaArg118 = (String) row[++c];
		String idSeguridadModuloArg119 = (String) row[++c];
		Integer numeroSeguridadModuloArg120 = (Integer) row[++c];
		String nombreSeguridadModuloArg121 = (String) row[++c];
		String idSeguridadPuertaArg122 = (String) row[++c];
		Integer numeroSeguridadPuertaArg123 = (Integer) row[++c];
		String nombreSeguridadPuertaArg124 = (String) row[++c];
		String equateSeguridadPuertaArg125 = (String) row[++c];
		String idSeguridadModuloArg126 = (String) row[++c];
		Integer numeroSeguridadModuloArg127 = (Integer) row[++c];
		String nombreSeguridadModuloArg128 = (String) row[++c];

		ComprobanteFondoModeloItem obj = new ComprobanteFondoModeloItem(idComprobanteFondoModeloItemArg0, numeroComprobanteFondoModeloItemArg1, debeComprobanteFondoModeloItemArg2, idComprobanteFondoModeloArg3, numeroComprobanteFondoModeloArg4, nombreComprobanteFondoModeloArg5, idCuentaFondoArg6, numeroCuentaFondoArg7, nombreCuentaFondoArg8, idCuentaContableArg9, codigoCuentaContableArg10, nombreCuentaContableArg11, idEjercicioContableArg12, numeroEjercicioContableArg13, aperturaEjercicioContableArg14, cierreEjercicioContableArg15, cerradoEjercicioContableArg16, cerradoModulosEjercicioContableArg17, comentarioEjercicioContableArg18, integraCuentaContableArg19, cuentaJerarquiaCuentaContableArg20, imputableCuentaContableArg21, ajustaPorInflacionCuentaContableArg22, idCuentaContableEstadoArg23, numeroCuentaContableEstadoArg24, nombreCuentaContableEstadoArg25, cuentaConApropiacionCuentaContableArg26, idCentroCostoContableArg27, numeroCentroCostoContableArg28, nombreCentroCostoContableArg29, abreviaturaCentroCostoContableArg30, ejercicioContableCentroCostoContableArg31, cuentaAgrupadoraCuentaContableArg32, porcentajeCuentaContableArg33, idPuntoEquilibrioArg34, numeroPuntoEquilibrioArg35, nombrePuntoEquilibrioArg36, tipoPuntoEquilibrioPuntoEquilibrioArg37, ejercicioContablePuntoEquilibrioArg38, idCostoVentaArg39, numeroCostoVentaArg40, nombreCostoVentaArg41, idSeguridadPuertaArg42, numeroSeguridadPuertaArg43, nombreSeguridadPuertaArg44, equateSeguridadPuertaArg45, seguridadModuloSeguridadPuertaArg46, idCuentaFondoGrupoArg47, numeroCuentaFondoGrupoArg48, nombreCuentaFondoGrupoArg49, idCuentaFondoRubroArg50, numeroCuentaFondoRubroArg51, nombreCuentaFondoRubroArg52, idCuentaFondoTipoArg53, numeroCuentaFondoTipoArg54, nombreCuentaFondoTipoArg55, obsoletoCuentaFondoArg56, noImprimeCajaCuentaFondoArg57, ventasCuentaFondoArg58, fondosCuentaFondoArg59, comprasCuentaFondoArg60, idMonedaArg61, numeroMonedaArg62, nombreMonedaArg63, abreviaturaMonedaArg64, cotizacionMonedaArg65, cotizacionFechaMonedaArg66, controlActualizacionMonedaArg67, idMonedaAFIPArg68, codigoMonedaAFIPArg69, nombreMonedaAFIPArg70, idCajaArg71, numeroCajaArg72, nombreCajaArg73, idSeguridadPuertaArg74, numeroSeguridadPuertaArg75, nombreSeguridadPuertaArg76, equateSeguridadPuertaArg77, seguridadModuloSeguridadPuertaArg78, rechazadosCuentaFondoArg79, conciliacionCuentaFondoArg80, idCuentaFondoTipoBancoArg81, numeroCuentaFondoTipoBancoArg82, nombreCuentaFondoTipoBancoArg83, idBancoArg84, numeroBancoArg85, nombreBancoArg86, cuitBancoArg87, bloqueadoBancoArg88, hojaBancoArg89, primeraFilaBancoArg90, ultimaFilaBancoArg91, fechaBancoArg92, descripcionBancoArg93, referencia1BancoArg94, importeBancoArg95, referencia2BancoArg96, saldoBancoArg97, cuentaBancariaCuentaFondoArg98, cbuCuentaFondoArg99, limiteDescubiertoCuentaFondoArg100, cuentaFondoCaucionCuentaFondoArg101, cuentaFondoDiferidosCuentaFondoArg102, formatoCuentaFondoArg103, idCuentaFondoBancoCopiaArg104, numeroCuentaFondoBancoCopiaArg105, nombreCuentaFondoBancoCopiaArg106, limiteOperacionIndividualCuentaFondoArg107, idSeguridadPuertaArg108, numeroSeguridadPuertaArg109, nombreSeguridadPuertaArg110, equateSeguridadPuertaArg111, idSeguridadModuloArg112, numeroSeguridadModuloArg113, nombreSeguridadModuloArg114, idSeguridadPuertaArg115, numeroSeguridadPuertaArg116, nombreSeguridadPuertaArg117, equateSeguridadPuertaArg118, idSeguridadModuloArg119, numeroSeguridadModuloArg120, nombreSeguridadModuloArg121, idSeguridadPuertaArg122, numeroSeguridadPuertaArg123, nombreSeguridadPuertaArg124, equateSeguridadPuertaArg125, idSeguridadModuloArg126, numeroSeguridadModuloArg127, nombreSeguridadModuloArg128);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------