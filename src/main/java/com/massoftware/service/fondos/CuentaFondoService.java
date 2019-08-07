package com.massoftware.service.fondos;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.CuentaFondo;
import com.massoftware.service.UtilNumeric;

public class CuentaFondoService {

	private int levelDefault = 3;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(CuentaFondo obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto CuentaFondo no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object cuentaContable = ( obj.getCuentaContable() != null && obj.getCuentaContable().getId() != null) ? obj.getCuentaContable().getId() : String.class;
		Object cuentaFondoGrupo = ( obj.getCuentaFondoGrupo() != null && obj.getCuentaFondoGrupo().getId() != null) ? obj.getCuentaFondoGrupo().getId() : String.class;
		Object cuentaFondoTipo = ( obj.getCuentaFondoTipo() != null && obj.getCuentaFondoTipo().getId() != null) ? obj.getCuentaFondoTipo().getId() : String.class;
		Object obsoleto = ( obj.getObsoleto() == null ) ? Boolean.class : obj.getObsoleto();
		Object noImprimeCaja = ( obj.getNoImprimeCaja() == null ) ? Boolean.class : obj.getNoImprimeCaja();
		Object ventas = ( obj.getVentas() == null ) ? Boolean.class : obj.getVentas();
		Object fondos = ( obj.getFondos() == null ) ? Boolean.class : obj.getFondos();
		Object compras = ( obj.getCompras() == null ) ? Boolean.class : obj.getCompras();
		Object moneda = ( obj.getMoneda() != null && obj.getMoneda().getId() != null) ? obj.getMoneda().getId() : String.class;
		Object caja = ( obj.getCaja() != null && obj.getCaja().getId() != null) ? obj.getCaja().getId() : String.class;
		Object rechazados = ( obj.getRechazados() == null ) ? Boolean.class : obj.getRechazados();
		Object conciliacion = ( obj.getConciliacion() == null ) ? Boolean.class : obj.getConciliacion();
		Object cuentaFondoTipoBanco = ( obj.getCuentaFondoTipoBanco() != null && obj.getCuentaFondoTipoBanco().getId() != null) ? obj.getCuentaFondoTipoBanco().getId() : String.class;
		Object banco = ( obj.getBanco() != null && obj.getBanco().getId() != null) ? obj.getBanco().getId() : String.class;
		Object cuentaBancaria = ( obj.getCuentaBancaria() == null ) ? String.class : obj.getCuentaBancaria();
		Object cbu = ( obj.getCbu() == null ) ? String.class : obj.getCbu();
		Object limiteDescubierto = ( obj.getLimiteDescubierto() == null ) ? java.math.BigDecimal.class : obj.getLimiteDescubierto();
		Object cuentaFondoCaucion = ( obj.getCuentaFondoCaucion() == null ) ? String.class : obj.getCuentaFondoCaucion();
		Object cuentaFondoDiferidos = ( obj.getCuentaFondoDiferidos() == null ) ? String.class : obj.getCuentaFondoDiferidos();
		Object formato = ( obj.getFormato() == null ) ? String.class : obj.getFormato();
		Object cuentaFondoBancoCopia = ( obj.getCuentaFondoBancoCopia() != null && obj.getCuentaFondoBancoCopia().getId() != null) ? obj.getCuentaFondoBancoCopia().getId() : String.class;
		Object limiteOperacionIndividual = ( obj.getLimiteOperacionIndividual() == null ) ? java.math.BigDecimal.class : obj.getLimiteOperacionIndividual();
		Object seguridadPuertaUso = ( obj.getSeguridadPuertaUso() != null && obj.getSeguridadPuertaUso().getId() != null) ? obj.getSeguridadPuertaUso().getId() : String.class;
		Object seguridadPuertaConsulta = ( obj.getSeguridadPuertaConsulta() != null && obj.getSeguridadPuertaConsulta().getId() != null) ? obj.getSeguridadPuertaConsulta().getId() : String.class;
		Object seguridadPuertaLimite = ( obj.getSeguridadPuertaLimite() != null && obj.getSeguridadPuertaLimite().getId() != null) ? obj.getSeguridadPuertaLimite().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_CuentaFondo(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, cuentaContable, cuentaFondoGrupo, cuentaFondoTipo, obsoleto, noImprimeCaja, ventas, fondos, compras, moneda, caja, rechazados, conciliacion, cuentaFondoTipoBanco, banco, cuentaBancaria, cbu, limiteDescubierto, cuentaFondoCaucion, cuentaFondoDiferidos, formato, cuentaFondoBancoCopia, limiteOperacionIndividual, seguridadPuertaUso, seguridadPuertaConsulta, seguridadPuertaLimite};

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


	public String update(CuentaFondo obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto CuentaFondo no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto CuentaFondo con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object cuentaContable = ( obj.getCuentaContable() != null && obj.getCuentaContable().getId() != null) ? obj.getCuentaContable().getId() : String.class;
		Object cuentaFondoGrupo = ( obj.getCuentaFondoGrupo() != null && obj.getCuentaFondoGrupo().getId() != null) ? obj.getCuentaFondoGrupo().getId() : String.class;
		Object cuentaFondoTipo = ( obj.getCuentaFondoTipo() != null && obj.getCuentaFondoTipo().getId() != null) ? obj.getCuentaFondoTipo().getId() : String.class;
		Object obsoleto = ( obj.getObsoleto() == null ) ? Boolean.class : obj.getObsoleto();
		Object noImprimeCaja = ( obj.getNoImprimeCaja() == null ) ? Boolean.class : obj.getNoImprimeCaja();
		Object ventas = ( obj.getVentas() == null ) ? Boolean.class : obj.getVentas();
		Object fondos = ( obj.getFondos() == null ) ? Boolean.class : obj.getFondos();
		Object compras = ( obj.getCompras() == null ) ? Boolean.class : obj.getCompras();
		Object moneda = ( obj.getMoneda() != null && obj.getMoneda().getId() != null) ? obj.getMoneda().getId() : String.class;
		Object caja = ( obj.getCaja() != null && obj.getCaja().getId() != null) ? obj.getCaja().getId() : String.class;
		Object rechazados = ( obj.getRechazados() == null ) ? Boolean.class : obj.getRechazados();
		Object conciliacion = ( obj.getConciliacion() == null ) ? Boolean.class : obj.getConciliacion();
		Object cuentaFondoTipoBanco = ( obj.getCuentaFondoTipoBanco() != null && obj.getCuentaFondoTipoBanco().getId() != null) ? obj.getCuentaFondoTipoBanco().getId() : String.class;
		Object banco = ( obj.getBanco() != null && obj.getBanco().getId() != null) ? obj.getBanco().getId() : String.class;
		Object cuentaBancaria = ( obj.getCuentaBancaria() == null ) ? String.class : obj.getCuentaBancaria();
		Object cbu = ( obj.getCbu() == null ) ? String.class : obj.getCbu();
		Object limiteDescubierto = ( obj.getLimiteDescubierto() == null ) ? java.math.BigDecimal.class : obj.getLimiteDescubierto();
		Object cuentaFondoCaucion = ( obj.getCuentaFondoCaucion() == null ) ? String.class : obj.getCuentaFondoCaucion();
		Object cuentaFondoDiferidos = ( obj.getCuentaFondoDiferidos() == null ) ? String.class : obj.getCuentaFondoDiferidos();
		Object formato = ( obj.getFormato() == null ) ? String.class : obj.getFormato();
		Object cuentaFondoBancoCopia = ( obj.getCuentaFondoBancoCopia() != null && obj.getCuentaFondoBancoCopia().getId() != null) ? obj.getCuentaFondoBancoCopia().getId() : String.class;
		Object limiteOperacionIndividual = ( obj.getLimiteOperacionIndividual() == null ) ? java.math.BigDecimal.class : obj.getLimiteOperacionIndividual();
		Object seguridadPuertaUso = ( obj.getSeguridadPuertaUso() != null && obj.getSeguridadPuertaUso().getId() != null) ? obj.getSeguridadPuertaUso().getId() : String.class;
		Object seguridadPuertaConsulta = ( obj.getSeguridadPuertaConsulta() != null && obj.getSeguridadPuertaConsulta().getId() != null) ? obj.getSeguridadPuertaConsulta().getId() : String.class;
		Object seguridadPuertaLimite = ( obj.getSeguridadPuertaLimite() != null && obj.getSeguridadPuertaLimite().getId() != null) ? obj.getSeguridadPuertaLimite().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_CuentaFondo(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, cuentaContable, cuentaFondoGrupo, cuentaFondoTipo, obsoleto, noImprimeCaja, ventas, fondos, compras, moneda, caja, rechazados, conciliacion, cuentaFondoTipoBanco, banco, cuentaBancaria, cbu, limiteDescubierto, cuentaFondoCaucion, cuentaFondoDiferidos, formato, cuentaFondoBancoCopia, limiteOperacionIndividual, seguridadPuertaUso, seguridadPuertaConsulta, seguridadPuertaLimite};

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
			throw new IllegalArgumentException("Se esperaba un id (CuentaFondo.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_CuentaFondoById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (CuentaFondo.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_CuentaFondo_numero(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (CuentaFondo.nombre) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_CuentaFondo_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_CuentaFondo_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public java.math.BigDecimal nextValueLimiteDescubierto() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_CuentaFondo_limiteDescubierto()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public java.math.BigDecimal nextValueLimiteOperacionIndividual() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_CuentaFondo_limiteOperacionIndividual()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.CuentaFondo;";

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


	public List<CuentaFondo> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (CuentaFondo.numero o CuentaFondo.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº cuenta

		if(UtilNumeric.isInteger(arg)) {

			CuentaFondoFiltro filtroNumero = new CuentaFondoFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<CuentaFondo> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		CuentaFondoFiltro filtroNombre = new CuentaFondoFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<CuentaFondo> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<CuentaFondo>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public CuentaFondo findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public CuentaFondo findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (CuentaFondo.id) no nulo/vacio.");
		}

		id = id.trim();

		CuentaFondo obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_CuentaFondoById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 28) {

				obj = mapper28Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 87) {

				obj = mapper87Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 123) {

				obj = mapper123Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 141) {

				obj = mapper141Fields(row);

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


	public List<CuentaFondo> find(CuentaFondoFiltro filtro) throws Exception {

		List<CuentaFondo> listado = new ArrayList<CuentaFondo>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_CuentaFondo" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();
		Object banco = ( filtro.getBanco() != null && filtro.getBanco().getId() != null) ? filtro.getBanco().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre, banco};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre, banco};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 28) {

				CuentaFondo obj = mapper28Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 87) {

				CuentaFondo obj = mapper87Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 123) {

				CuentaFondo obj = mapper123Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 141) {

				CuentaFondo obj = mapper141Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CuentaFondo mapper28Fields(Object[] row) throws Exception {

		int c = -1;

		String idCuentaFondoArg0 = (String) row[++c];
		Integer numeroCuentaFondoArg1 = (Integer) row[++c];
		String nombreCuentaFondoArg2 = (String) row[++c];
		String cuentaContableCuentaFondoArg3 = (String) row[++c]; // CuentaContable.id
		String cuentaFondoGrupoCuentaFondoArg4 = (String) row[++c]; // CuentaFondoGrupo.id
		String cuentaFondoTipoCuentaFondoArg5 = (String) row[++c]; // CuentaFondoTipo.id
		Boolean obsoletoCuentaFondoArg6 = (Boolean) row[++c];
		Boolean noImprimeCajaCuentaFondoArg7 = (Boolean) row[++c];
		Boolean ventasCuentaFondoArg8 = (Boolean) row[++c];
		Boolean fondosCuentaFondoArg9 = (Boolean) row[++c];
		Boolean comprasCuentaFondoArg10 = (Boolean) row[++c];
		String monedaCuentaFondoArg11 = (String) row[++c]; // Moneda.id
		String cajaCuentaFondoArg12 = (String) row[++c]; // Caja.id
		Boolean rechazadosCuentaFondoArg13 = (Boolean) row[++c];
		Boolean conciliacionCuentaFondoArg14 = (Boolean) row[++c];
		String cuentaFondoTipoBancoCuentaFondoArg15 = (String) row[++c]; // CuentaFondoTipoBanco.id
		String bancoCuentaFondoArg16 = (String) row[++c]; // Banco.id
		String cuentaBancariaCuentaFondoArg17 = (String) row[++c];
		String cbuCuentaFondoArg18 = (String) row[++c];
		java.math.BigDecimal limiteDescubiertoCuentaFondoArg19 = (java.math.BigDecimal) row[++c];
		String cuentaFondoCaucionCuentaFondoArg20 = (String) row[++c];
		String cuentaFondoDiferidosCuentaFondoArg21 = (String) row[++c];
		String formatoCuentaFondoArg22 = (String) row[++c];
		String cuentaFondoBancoCopiaCuentaFondoArg23 = (String) row[++c]; // CuentaFondoBancoCopia.id
		java.math.BigDecimal limiteOperacionIndividualCuentaFondoArg24 = (java.math.BigDecimal) row[++c];
		String seguridadPuertaUsoCuentaFondoArg25 = (String) row[++c]; // SeguridadPuerta.id
		String seguridadPuertaConsultaCuentaFondoArg26 = (String) row[++c]; // SeguridadPuerta.id
		String seguridadPuertaLimiteCuentaFondoArg27 = (String) row[++c]; // SeguridadPuerta.id

		CuentaFondo obj = new CuentaFondo(idCuentaFondoArg0, numeroCuentaFondoArg1, nombreCuentaFondoArg2, cuentaContableCuentaFondoArg3, cuentaFondoGrupoCuentaFondoArg4, cuentaFondoTipoCuentaFondoArg5, obsoletoCuentaFondoArg6, noImprimeCajaCuentaFondoArg7, ventasCuentaFondoArg8, fondosCuentaFondoArg9, comprasCuentaFondoArg10, monedaCuentaFondoArg11, cajaCuentaFondoArg12, rechazadosCuentaFondoArg13, conciliacionCuentaFondoArg14, cuentaFondoTipoBancoCuentaFondoArg15, bancoCuentaFondoArg16, cuentaBancariaCuentaFondoArg17, cbuCuentaFondoArg18, limiteDescubiertoCuentaFondoArg19, cuentaFondoCaucionCuentaFondoArg20, cuentaFondoDiferidosCuentaFondoArg21, formatoCuentaFondoArg22, cuentaFondoBancoCopiaCuentaFondoArg23, limiteOperacionIndividualCuentaFondoArg24, seguridadPuertaUsoCuentaFondoArg25, seguridadPuertaConsultaCuentaFondoArg26, seguridadPuertaLimiteCuentaFondoArg27);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CuentaFondo mapper87Fields(Object[] row) throws Exception {

		int c = -1;

		String idCuentaFondoArg0 = (String) row[++c];
		Integer numeroCuentaFondoArg1 = (Integer) row[++c];
		String nombreCuentaFondoArg2 = (String) row[++c];
		String idCuentaContableArg3 = (String) row[++c];
		String codigoCuentaContableArg4 = (String) row[++c];
		String nombreCuentaContableArg5 = (String) row[++c];
		String ejercicioContableCuentaContableArg6 = (String) row[++c]; // EjercicioContable.id
		String integraCuentaContableArg7 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg8 = (String) row[++c];
		Boolean imputableCuentaContableArg9 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg10 = (Boolean) row[++c];
		String cuentaContableEstadoCuentaContableArg11 = (String) row[++c]; // CuentaContableEstado.id
		Boolean cuentaConApropiacionCuentaContableArg12 = (Boolean) row[++c];
		String centroCostoContableCuentaContableArg13 = (String) row[++c]; // CentroCostoContable.id
		String cuentaAgrupadoraCuentaContableArg14 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg15 = (java.math.BigDecimal) row[++c];
		String puntoEquilibrioCuentaContableArg16 = (String) row[++c]; // PuntoEquilibrio.id
		String costoVentaCuentaContableArg17 = (String) row[++c]; // CostoVenta.id
		String seguridadPuertaCuentaContableArg18 = (String) row[++c]; // SeguridadPuerta.id
		String idCuentaFondoGrupoArg19 = (String) row[++c];
		Integer numeroCuentaFondoGrupoArg20 = (Integer) row[++c];
		String nombreCuentaFondoGrupoArg21 = (String) row[++c];
		String cuentaFondoRubroCuentaFondoGrupoArg22 = (String) row[++c]; // CuentaFondoRubro.id
		String idCuentaFondoTipoArg23 = (String) row[++c];
		Integer numeroCuentaFondoTipoArg24 = (Integer) row[++c];
		String nombreCuentaFondoTipoArg25 = (String) row[++c];
		Boolean obsoletoCuentaFondoArg26 = (Boolean) row[++c];
		Boolean noImprimeCajaCuentaFondoArg27 = (Boolean) row[++c];
		Boolean ventasCuentaFondoArg28 = (Boolean) row[++c];
		Boolean fondosCuentaFondoArg29 = (Boolean) row[++c];
		Boolean comprasCuentaFondoArg30 = (Boolean) row[++c];
		String idMonedaArg31 = (String) row[++c];
		Integer numeroMonedaArg32 = (Integer) row[++c];
		String nombreMonedaArg33 = (String) row[++c];
		String abreviaturaMonedaArg34 = (String) row[++c];
		java.math.BigDecimal cotizacionMonedaArg35 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaArg36 = (java.sql.Timestamp) row[++c];
		Boolean controlActualizacionMonedaArg37 = (Boolean) row[++c];
		String monedaAFIPMonedaArg38 = (String) row[++c]; // MonedaAFIP.id
		String idCajaArg39 = (String) row[++c];
		Integer numeroCajaArg40 = (Integer) row[++c];
		String nombreCajaArg41 = (String) row[++c];
		String seguridadPuertaCajaArg42 = (String) row[++c]; // SeguridadPuerta.id
		Boolean rechazadosCuentaFondoArg43 = (Boolean) row[++c];
		Boolean conciliacionCuentaFondoArg44 = (Boolean) row[++c];
		String idCuentaFondoTipoBancoArg45 = (String) row[++c];
		Integer numeroCuentaFondoTipoBancoArg46 = (Integer) row[++c];
		String nombreCuentaFondoTipoBancoArg47 = (String) row[++c];
		String idBancoArg48 = (String) row[++c];
		Integer numeroBancoArg49 = (Integer) row[++c];
		String nombreBancoArg50 = (String) row[++c];
		Long cuitBancoArg51 = (Long) row[++c];
		Boolean bloqueadoBancoArg52 = (Boolean) row[++c];
		Integer hojaBancoArg53 = (Integer) row[++c];
		Integer primeraFilaBancoArg54 = (Integer) row[++c];
		Integer ultimaFilaBancoArg55 = (Integer) row[++c];
		String fechaBancoArg56 = (String) row[++c];
		String descripcionBancoArg57 = (String) row[++c];
		String referencia1BancoArg58 = (String) row[++c];
		String importeBancoArg59 = (String) row[++c];
		String referencia2BancoArg60 = (String) row[++c];
		String saldoBancoArg61 = (String) row[++c];
		String cuentaBancariaCuentaFondoArg62 = (String) row[++c];
		String cbuCuentaFondoArg63 = (String) row[++c];
		java.math.BigDecimal limiteDescubiertoCuentaFondoArg64 = (java.math.BigDecimal) row[++c];
		String cuentaFondoCaucionCuentaFondoArg65 = (String) row[++c];
		String cuentaFondoDiferidosCuentaFondoArg66 = (String) row[++c];
		String formatoCuentaFondoArg67 = (String) row[++c];
		String idCuentaFondoBancoCopiaArg68 = (String) row[++c];
		Integer numeroCuentaFondoBancoCopiaArg69 = (Integer) row[++c];
		String nombreCuentaFondoBancoCopiaArg70 = (String) row[++c];
		java.math.BigDecimal limiteOperacionIndividualCuentaFondoArg71 = (java.math.BigDecimal) row[++c];
		String idSeguridadPuertaArg72 = (String) row[++c];
		Integer numeroSeguridadPuertaArg73 = (Integer) row[++c];
		String nombreSeguridadPuertaArg74 = (String) row[++c];
		String equateSeguridadPuertaArg75 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg76 = (String) row[++c]; // SeguridadModulo.id
		String idSeguridadPuertaArg77 = (String) row[++c];
		Integer numeroSeguridadPuertaArg78 = (Integer) row[++c];
		String nombreSeguridadPuertaArg79 = (String) row[++c];
		String equateSeguridadPuertaArg80 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg81 = (String) row[++c]; // SeguridadModulo.id
		String idSeguridadPuertaArg82 = (String) row[++c];
		Integer numeroSeguridadPuertaArg83 = (Integer) row[++c];
		String nombreSeguridadPuertaArg84 = (String) row[++c];
		String equateSeguridadPuertaArg85 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg86 = (String) row[++c]; // SeguridadModulo.id

		CuentaFondo obj = new CuentaFondo(idCuentaFondoArg0, numeroCuentaFondoArg1, nombreCuentaFondoArg2, idCuentaContableArg3, codigoCuentaContableArg4, nombreCuentaContableArg5, ejercicioContableCuentaContableArg6, integraCuentaContableArg7, cuentaJerarquiaCuentaContableArg8, imputableCuentaContableArg9, ajustaPorInflacionCuentaContableArg10, cuentaContableEstadoCuentaContableArg11, cuentaConApropiacionCuentaContableArg12, centroCostoContableCuentaContableArg13, cuentaAgrupadoraCuentaContableArg14, porcentajeCuentaContableArg15, puntoEquilibrioCuentaContableArg16, costoVentaCuentaContableArg17, seguridadPuertaCuentaContableArg18, idCuentaFondoGrupoArg19, numeroCuentaFondoGrupoArg20, nombreCuentaFondoGrupoArg21, cuentaFondoRubroCuentaFondoGrupoArg22, idCuentaFondoTipoArg23, numeroCuentaFondoTipoArg24, nombreCuentaFondoTipoArg25, obsoletoCuentaFondoArg26, noImprimeCajaCuentaFondoArg27, ventasCuentaFondoArg28, fondosCuentaFondoArg29, comprasCuentaFondoArg30, idMonedaArg31, numeroMonedaArg32, nombreMonedaArg33, abreviaturaMonedaArg34, cotizacionMonedaArg35, cotizacionFechaMonedaArg36, controlActualizacionMonedaArg37, monedaAFIPMonedaArg38, idCajaArg39, numeroCajaArg40, nombreCajaArg41, seguridadPuertaCajaArg42, rechazadosCuentaFondoArg43, conciliacionCuentaFondoArg44, idCuentaFondoTipoBancoArg45, numeroCuentaFondoTipoBancoArg46, nombreCuentaFondoTipoBancoArg47, idBancoArg48, numeroBancoArg49, nombreBancoArg50, cuitBancoArg51, bloqueadoBancoArg52, hojaBancoArg53, primeraFilaBancoArg54, ultimaFilaBancoArg55, fechaBancoArg56, descripcionBancoArg57, referencia1BancoArg58, importeBancoArg59, referencia2BancoArg60, saldoBancoArg61, cuentaBancariaCuentaFondoArg62, cbuCuentaFondoArg63, limiteDescubiertoCuentaFondoArg64, cuentaFondoCaucionCuentaFondoArg65, cuentaFondoDiferidosCuentaFondoArg66, formatoCuentaFondoArg67, idCuentaFondoBancoCopiaArg68, numeroCuentaFondoBancoCopiaArg69, nombreCuentaFondoBancoCopiaArg70, limiteOperacionIndividualCuentaFondoArg71, idSeguridadPuertaArg72, numeroSeguridadPuertaArg73, nombreSeguridadPuertaArg74, equateSeguridadPuertaArg75, seguridadModuloSeguridadPuertaArg76, idSeguridadPuertaArg77, numeroSeguridadPuertaArg78, nombreSeguridadPuertaArg79, equateSeguridadPuertaArg80, seguridadModuloSeguridadPuertaArg81, idSeguridadPuertaArg82, numeroSeguridadPuertaArg83, nombreSeguridadPuertaArg84, equateSeguridadPuertaArg85, seguridadModuloSeguridadPuertaArg86);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CuentaFondo mapper123Fields(Object[] row) throws Exception {

		int c = -1;

		String idCuentaFondoArg0 = (String) row[++c];
		Integer numeroCuentaFondoArg1 = (Integer) row[++c];
		String nombreCuentaFondoArg2 = (String) row[++c];
		String idCuentaContableArg3 = (String) row[++c];
		String codigoCuentaContableArg4 = (String) row[++c];
		String nombreCuentaContableArg5 = (String) row[++c];
		String idEjercicioContableArg6 = (String) row[++c];
		Integer numeroEjercicioContableArg7 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg8 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg9 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg10 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg11 = (Boolean) row[++c];
		String comentarioEjercicioContableArg12 = (String) row[++c];
		String integraCuentaContableArg13 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg14 = (String) row[++c];
		Boolean imputableCuentaContableArg15 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg16 = (Boolean) row[++c];
		String idCuentaContableEstadoArg17 = (String) row[++c];
		Integer numeroCuentaContableEstadoArg18 = (Integer) row[++c];
		String nombreCuentaContableEstadoArg19 = (String) row[++c];
		Boolean cuentaConApropiacionCuentaContableArg20 = (Boolean) row[++c];
		String idCentroCostoContableArg21 = (String) row[++c];
		Integer numeroCentroCostoContableArg22 = (Integer) row[++c];
		String nombreCentroCostoContableArg23 = (String) row[++c];
		String abreviaturaCentroCostoContableArg24 = (String) row[++c];
		String ejercicioContableCentroCostoContableArg25 = (String) row[++c]; // EjercicioContable.id
		String cuentaAgrupadoraCuentaContableArg26 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg27 = (java.math.BigDecimal) row[++c];
		String idPuntoEquilibrioArg28 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg29 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg30 = (String) row[++c];
		String tipoPuntoEquilibrioPuntoEquilibrioArg31 = (String) row[++c]; // TipoPuntoEquilibrio.id
		String ejercicioContablePuntoEquilibrioArg32 = (String) row[++c]; // EjercicioContable.id
		String idCostoVentaArg33 = (String) row[++c];
		Integer numeroCostoVentaArg34 = (Integer) row[++c];
		String nombreCostoVentaArg35 = (String) row[++c];
		String idSeguridadPuertaArg36 = (String) row[++c];
		Integer numeroSeguridadPuertaArg37 = (Integer) row[++c];
		String nombreSeguridadPuertaArg38 = (String) row[++c];
		String equateSeguridadPuertaArg39 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg40 = (String) row[++c]; // SeguridadModulo.id
		String idCuentaFondoGrupoArg41 = (String) row[++c];
		Integer numeroCuentaFondoGrupoArg42 = (Integer) row[++c];
		String nombreCuentaFondoGrupoArg43 = (String) row[++c];
		String idCuentaFondoRubroArg44 = (String) row[++c];
		Integer numeroCuentaFondoRubroArg45 = (Integer) row[++c];
		String nombreCuentaFondoRubroArg46 = (String) row[++c];
		String idCuentaFondoTipoArg47 = (String) row[++c];
		Integer numeroCuentaFondoTipoArg48 = (Integer) row[++c];
		String nombreCuentaFondoTipoArg49 = (String) row[++c];
		Boolean obsoletoCuentaFondoArg50 = (Boolean) row[++c];
		Boolean noImprimeCajaCuentaFondoArg51 = (Boolean) row[++c];
		Boolean ventasCuentaFondoArg52 = (Boolean) row[++c];
		Boolean fondosCuentaFondoArg53 = (Boolean) row[++c];
		Boolean comprasCuentaFondoArg54 = (Boolean) row[++c];
		String idMonedaArg55 = (String) row[++c];
		Integer numeroMonedaArg56 = (Integer) row[++c];
		String nombreMonedaArg57 = (String) row[++c];
		String abreviaturaMonedaArg58 = (String) row[++c];
		java.math.BigDecimal cotizacionMonedaArg59 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaArg60 = (java.sql.Timestamp) row[++c];
		Boolean controlActualizacionMonedaArg61 = (Boolean) row[++c];
		String idMonedaAFIPArg62 = (String) row[++c];
		String codigoMonedaAFIPArg63 = (String) row[++c];
		String nombreMonedaAFIPArg64 = (String) row[++c];
		String idCajaArg65 = (String) row[++c];
		Integer numeroCajaArg66 = (Integer) row[++c];
		String nombreCajaArg67 = (String) row[++c];
		String idSeguridadPuertaArg68 = (String) row[++c];
		Integer numeroSeguridadPuertaArg69 = (Integer) row[++c];
		String nombreSeguridadPuertaArg70 = (String) row[++c];
		String equateSeguridadPuertaArg71 = (String) row[++c];
		String seguridadModuloSeguridadPuertaArg72 = (String) row[++c]; // SeguridadModulo.id
		Boolean rechazadosCuentaFondoArg73 = (Boolean) row[++c];
		Boolean conciliacionCuentaFondoArg74 = (Boolean) row[++c];
		String idCuentaFondoTipoBancoArg75 = (String) row[++c];
		Integer numeroCuentaFondoTipoBancoArg76 = (Integer) row[++c];
		String nombreCuentaFondoTipoBancoArg77 = (String) row[++c];
		String idBancoArg78 = (String) row[++c];
		Integer numeroBancoArg79 = (Integer) row[++c];
		String nombreBancoArg80 = (String) row[++c];
		Long cuitBancoArg81 = (Long) row[++c];
		Boolean bloqueadoBancoArg82 = (Boolean) row[++c];
		Integer hojaBancoArg83 = (Integer) row[++c];
		Integer primeraFilaBancoArg84 = (Integer) row[++c];
		Integer ultimaFilaBancoArg85 = (Integer) row[++c];
		String fechaBancoArg86 = (String) row[++c];
		String descripcionBancoArg87 = (String) row[++c];
		String referencia1BancoArg88 = (String) row[++c];
		String importeBancoArg89 = (String) row[++c];
		String referencia2BancoArg90 = (String) row[++c];
		String saldoBancoArg91 = (String) row[++c];
		String cuentaBancariaCuentaFondoArg92 = (String) row[++c];
		String cbuCuentaFondoArg93 = (String) row[++c];
		java.math.BigDecimal limiteDescubiertoCuentaFondoArg94 = (java.math.BigDecimal) row[++c];
		String cuentaFondoCaucionCuentaFondoArg95 = (String) row[++c];
		String cuentaFondoDiferidosCuentaFondoArg96 = (String) row[++c];
		String formatoCuentaFondoArg97 = (String) row[++c];
		String idCuentaFondoBancoCopiaArg98 = (String) row[++c];
		Integer numeroCuentaFondoBancoCopiaArg99 = (Integer) row[++c];
		String nombreCuentaFondoBancoCopiaArg100 = (String) row[++c];
		java.math.BigDecimal limiteOperacionIndividualCuentaFondoArg101 = (java.math.BigDecimal) row[++c];
		String idSeguridadPuertaArg102 = (String) row[++c];
		Integer numeroSeguridadPuertaArg103 = (Integer) row[++c];
		String nombreSeguridadPuertaArg104 = (String) row[++c];
		String equateSeguridadPuertaArg105 = (String) row[++c];
		String idSeguridadModuloArg106 = (String) row[++c];
		Integer numeroSeguridadModuloArg107 = (Integer) row[++c];
		String nombreSeguridadModuloArg108 = (String) row[++c];
		String idSeguridadPuertaArg109 = (String) row[++c];
		Integer numeroSeguridadPuertaArg110 = (Integer) row[++c];
		String nombreSeguridadPuertaArg111 = (String) row[++c];
		String equateSeguridadPuertaArg112 = (String) row[++c];
		String idSeguridadModuloArg113 = (String) row[++c];
		Integer numeroSeguridadModuloArg114 = (Integer) row[++c];
		String nombreSeguridadModuloArg115 = (String) row[++c];
		String idSeguridadPuertaArg116 = (String) row[++c];
		Integer numeroSeguridadPuertaArg117 = (Integer) row[++c];
		String nombreSeguridadPuertaArg118 = (String) row[++c];
		String equateSeguridadPuertaArg119 = (String) row[++c];
		String idSeguridadModuloArg120 = (String) row[++c];
		Integer numeroSeguridadModuloArg121 = (Integer) row[++c];
		String nombreSeguridadModuloArg122 = (String) row[++c];

		CuentaFondo obj = new CuentaFondo(idCuentaFondoArg0, numeroCuentaFondoArg1, nombreCuentaFondoArg2, idCuentaContableArg3, codigoCuentaContableArg4, nombreCuentaContableArg5, idEjercicioContableArg6, numeroEjercicioContableArg7, aperturaEjercicioContableArg8, cierreEjercicioContableArg9, cerradoEjercicioContableArg10, cerradoModulosEjercicioContableArg11, comentarioEjercicioContableArg12, integraCuentaContableArg13, cuentaJerarquiaCuentaContableArg14, imputableCuentaContableArg15, ajustaPorInflacionCuentaContableArg16, idCuentaContableEstadoArg17, numeroCuentaContableEstadoArg18, nombreCuentaContableEstadoArg19, cuentaConApropiacionCuentaContableArg20, idCentroCostoContableArg21, numeroCentroCostoContableArg22, nombreCentroCostoContableArg23, abreviaturaCentroCostoContableArg24, ejercicioContableCentroCostoContableArg25, cuentaAgrupadoraCuentaContableArg26, porcentajeCuentaContableArg27, idPuntoEquilibrioArg28, numeroPuntoEquilibrioArg29, nombrePuntoEquilibrioArg30, tipoPuntoEquilibrioPuntoEquilibrioArg31, ejercicioContablePuntoEquilibrioArg32, idCostoVentaArg33, numeroCostoVentaArg34, nombreCostoVentaArg35, idSeguridadPuertaArg36, numeroSeguridadPuertaArg37, nombreSeguridadPuertaArg38, equateSeguridadPuertaArg39, seguridadModuloSeguridadPuertaArg40, idCuentaFondoGrupoArg41, numeroCuentaFondoGrupoArg42, nombreCuentaFondoGrupoArg43, idCuentaFondoRubroArg44, numeroCuentaFondoRubroArg45, nombreCuentaFondoRubroArg46, idCuentaFondoTipoArg47, numeroCuentaFondoTipoArg48, nombreCuentaFondoTipoArg49, obsoletoCuentaFondoArg50, noImprimeCajaCuentaFondoArg51, ventasCuentaFondoArg52, fondosCuentaFondoArg53, comprasCuentaFondoArg54, idMonedaArg55, numeroMonedaArg56, nombreMonedaArg57, abreviaturaMonedaArg58, cotizacionMonedaArg59, cotizacionFechaMonedaArg60, controlActualizacionMonedaArg61, idMonedaAFIPArg62, codigoMonedaAFIPArg63, nombreMonedaAFIPArg64, idCajaArg65, numeroCajaArg66, nombreCajaArg67, idSeguridadPuertaArg68, numeroSeguridadPuertaArg69, nombreSeguridadPuertaArg70, equateSeguridadPuertaArg71, seguridadModuloSeguridadPuertaArg72, rechazadosCuentaFondoArg73, conciliacionCuentaFondoArg74, idCuentaFondoTipoBancoArg75, numeroCuentaFondoTipoBancoArg76, nombreCuentaFondoTipoBancoArg77, idBancoArg78, numeroBancoArg79, nombreBancoArg80, cuitBancoArg81, bloqueadoBancoArg82, hojaBancoArg83, primeraFilaBancoArg84, ultimaFilaBancoArg85, fechaBancoArg86, descripcionBancoArg87, referencia1BancoArg88, importeBancoArg89, referencia2BancoArg90, saldoBancoArg91, cuentaBancariaCuentaFondoArg92, cbuCuentaFondoArg93, limiteDescubiertoCuentaFondoArg94, cuentaFondoCaucionCuentaFondoArg95, cuentaFondoDiferidosCuentaFondoArg96, formatoCuentaFondoArg97, idCuentaFondoBancoCopiaArg98, numeroCuentaFondoBancoCopiaArg99, nombreCuentaFondoBancoCopiaArg100, limiteOperacionIndividualCuentaFondoArg101, idSeguridadPuertaArg102, numeroSeguridadPuertaArg103, nombreSeguridadPuertaArg104, equateSeguridadPuertaArg105, idSeguridadModuloArg106, numeroSeguridadModuloArg107, nombreSeguridadModuloArg108, idSeguridadPuertaArg109, numeroSeguridadPuertaArg110, nombreSeguridadPuertaArg111, equateSeguridadPuertaArg112, idSeguridadModuloArg113, numeroSeguridadModuloArg114, nombreSeguridadModuloArg115, idSeguridadPuertaArg116, numeroSeguridadPuertaArg117, nombreSeguridadPuertaArg118, equateSeguridadPuertaArg119, idSeguridadModuloArg120, numeroSeguridadModuloArg121, nombreSeguridadModuloArg122);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private CuentaFondo mapper141Fields(Object[] row) throws Exception {

		int c = -1;

		String idCuentaFondoArg0 = (String) row[++c];
		Integer numeroCuentaFondoArg1 = (Integer) row[++c];
		String nombreCuentaFondoArg2 = (String) row[++c];
		String idCuentaContableArg3 = (String) row[++c];
		String codigoCuentaContableArg4 = (String) row[++c];
		String nombreCuentaContableArg5 = (String) row[++c];
		String idEjercicioContableArg6 = (String) row[++c];
		Integer numeroEjercicioContableArg7 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg8 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg9 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg10 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg11 = (Boolean) row[++c];
		String comentarioEjercicioContableArg12 = (String) row[++c];
		String integraCuentaContableArg13 = (String) row[++c];
		String cuentaJerarquiaCuentaContableArg14 = (String) row[++c];
		Boolean imputableCuentaContableArg15 = (Boolean) row[++c];
		Boolean ajustaPorInflacionCuentaContableArg16 = (Boolean) row[++c];
		String idCuentaContableEstadoArg17 = (String) row[++c];
		Integer numeroCuentaContableEstadoArg18 = (Integer) row[++c];
		String nombreCuentaContableEstadoArg19 = (String) row[++c];
		Boolean cuentaConApropiacionCuentaContableArg20 = (Boolean) row[++c];
		String idCentroCostoContableArg21 = (String) row[++c];
		Integer numeroCentroCostoContableArg22 = (Integer) row[++c];
		String nombreCentroCostoContableArg23 = (String) row[++c];
		String abreviaturaCentroCostoContableArg24 = (String) row[++c];
		String idEjercicioContableArg25 = (String) row[++c];
		Integer numeroEjercicioContableArg26 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg27 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg28 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg29 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg30 = (Boolean) row[++c];
		String comentarioEjercicioContableArg31 = (String) row[++c];
		String cuentaAgrupadoraCuentaContableArg32 = (String) row[++c];
		java.math.BigDecimal porcentajeCuentaContableArg33 = (java.math.BigDecimal) row[++c];
		String idPuntoEquilibrioArg34 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg35 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg36 = (String) row[++c];
		String idTipoPuntoEquilibrioArg37 = (String) row[++c];
		Integer numeroTipoPuntoEquilibrioArg38 = (Integer) row[++c];
		String nombreTipoPuntoEquilibrioArg39 = (String) row[++c];
		String idEjercicioContableArg40 = (String) row[++c];
		Integer numeroEjercicioContableArg41 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg42 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg43 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg44 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg45 = (Boolean) row[++c];
		String comentarioEjercicioContableArg46 = (String) row[++c];
		String idCostoVentaArg47 = (String) row[++c];
		Integer numeroCostoVentaArg48 = (Integer) row[++c];
		String nombreCostoVentaArg49 = (String) row[++c];
		String idSeguridadPuertaArg50 = (String) row[++c];
		Integer numeroSeguridadPuertaArg51 = (Integer) row[++c];
		String nombreSeguridadPuertaArg52 = (String) row[++c];
		String equateSeguridadPuertaArg53 = (String) row[++c];
		String idSeguridadModuloArg54 = (String) row[++c];
		Integer numeroSeguridadModuloArg55 = (Integer) row[++c];
		String nombreSeguridadModuloArg56 = (String) row[++c];
		String idCuentaFondoGrupoArg57 = (String) row[++c];
		Integer numeroCuentaFondoGrupoArg58 = (Integer) row[++c];
		String nombreCuentaFondoGrupoArg59 = (String) row[++c];
		String idCuentaFondoRubroArg60 = (String) row[++c];
		Integer numeroCuentaFondoRubroArg61 = (Integer) row[++c];
		String nombreCuentaFondoRubroArg62 = (String) row[++c];
		String idCuentaFondoTipoArg63 = (String) row[++c];
		Integer numeroCuentaFondoTipoArg64 = (Integer) row[++c];
		String nombreCuentaFondoTipoArg65 = (String) row[++c];
		Boolean obsoletoCuentaFondoArg66 = (Boolean) row[++c];
		Boolean noImprimeCajaCuentaFondoArg67 = (Boolean) row[++c];
		Boolean ventasCuentaFondoArg68 = (Boolean) row[++c];
		Boolean fondosCuentaFondoArg69 = (Boolean) row[++c];
		Boolean comprasCuentaFondoArg70 = (Boolean) row[++c];
		String idMonedaArg71 = (String) row[++c];
		Integer numeroMonedaArg72 = (Integer) row[++c];
		String nombreMonedaArg73 = (String) row[++c];
		String abreviaturaMonedaArg74 = (String) row[++c];
		java.math.BigDecimal cotizacionMonedaArg75 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaArg76 = (java.sql.Timestamp) row[++c];
		Boolean controlActualizacionMonedaArg77 = (Boolean) row[++c];
		String idMonedaAFIPArg78 = (String) row[++c];
		String codigoMonedaAFIPArg79 = (String) row[++c];
		String nombreMonedaAFIPArg80 = (String) row[++c];
		String idCajaArg81 = (String) row[++c];
		Integer numeroCajaArg82 = (Integer) row[++c];
		String nombreCajaArg83 = (String) row[++c];
		String idSeguridadPuertaArg84 = (String) row[++c];
		Integer numeroSeguridadPuertaArg85 = (Integer) row[++c];
		String nombreSeguridadPuertaArg86 = (String) row[++c];
		String equateSeguridadPuertaArg87 = (String) row[++c];
		String idSeguridadModuloArg88 = (String) row[++c];
		Integer numeroSeguridadModuloArg89 = (Integer) row[++c];
		String nombreSeguridadModuloArg90 = (String) row[++c];
		Boolean rechazadosCuentaFondoArg91 = (Boolean) row[++c];
		Boolean conciliacionCuentaFondoArg92 = (Boolean) row[++c];
		String idCuentaFondoTipoBancoArg93 = (String) row[++c];
		Integer numeroCuentaFondoTipoBancoArg94 = (Integer) row[++c];
		String nombreCuentaFondoTipoBancoArg95 = (String) row[++c];
		String idBancoArg96 = (String) row[++c];
		Integer numeroBancoArg97 = (Integer) row[++c];
		String nombreBancoArg98 = (String) row[++c];
		Long cuitBancoArg99 = (Long) row[++c];
		Boolean bloqueadoBancoArg100 = (Boolean) row[++c];
		Integer hojaBancoArg101 = (Integer) row[++c];
		Integer primeraFilaBancoArg102 = (Integer) row[++c];
		Integer ultimaFilaBancoArg103 = (Integer) row[++c];
		String fechaBancoArg104 = (String) row[++c];
		String descripcionBancoArg105 = (String) row[++c];
		String referencia1BancoArg106 = (String) row[++c];
		String importeBancoArg107 = (String) row[++c];
		String referencia2BancoArg108 = (String) row[++c];
		String saldoBancoArg109 = (String) row[++c];
		String cuentaBancariaCuentaFondoArg110 = (String) row[++c];
		String cbuCuentaFondoArg111 = (String) row[++c];
		java.math.BigDecimal limiteDescubiertoCuentaFondoArg112 = (java.math.BigDecimal) row[++c];
		String cuentaFondoCaucionCuentaFondoArg113 = (String) row[++c];
		String cuentaFondoDiferidosCuentaFondoArg114 = (String) row[++c];
		String formatoCuentaFondoArg115 = (String) row[++c];
		String idCuentaFondoBancoCopiaArg116 = (String) row[++c];
		Integer numeroCuentaFondoBancoCopiaArg117 = (Integer) row[++c];
		String nombreCuentaFondoBancoCopiaArg118 = (String) row[++c];
		java.math.BigDecimal limiteOperacionIndividualCuentaFondoArg119 = (java.math.BigDecimal) row[++c];
		String idSeguridadPuertaArg120 = (String) row[++c];
		Integer numeroSeguridadPuertaArg121 = (Integer) row[++c];
		String nombreSeguridadPuertaArg122 = (String) row[++c];
		String equateSeguridadPuertaArg123 = (String) row[++c];
		String idSeguridadModuloArg124 = (String) row[++c];
		Integer numeroSeguridadModuloArg125 = (Integer) row[++c];
		String nombreSeguridadModuloArg126 = (String) row[++c];
		String idSeguridadPuertaArg127 = (String) row[++c];
		Integer numeroSeguridadPuertaArg128 = (Integer) row[++c];
		String nombreSeguridadPuertaArg129 = (String) row[++c];
		String equateSeguridadPuertaArg130 = (String) row[++c];
		String idSeguridadModuloArg131 = (String) row[++c];
		Integer numeroSeguridadModuloArg132 = (Integer) row[++c];
		String nombreSeguridadModuloArg133 = (String) row[++c];
		String idSeguridadPuertaArg134 = (String) row[++c];
		Integer numeroSeguridadPuertaArg135 = (Integer) row[++c];
		String nombreSeguridadPuertaArg136 = (String) row[++c];
		String equateSeguridadPuertaArg137 = (String) row[++c];
		String idSeguridadModuloArg138 = (String) row[++c];
		Integer numeroSeguridadModuloArg139 = (Integer) row[++c];
		String nombreSeguridadModuloArg140 = (String) row[++c];

		CuentaFondo obj = new CuentaFondo(idCuentaFondoArg0, numeroCuentaFondoArg1, nombreCuentaFondoArg2, idCuentaContableArg3, codigoCuentaContableArg4, nombreCuentaContableArg5, idEjercicioContableArg6, numeroEjercicioContableArg7, aperturaEjercicioContableArg8, cierreEjercicioContableArg9, cerradoEjercicioContableArg10, cerradoModulosEjercicioContableArg11, comentarioEjercicioContableArg12, integraCuentaContableArg13, cuentaJerarquiaCuentaContableArg14, imputableCuentaContableArg15, ajustaPorInflacionCuentaContableArg16, idCuentaContableEstadoArg17, numeroCuentaContableEstadoArg18, nombreCuentaContableEstadoArg19, cuentaConApropiacionCuentaContableArg20, idCentroCostoContableArg21, numeroCentroCostoContableArg22, nombreCentroCostoContableArg23, abreviaturaCentroCostoContableArg24, idEjercicioContableArg25, numeroEjercicioContableArg26, aperturaEjercicioContableArg27, cierreEjercicioContableArg28, cerradoEjercicioContableArg29, cerradoModulosEjercicioContableArg30, comentarioEjercicioContableArg31, cuentaAgrupadoraCuentaContableArg32, porcentajeCuentaContableArg33, idPuntoEquilibrioArg34, numeroPuntoEquilibrioArg35, nombrePuntoEquilibrioArg36, idTipoPuntoEquilibrioArg37, numeroTipoPuntoEquilibrioArg38, nombreTipoPuntoEquilibrioArg39, idEjercicioContableArg40, numeroEjercicioContableArg41, aperturaEjercicioContableArg42, cierreEjercicioContableArg43, cerradoEjercicioContableArg44, cerradoModulosEjercicioContableArg45, comentarioEjercicioContableArg46, idCostoVentaArg47, numeroCostoVentaArg48, nombreCostoVentaArg49, idSeguridadPuertaArg50, numeroSeguridadPuertaArg51, nombreSeguridadPuertaArg52, equateSeguridadPuertaArg53, idSeguridadModuloArg54, numeroSeguridadModuloArg55, nombreSeguridadModuloArg56, idCuentaFondoGrupoArg57, numeroCuentaFondoGrupoArg58, nombreCuentaFondoGrupoArg59, idCuentaFondoRubroArg60, numeroCuentaFondoRubroArg61, nombreCuentaFondoRubroArg62, idCuentaFondoTipoArg63, numeroCuentaFondoTipoArg64, nombreCuentaFondoTipoArg65, obsoletoCuentaFondoArg66, noImprimeCajaCuentaFondoArg67, ventasCuentaFondoArg68, fondosCuentaFondoArg69, comprasCuentaFondoArg70, idMonedaArg71, numeroMonedaArg72, nombreMonedaArg73, abreviaturaMonedaArg74, cotizacionMonedaArg75, cotizacionFechaMonedaArg76, controlActualizacionMonedaArg77, idMonedaAFIPArg78, codigoMonedaAFIPArg79, nombreMonedaAFIPArg80, idCajaArg81, numeroCajaArg82, nombreCajaArg83, idSeguridadPuertaArg84, numeroSeguridadPuertaArg85, nombreSeguridadPuertaArg86, equateSeguridadPuertaArg87, idSeguridadModuloArg88, numeroSeguridadModuloArg89, nombreSeguridadModuloArg90, rechazadosCuentaFondoArg91, conciliacionCuentaFondoArg92, idCuentaFondoTipoBancoArg93, numeroCuentaFondoTipoBancoArg94, nombreCuentaFondoTipoBancoArg95, idBancoArg96, numeroBancoArg97, nombreBancoArg98, cuitBancoArg99, bloqueadoBancoArg100, hojaBancoArg101, primeraFilaBancoArg102, ultimaFilaBancoArg103, fechaBancoArg104, descripcionBancoArg105, referencia1BancoArg106, importeBancoArg107, referencia2BancoArg108, saldoBancoArg109, cuentaBancariaCuentaFondoArg110, cbuCuentaFondoArg111, limiteDescubiertoCuentaFondoArg112, cuentaFondoCaucionCuentaFondoArg113, cuentaFondoDiferidosCuentaFondoArg114, formatoCuentaFondoArg115, idCuentaFondoBancoCopiaArg116, numeroCuentaFondoBancoCopiaArg117, nombreCuentaFondoBancoCopiaArg118, limiteOperacionIndividualCuentaFondoArg119, idSeguridadPuertaArg120, numeroSeguridadPuertaArg121, nombreSeguridadPuertaArg122, equateSeguridadPuertaArg123, idSeguridadModuloArg124, numeroSeguridadModuloArg125, nombreSeguridadModuloArg126, idSeguridadPuertaArg127, numeroSeguridadPuertaArg128, nombreSeguridadPuertaArg129, equateSeguridadPuertaArg130, idSeguridadModuloArg131, numeroSeguridadModuloArg132, nombreSeguridadModuloArg133, idSeguridadPuertaArg134, numeroSeguridadPuertaArg135, nombreSeguridadPuertaArg136, equateSeguridadPuertaArg137, idSeguridadModuloArg138, numeroSeguridadModuloArg139, nombreSeguridadModuloArg140);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------