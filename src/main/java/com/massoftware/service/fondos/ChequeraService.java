package com.massoftware.service.fondos;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.Chequera;

public class ChequeraService {

	private int levelDefault = 3;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Chequera obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Chequera no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object cuentaFondo = ( obj.getCuentaFondo() != null && obj.getCuentaFondo().getId() != null) ? obj.getCuentaFondo().getId() : String.class;
		Object primerNumero = ( obj.getPrimerNumero() == null ) ? Integer.class : obj.getPrimerNumero();
		Object ultimoNumero = ( obj.getUltimoNumero() == null ) ? Integer.class : obj.getUltimoNumero();
		Object proximoNumero = ( obj.getProximoNumero() == null ) ? Integer.class : obj.getProximoNumero();
		Object bloqueado = ( obj.getBloqueado() == null ) ? Boolean.class : obj.getBloqueado();
		Object impresionDiferida = ( obj.getImpresionDiferida() == null ) ? Boolean.class : obj.getImpresionDiferida();
		Object formato = ( obj.getFormato() == null ) ? String.class : obj.getFormato();

		String sql = "SELECT * FROM massoftware.i_Chequera(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, cuentaFondo, primerNumero, ultimoNumero, proximoNumero, bloqueado, impresionDiferida, formato};

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


	public String update(Chequera obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Chequera no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto Chequera con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object cuentaFondo = ( obj.getCuentaFondo() != null && obj.getCuentaFondo().getId() != null) ? obj.getCuentaFondo().getId() : String.class;
		Object primerNumero = ( obj.getPrimerNumero() == null ) ? Integer.class : obj.getPrimerNumero();
		Object ultimoNumero = ( obj.getUltimoNumero() == null ) ? Integer.class : obj.getUltimoNumero();
		Object proximoNumero = ( obj.getProximoNumero() == null ) ? Integer.class : obj.getProximoNumero();
		Object bloqueado = ( obj.getBloqueado() == null ) ? Boolean.class : obj.getBloqueado();
		Object impresionDiferida = ( obj.getImpresionDiferida() == null ) ? Boolean.class : obj.getImpresionDiferida();
		Object formato = ( obj.getFormato() == null ) ? String.class : obj.getFormato();

		String sql = "SELECT * FROM massoftware.u_Chequera(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, cuentaFondo, primerNumero, ultimoNumero, proximoNumero, bloqueado, impresionDiferida, formato};

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

			throw new IllegalArgumentException("Se esperaba un id (Chequera.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_ChequeraById(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Chequera.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_Chequera_numero(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (Chequera.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Chequera_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_Chequera_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValuePrimerNumero() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Chequera_primerNumero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueUltimoNumero() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Chequera_ultimoNumero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public Integer nextValueProximoNumero() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Chequera_proximoNumero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.Chequera;";

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


	public List<Chequera> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Chequera.numero o Chequera.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº chequera

		if(UtilNumeric.isInteger(arg)) {

			ChequeraFiltro filtroNumero = new ChequeraFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Chequera> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		ChequeraFiltro filtroNombre = new ChequeraFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Chequera> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Chequera>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Chequera findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Chequera findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (Chequera.id) no nulo/vacio.");

		}


		id = id.trim();


		Chequera obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_ChequeraById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 10) {

				obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 37) {

				obj = mapper37Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 96) {

				obj = mapper96Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 132) {

				obj = mapper132Fields(row);

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


	public List<Chequera> find(ChequeraFiltro filtro) throws Exception {

		List<Chequera> listado = new ArrayList<Chequera>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_Chequera" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();
		Object cuentaFondo = ( filtro.getCuentaFondo() != null && filtro.getCuentaFondo().getId() != null) ? filtro.getCuentaFondo().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre, cuentaFondo};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre, cuentaFondo};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 10) {

				Chequera obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 37) {

				Chequera obj = mapper37Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 96) {

				Chequera obj = mapper96Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 132) {

				Chequera obj = mapper132Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Chequera mapper10Fields(Object[] row) throws Exception {

		int c = -1;

		String idChequeraArg0 = (String) row[++c];
		Integer numeroChequeraArg1 = (Integer) row[++c];
		String nombreChequeraArg2 = (String) row[++c];
		String cuentaFondoChequeraArg3 = (String) row[++c]; // CuentaFondo.id
		Integer primerNumeroChequeraArg4 = (Integer) row[++c];
		Integer ultimoNumeroChequeraArg5 = (Integer) row[++c];
		Integer proximoNumeroChequeraArg6 = (Integer) row[++c];
		Boolean bloqueadoChequeraArg7 = (Boolean) row[++c];
		Boolean impresionDiferidaChequeraArg8 = (Boolean) row[++c];
		String formatoChequeraArg9 = (String) row[++c];

		Chequera obj = new Chequera(idChequeraArg0, numeroChequeraArg1, nombreChequeraArg2, cuentaFondoChequeraArg3, primerNumeroChequeraArg4, ultimoNumeroChequeraArg5, proximoNumeroChequeraArg6, bloqueadoChequeraArg7, impresionDiferidaChequeraArg8, formatoChequeraArg9);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Chequera mapper37Fields(Object[] row) throws Exception {

		int c = -1;

		String idChequeraArg0 = (String) row[++c];
		Integer numeroChequeraArg1 = (Integer) row[++c];
		String nombreChequeraArg2 = (String) row[++c];
		String idCuentaFondoArg3 = (String) row[++c];
		Integer numeroCuentaFondoArg4 = (Integer) row[++c];
		String nombreCuentaFondoArg5 = (String) row[++c];
		String cuentaContableCuentaFondoArg6 = (String) row[++c]; // CuentaContable.id
		String cuentaFondoGrupoCuentaFondoArg7 = (String) row[++c]; // CuentaFondoGrupo.id
		String cuentaFondoTipoCuentaFondoArg8 = (String) row[++c]; // CuentaFondoTipo.id
		Boolean obsoletoCuentaFondoArg9 = (Boolean) row[++c];
		Boolean noImprimeCajaCuentaFondoArg10 = (Boolean) row[++c];
		Boolean ventasCuentaFondoArg11 = (Boolean) row[++c];
		Boolean fondosCuentaFondoArg12 = (Boolean) row[++c];
		Boolean comprasCuentaFondoArg13 = (Boolean) row[++c];
		String monedaCuentaFondoArg14 = (String) row[++c]; // Moneda.id
		String cajaCuentaFondoArg15 = (String) row[++c]; // Caja.id
		Boolean rechazadosCuentaFondoArg16 = (Boolean) row[++c];
		Boolean conciliacionCuentaFondoArg17 = (Boolean) row[++c];
		String cuentaFondoTipoBancoCuentaFondoArg18 = (String) row[++c]; // CuentaFondoTipoBanco.id
		String bancoCuentaFondoArg19 = (String) row[++c]; // Banco.id
		String cuentaBancariaCuentaFondoArg20 = (String) row[++c];
		String cbuCuentaFondoArg21 = (String) row[++c];
		java.math.BigDecimal limiteDescubiertoCuentaFondoArg22 = (java.math.BigDecimal) row[++c];
		String cuentaFondoCaucionCuentaFondoArg23 = (String) row[++c];
		String cuentaFondoDiferidosCuentaFondoArg24 = (String) row[++c];
		String formatoCuentaFondoArg25 = (String) row[++c];
		String cuentaFondoBancoCopiaCuentaFondoArg26 = (String) row[++c]; // CuentaFondoBancoCopia.id
		java.math.BigDecimal limiteOperacionIndividualCuentaFondoArg27 = (java.math.BigDecimal) row[++c];
		String seguridadPuertaUsoCuentaFondoArg28 = (String) row[++c]; // SeguridadPuerta.id
		String seguridadPuertaConsultaCuentaFondoArg29 = (String) row[++c]; // SeguridadPuerta.id
		String seguridadPuertaLimiteCuentaFondoArg30 = (String) row[++c]; // SeguridadPuerta.id
		Integer primerNumeroChequeraArg31 = (Integer) row[++c];
		Integer ultimoNumeroChequeraArg32 = (Integer) row[++c];
		Integer proximoNumeroChequeraArg33 = (Integer) row[++c];
		Boolean bloqueadoChequeraArg34 = (Boolean) row[++c];
		Boolean impresionDiferidaChequeraArg35 = (Boolean) row[++c];
		String formatoChequeraArg36 = (String) row[++c];

		Chequera obj = new Chequera(idChequeraArg0, numeroChequeraArg1, nombreChequeraArg2, idCuentaFondoArg3, numeroCuentaFondoArg4, nombreCuentaFondoArg5, cuentaContableCuentaFondoArg6, cuentaFondoGrupoCuentaFondoArg7, cuentaFondoTipoCuentaFondoArg8, obsoletoCuentaFondoArg9, noImprimeCajaCuentaFondoArg10, ventasCuentaFondoArg11, fondosCuentaFondoArg12, comprasCuentaFondoArg13, monedaCuentaFondoArg14, cajaCuentaFondoArg15, rechazadosCuentaFondoArg16, conciliacionCuentaFondoArg17, cuentaFondoTipoBancoCuentaFondoArg18, bancoCuentaFondoArg19, cuentaBancariaCuentaFondoArg20, cbuCuentaFondoArg21, limiteDescubiertoCuentaFondoArg22, cuentaFondoCaucionCuentaFondoArg23, cuentaFondoDiferidosCuentaFondoArg24, formatoCuentaFondoArg25, cuentaFondoBancoCopiaCuentaFondoArg26, limiteOperacionIndividualCuentaFondoArg27, seguridadPuertaUsoCuentaFondoArg28, seguridadPuertaConsultaCuentaFondoArg29, seguridadPuertaLimiteCuentaFondoArg30, primerNumeroChequeraArg31, ultimoNumeroChequeraArg32, proximoNumeroChequeraArg33, bloqueadoChequeraArg34, impresionDiferidaChequeraArg35, formatoChequeraArg36);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Chequera mapper96Fields(Object[] row) throws Exception {

		int c = -1;

		String idChequeraArg0 = (String) row[++c];
		Integer numeroChequeraArg1 = (Integer) row[++c];
		String nombreChequeraArg2 = (String) row[++c];
		String idCuentaFondoArg3 = (String) row[++c];
		Integer numeroCuentaFondoArg4 = (Integer) row[++c];
		String nombreCuentaFondoArg5 = (String) row[++c];
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
		String idCuentaFondoGrupoArg22 = (String) row[++c];
		Integer numeroCuentaFondoGrupoArg23 = (Integer) row[++c];
		String nombreCuentaFondoGrupoArg24 = (String) row[++c];
		String cuentaFondoRubroCuentaFondoGrupoArg25 = (String) row[++c]; // CuentaFondoRubro.id
		String idCuentaFondoTipoArg26 = (String) row[++c];
		Integer numeroCuentaFondoTipoArg27 = (Integer) row[++c];
		String nombreCuentaFondoTipoArg28 = (String) row[++c];
		Boolean obsoletoCuentaFondoArg29 = (Boolean) row[++c];
		Boolean noImprimeCajaCuentaFondoArg30 = (Boolean) row[++c];
		Boolean ventasCuentaFondoArg31 = (Boolean) row[++c];
		Boolean fondosCuentaFondoArg32 = (Boolean) row[++c];
		Boolean comprasCuentaFondoArg33 = (Boolean) row[++c];
		String idMonedaArg34 = (String) row[++c];
		Integer numeroMonedaArg35 = (Integer) row[++c];
		String nombreMonedaArg36 = (String) row[++c];
		String abreviaturaMonedaArg37 = (String) row[++c];
		java.math.BigDecimal cotizacionMonedaArg38 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaArg39 = (java.sql.Timestamp) row[++c];
		Boolean controlActualizacionMonedaArg40 = (Boolean) row[++c];
		String monedaAFIPMonedaArg41 = (String) row[++c]; // MonedaAFIP.id
		String idCajaArg42 = (String) row[++c];
		Integer numeroCajaArg43 = (Integer) row[++c];
		String nombreCajaArg44 = (String) row[++c];
		String seguridadPuertaCajaArg45 = (String) row[++c]; // SeguridadPuerta.id
		Boolean rechazadosCuentaFondoArg46 = (Boolean) row[++c];
		Boolean conciliacionCuentaFondoArg47 = (Boolean) row[++c];
		String idCuentaFondoTipoBancoArg48 = (String) row[++c];
		Integer numeroCuentaFondoTipoBancoArg49 = (Integer) row[++c];
		String nombreCuentaFondoTipoBancoArg50 = (String) row[++c];
		String idBancoArg51 = (String) row[++c];
		Integer numeroBancoArg52 = (Integer) row[++c];
		String nombreBancoArg53 = (String) row[++c];
		Long cuitBancoArg54 = (Long) row[++c];
		Boolean bloqueadoBancoArg55 = (Boolean) row[++c];
		Integer hojaBancoArg56 = (Integer) row[++c];
		Integer primeraFilaBancoArg57 = (Integer) row[++c];
		Integer ultimaFilaBancoArg58 = (Integer) row[++c];
		String fechaBancoArg59 = (String) row[++c];
		String descripcionBancoArg60 = (String) row[++c];
		String referencia1BancoArg61 = (String) row[++c];
		String importeBancoArg62 = (String) row[++c];
		String referencia2BancoArg63 = (String) row[++c];
		String saldoBancoArg64 = (String) row[++c];
		String cuentaBancariaCuentaFondoArg65 = (String) row[++c];
		String cbuCuentaFondoArg66 = (String) row[++c];
		java.math.BigDecimal limiteDescubiertoCuentaFondoArg67 = (java.math.BigDecimal) row[++c];
		String cuentaFondoCaucionCuentaFondoArg68 = (String) row[++c];
		String cuentaFondoDiferidosCuentaFondoArg69 = (String) row[++c];
		String formatoCuentaFondoArg70 = (String) row[++c];
		String idCuentaFondoBancoCopiaArg71 = (String) row[++c];
		Integer numeroCuentaFondoBancoCopiaArg72 = (Integer) row[++c];
		String nombreCuentaFondoBancoCopiaArg73 = (String) row[++c];
		java.math.BigDecimal limiteOperacionIndividualCuentaFondoArg74 = (java.math.BigDecimal) row[++c];
		String idSeguridadPuertaArg75 = (String) row[++c];
		Integer numeroSeguridadPuertaArg76 = (Integer) row[++c];
		String nombreSeguridadPuertaArg77 = (String) row[++c];
		String equateSeguridadPuertaArg78 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg79 = (String) row[++c]; // SeguridadModulo.id
		String idSeguridadPuertaArg80 = (String) row[++c];
		Integer numeroSeguridadPuertaArg81 = (Integer) row[++c];
		String nombreSeguridadPuertaArg82 = (String) row[++c];
		String equateSeguridadPuertaArg83 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg84 = (String) row[++c]; // SeguridadModulo.id
		String idSeguridadPuertaArg85 = (String) row[++c];
		Integer numeroSeguridadPuertaArg86 = (Integer) row[++c];
		String nombreSeguridadPuertaArg87 = (String) row[++c];
		String equateSeguridadPuertaArg88 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg89 = (String) row[++c]; // SeguridadModulo.id
		Integer primerNumeroChequeraArg90 = (Integer) row[++c];
		Integer ultimoNumeroChequeraArg91 = (Integer) row[++c];
		Integer proximoNumeroChequeraArg92 = (Integer) row[++c];
		Boolean bloqueadoChequeraArg93 = (Boolean) row[++c];
		Boolean impresionDiferidaChequeraArg94 = (Boolean) row[++c];
		String formatoChequeraArg95 = (String) row[++c];

		Chequera obj = new Chequera(idChequeraArg0, numeroChequeraArg1, nombreChequeraArg2, idCuentaFondoArg3, numeroCuentaFondoArg4, nombreCuentaFondoArg5, idCuentaContableArg6, codigoCuentaContableArg7, nombreCuentaContableArg8, ejercicioContableCuentaContableArg9, integraCuentaContableArg10, cuentaJerarquiaCuentaContableArg11, imputableCuentaContableArg12, ajustaPorInflacionCuentaContableArg13, cuentaContableEstadoCuentaContableArg14, cuentaConApropiacionCuentaContableArg15, centroCostoContableCuentaContableArg16, cuentaAgrupadoraCuentaContableArg17, porcentajeCuentaContableArg18, puntoEquilibrioCuentaContableArg19, costoVentaCuentaContableArg20, seguridadPuertaCuentaContableArg21, idCuentaFondoGrupoArg22, numeroCuentaFondoGrupoArg23, nombreCuentaFondoGrupoArg24, cuentaFondoRubroCuentaFondoGrupoArg25, idCuentaFondoTipoArg26, numeroCuentaFondoTipoArg27, nombreCuentaFondoTipoArg28, obsoletoCuentaFondoArg29, noImprimeCajaCuentaFondoArg30, ventasCuentaFondoArg31, fondosCuentaFondoArg32, comprasCuentaFondoArg33, idMonedaArg34, numeroMonedaArg35, nombreMonedaArg36, abreviaturaMonedaArg37, cotizacionMonedaArg38, cotizacionFechaMonedaArg39, controlActualizacionMonedaArg40, monedaAFIPMonedaArg41, idCajaArg42, numeroCajaArg43, nombreCajaArg44, seguridadPuertaCajaArg45, rechazadosCuentaFondoArg46, conciliacionCuentaFondoArg47, idCuentaFondoTipoBancoArg48, numeroCuentaFondoTipoBancoArg49, nombreCuentaFondoTipoBancoArg50, idBancoArg51, numeroBancoArg52, nombreBancoArg53, cuitBancoArg54, bloqueadoBancoArg55, hojaBancoArg56, primeraFilaBancoArg57, ultimaFilaBancoArg58, fechaBancoArg59, descripcionBancoArg60, referencia1BancoArg61, importeBancoArg62, referencia2BancoArg63, saldoBancoArg64, cuentaBancariaCuentaFondoArg65, cbuCuentaFondoArg66, limiteDescubiertoCuentaFondoArg67, cuentaFondoCaucionCuentaFondoArg68, cuentaFondoDiferidosCuentaFondoArg69, formatoCuentaFondoArg70, idCuentaFondoBancoCopiaArg71, numeroCuentaFondoBancoCopiaArg72, nombreCuentaFondoBancoCopiaArg73, limiteOperacionIndividualCuentaFondoArg74, idSeguridadPuertaArg75, numeroSeguridadPuertaArg76, nombreSeguridadPuertaArg77, equateSeguridadPuertaArg78, seguridadModuloSeguridadPuertaArg79, idSeguridadPuertaArg80, numeroSeguridadPuertaArg81, nombreSeguridadPuertaArg82, equateSeguridadPuertaArg83, seguridadModuloSeguridadPuertaArg84, idSeguridadPuertaArg85, numeroSeguridadPuertaArg86, nombreSeguridadPuertaArg87, equateSeguridadPuertaArg88, seguridadModuloSeguridadPuertaArg89, primerNumeroChequeraArg90, ultimoNumeroChequeraArg91, proximoNumeroChequeraArg92, bloqueadoChequeraArg93, impresionDiferidaChequeraArg94, formatoChequeraArg95);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Chequera mapper132Fields(Object[] row) throws Exception {

		int c = -1;

		String idChequeraArg0 = (String) row[++c];
		Integer numeroChequeraArg1 = (Integer) row[++c];
		String nombreChequeraArg2 = (String) row[++c];
		String idCuentaFondoArg3 = (String) row[++c];
		Integer numeroCuentaFondoArg4 = (Integer) row[++c];
		String nombreCuentaFondoArg5 = (String) row[++c];
		String idCuentaContableArg6 = (String) row[++c];
		String codigoCuentaContableArg7 = (String) row[++c];
		String nombreCuentaContableArg8 = (String) row[++c];
		String idEjercicioContableArg9 = (String) row[++c];
		Integer numeroEjercicioContableArg10 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg11 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg12 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg13 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg14 = (Boolean) row[++c];
		String comentarioEjercicioContableArg15 = (String) row[++c];
		String integraCuentaContableArg16 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg17 = (String) row[++c];
		Boolean imputableCuentaContableArg18 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg19 = (Boolean) row[++c];
		String idCuentaContableEstadoArg20 = (String) row[++c];
		Integer numeroCuentaContableEstadoArg21 = (Integer) row[++c];
		String nombreCuentaContableEstadoArg22 = (String) row[++c];
		Boolean cuentaConApropiacionCuentaContableArg23 = (Boolean) row[++c];
		String idCentroCostoContableArg24 = (String) row[++c];
		Integer numeroCentroCostoContableArg25 = (Integer) row[++c];
		String nombreCentroCostoContableArg26 = (String) row[++c];
		String abreviaturaCentroCostoContableArg27 = (String) row[++c];
		String ejercicioContableCentroCostoContableArg28 = (String) row[++c]; // EjercicioContable.id
		String cuentaAgrupadoraCuentaContableArg29 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg30 = (java.math.BigDecimal) row[++c];
		String idPuntoEquilibrioArg31 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg32 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg33 = (String) row[++c];
		String tipoPuntoEquilibrioPuntoEquilibrioArg34 = (String) row[++c]; // TipoPuntoEquilibrio.id
		String ejercicioContablePuntoEquilibrioArg35 = (String) row[++c]; // EjercicioContable.id
		String idCostoVentaArg36 = (String) row[++c];
		Integer numeroCostoVentaArg37 = (Integer) row[++c];
		String nombreCostoVentaArg38 = (String) row[++c];
		String idSeguridadPuertaArg39 = (String) row[++c];
		Integer numeroSeguridadPuertaArg40 = (Integer) row[++c];
		String nombreSeguridadPuertaArg41 = (String) row[++c];
		String equateSeguridadPuertaArg42 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg43 = (String) row[++c]; // SeguridadModulo.id
		String idCuentaFondoGrupoArg44 = (String) row[++c];
		Integer numeroCuentaFondoGrupoArg45 = (Integer) row[++c];
		String nombreCuentaFondoGrupoArg46 = (String) row[++c];
		String idCuentaFondoRubroArg47 = (String) row[++c];
		Integer numeroCuentaFondoRubroArg48 = (Integer) row[++c];
		String nombreCuentaFondoRubroArg49 = (String) row[++c];
		String idCuentaFondoTipoArg50 = (String) row[++c];
		Integer numeroCuentaFondoTipoArg51 = (Integer) row[++c];
		String nombreCuentaFondoTipoArg52 = (String) row[++c];
		Boolean obsoletoCuentaFondoArg53 = (Boolean) row[++c];
		Boolean noImprimeCajaCuentaFondoArg54 = (Boolean) row[++c];
		Boolean ventasCuentaFondoArg55 = (Boolean) row[++c];
		Boolean fondosCuentaFondoArg56 = (Boolean) row[++c];
		Boolean comprasCuentaFondoArg57 = (Boolean) row[++c];
		String idMonedaArg58 = (String) row[++c];
		Integer numeroMonedaArg59 = (Integer) row[++c];
		String nombreMonedaArg60 = (String) row[++c];
		String abreviaturaMonedaArg61 = (String) row[++c];
		java.math.BigDecimal cotizacionMonedaArg62 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaArg63 = (java.sql.Timestamp) row[++c];
		Boolean controlActualizacionMonedaArg64 = (Boolean) row[++c];
		String idMonedaAFIPArg65 = (String) row[++c];
		String codigoMonedaAFIPArg66 = (String) row[++c];
		String nombreMonedaAFIPArg67 = (String) row[++c];
		String idCajaArg68 = (String) row[++c];
		Integer numeroCajaArg69 = (Integer) row[++c];
		String nombreCajaArg70 = (String) row[++c];
		String idSeguridadPuertaArg71 = (String) row[++c];
		Integer numeroSeguridadPuertaArg72 = (Integer) row[++c];
		String nombreSeguridadPuertaArg73 = (String) row[++c];
		String equateSeguridadPuertaArg74 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg75 = (String) row[++c]; // SeguridadModulo.id
		Boolean rechazadosCuentaFondoArg76 = (Boolean) row[++c];
		Boolean conciliacionCuentaFondoArg77 = (Boolean) row[++c];
		String idCuentaFondoTipoBancoArg78 = (String) row[++c];
		Integer numeroCuentaFondoTipoBancoArg79 = (Integer) row[++c];
		String nombreCuentaFondoTipoBancoArg80 = (String) row[++c];
		String idBancoArg81 = (String) row[++c];
		Integer numeroBancoArg82 = (Integer) row[++c];
		String nombreBancoArg83 = (String) row[++c];
		Long cuitBancoArg84 = (Long) row[++c];
		Boolean bloqueadoBancoArg85 = (Boolean) row[++c];
		Integer hojaBancoArg86 = (Integer) row[++c];
		Integer primeraFilaBancoArg87 = (Integer) row[++c];
		Integer ultimaFilaBancoArg88 = (Integer) row[++c];
		String fechaBancoArg89 = (String) row[++c];
		String descripcionBancoArg90 = (String) row[++c];
		String referencia1BancoArg91 = (String) row[++c];
		String importeBancoArg92 = (String) row[++c];
		String referencia2BancoArg93 = (String) row[++c];
		String saldoBancoArg94 = (String) row[++c];
		String cuentaBancariaCuentaFondoArg95 = (String) row[++c];
		String cbuCuentaFondoArg96 = (String) row[++c];
		java.math.BigDecimal limiteDescubiertoCuentaFondoArg97 = (java.math.BigDecimal) row[++c];
		String cuentaFondoCaucionCuentaFondoArg98 = (String) row[++c];
		String cuentaFondoDiferidosCuentaFondoArg99 = (String) row[++c];
		String formatoCuentaFondoArg100 = (String) row[++c];
		String idCuentaFondoBancoCopiaArg101 = (String) row[++c];
		Integer numeroCuentaFondoBancoCopiaArg102 = (Integer) row[++c];
		String nombreCuentaFondoBancoCopiaArg103 = (String) row[++c];
		java.math.BigDecimal limiteOperacionIndividualCuentaFondoArg104 = (java.math.BigDecimal) row[++c];
		String idSeguridadPuertaArg105 = (String) row[++c];
		Integer numeroSeguridadPuertaArg106 = (Integer) row[++c];
		String nombreSeguridadPuertaArg107 = (String) row[++c];
		String equateSeguridadPuertaArg108 = (String) row[++c];
		String idSeguridadModuloArg109 = (String) row[++c];
		Integer numeroSeguridadModuloArg110 = (Integer) row[++c];
		String nombreSeguridadModuloArg111 = (String) row[++c];
		String idSeguridadPuertaArg112 = (String) row[++c];
		Integer numeroSeguridadPuertaArg113 = (Integer) row[++c];
		String nombreSeguridadPuertaArg114 = (String) row[++c];
		String equateSeguridadPuertaArg115 = (String) row[++c];
		String idSeguridadModuloArg116 = (String) row[++c];
		Integer numeroSeguridadModuloArg117 = (Integer) row[++c];
		String nombreSeguridadModuloArg118 = (String) row[++c];
		String idSeguridadPuertaArg119 = (String) row[++c];
		Integer numeroSeguridadPuertaArg120 = (Integer) row[++c];
		String nombreSeguridadPuertaArg121 = (String) row[++c];
		String equateSeguridadPuertaArg122 = (String) row[++c];
		String idSeguridadModuloArg123 = (String) row[++c];
		Integer numeroSeguridadModuloArg124 = (Integer) row[++c];
		String nombreSeguridadModuloArg125 = (String) row[++c];
		Integer primerNumeroChequeraArg126 = (Integer) row[++c];
		Integer ultimoNumeroChequeraArg127 = (Integer) row[++c];
		Integer proximoNumeroChequeraArg128 = (Integer) row[++c];
		Boolean bloqueadoChequeraArg129 = (Boolean) row[++c];
		Boolean impresionDiferidaChequeraArg130 = (Boolean) row[++c];
		String formatoChequeraArg131 = (String) row[++c];

		Chequera obj = new Chequera(idChequeraArg0, numeroChequeraArg1, nombreChequeraArg2, idCuentaFondoArg3, numeroCuentaFondoArg4, nombreCuentaFondoArg5, idCuentaContableArg6, codigoCuentaContableArg7, nombreCuentaContableArg8, idEjercicioContableArg9, numeroEjercicioContableArg10, aperturaEjercicioContableArg11, cierreEjercicioContableArg12, cerradoEjercicioContableArg13, cerradoModulosEjercicioContableArg14, comentarioEjercicioContableArg15, integraCuentaContableArg16, cuentaJerarquiaCuentaContableArg17, imputableCuentaContableArg18, ajustaPorInflacionCuentaContableArg19, idCuentaContableEstadoArg20, numeroCuentaContableEstadoArg21, nombreCuentaContableEstadoArg22, cuentaConApropiacionCuentaContableArg23, idCentroCostoContableArg24, numeroCentroCostoContableArg25, nombreCentroCostoContableArg26, abreviaturaCentroCostoContableArg27, ejercicioContableCentroCostoContableArg28, cuentaAgrupadoraCuentaContableArg29, porcentajeCuentaContableArg30, idPuntoEquilibrioArg31, numeroPuntoEquilibrioArg32, nombrePuntoEquilibrioArg33, tipoPuntoEquilibrioPuntoEquilibrioArg34, ejercicioContablePuntoEquilibrioArg35, idCostoVentaArg36, numeroCostoVentaArg37, nombreCostoVentaArg38, idSeguridadPuertaArg39, numeroSeguridadPuertaArg40, nombreSeguridadPuertaArg41, equateSeguridadPuertaArg42, seguridadModuloSeguridadPuertaArg43, idCuentaFondoGrupoArg44, numeroCuentaFondoGrupoArg45, nombreCuentaFondoGrupoArg46, idCuentaFondoRubroArg47, numeroCuentaFondoRubroArg48, nombreCuentaFondoRubroArg49, idCuentaFondoTipoArg50, numeroCuentaFondoTipoArg51, nombreCuentaFondoTipoArg52, obsoletoCuentaFondoArg53, noImprimeCajaCuentaFondoArg54, ventasCuentaFondoArg55, fondosCuentaFondoArg56, comprasCuentaFondoArg57, idMonedaArg58, numeroMonedaArg59, nombreMonedaArg60, abreviaturaMonedaArg61, cotizacionMonedaArg62, cotizacionFechaMonedaArg63, controlActualizacionMonedaArg64, idMonedaAFIPArg65, codigoMonedaAFIPArg66, nombreMonedaAFIPArg67, idCajaArg68, numeroCajaArg69, nombreCajaArg70, idSeguridadPuertaArg71, numeroSeguridadPuertaArg72, nombreSeguridadPuertaArg73, equateSeguridadPuertaArg74, seguridadModuloSeguridadPuertaArg75, rechazadosCuentaFondoArg76, conciliacionCuentaFondoArg77, idCuentaFondoTipoBancoArg78, numeroCuentaFondoTipoBancoArg79, nombreCuentaFondoTipoBancoArg80, idBancoArg81, numeroBancoArg82, nombreBancoArg83, cuitBancoArg84, bloqueadoBancoArg85, hojaBancoArg86, primeraFilaBancoArg87, ultimaFilaBancoArg88, fechaBancoArg89, descripcionBancoArg90, referencia1BancoArg91, importeBancoArg92, referencia2BancoArg93, saldoBancoArg94, cuentaBancariaCuentaFondoArg95, cbuCuentaFondoArg96, limiteDescubiertoCuentaFondoArg97, cuentaFondoCaucionCuentaFondoArg98, cuentaFondoDiferidosCuentaFondoArg99, formatoCuentaFondoArg100, idCuentaFondoBancoCopiaArg101, numeroCuentaFondoBancoCopiaArg102, nombreCuentaFondoBancoCopiaArg103, limiteOperacionIndividualCuentaFondoArg104, idSeguridadPuertaArg105, numeroSeguridadPuertaArg106, nombreSeguridadPuertaArg107, equateSeguridadPuertaArg108, idSeguridadModuloArg109, numeroSeguridadModuloArg110, nombreSeguridadModuloArg111, idSeguridadPuertaArg112, numeroSeguridadPuertaArg113, nombreSeguridadPuertaArg114, equateSeguridadPuertaArg115, idSeguridadModuloArg116, numeroSeguridadModuloArg117, nombreSeguridadModuloArg118, idSeguridadPuertaArg119, numeroSeguridadPuertaArg120, nombreSeguridadPuertaArg121, equateSeguridadPuertaArg122, idSeguridadModuloArg123, numeroSeguridadModuloArg124, nombreSeguridadModuloArg125, primerNumeroChequeraArg126, ultimoNumeroChequeraArg127, proximoNumeroChequeraArg128, bloqueadoChequeraArg129, impresionDiferidaChequeraArg130, formatoChequeraArg131);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------