package com.massoftware.service.fondos;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.Talonario;
import com.massoftware.service.UtilNumeric;

public class TalonarioService {

	private int levelDefault = 1;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Talonario obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto Talonario no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object talonarioLetra = ( obj.getTalonarioLetra() != null && obj.getTalonarioLetra().getId() != null) ? obj.getTalonarioLetra().getId() : String.class;
		Object puntoVenta = ( obj.getPuntoVenta() == null ) ? Integer.class : obj.getPuntoVenta();
		Object autonumeracion = ( obj.getAutonumeracion() == null ) ? Boolean.class : obj.getAutonumeracion();
		Object numeracionPreImpresa = ( obj.getNumeracionPreImpresa() == null ) ? Boolean.class : obj.getNumeracionPreImpresa();
		Object asociadoRG10098 = ( obj.getAsociadoRG10098() == null ) ? Boolean.class : obj.getAsociadoRG10098();
		Object talonarioControladorFizcal = ( obj.getTalonarioControladorFizcal() != null && obj.getTalonarioControladorFizcal().getId() != null) ? obj.getTalonarioControladorFizcal().getId() : String.class;
		Object primerNumero = ( obj.getPrimerNumero() == null ) ? Integer.class : obj.getPrimerNumero();
		Object proximoNumero = ( obj.getProximoNumero() == null ) ? Integer.class : obj.getProximoNumero();
		Object ultimoNumero = ( obj.getUltimoNumero() == null ) ? Integer.class : obj.getUltimoNumero();
		Object cantidadMinimaComprobantes = ( obj.getCantidadMinimaComprobantes() == null ) ? Integer.class : obj.getCantidadMinimaComprobantes();
		Object fecha = ( obj.getFecha() == null ) ? java.util.Date.class : obj.getFecha();
		Object numeroCAI = ( obj.getNumeroCAI() == null ) ? Long.class : obj.getNumeroCAI();
		Object vencimiento = ( obj.getVencimiento() == null ) ? java.util.Date.class : obj.getVencimiento();
		Object diasAvisoVencimiento = ( obj.getDiasAvisoVencimiento() == null ) ? Integer.class : obj.getDiasAvisoVencimiento();

		String sql = "SELECT * FROM massoftware.i_Talonario(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, talonarioLetra, puntoVenta, autonumeracion, numeracionPreImpresa, asociadoRG10098, talonarioControladorFizcal, primerNumero, proximoNumero, ultimoNumero, cantidadMinimaComprobantes, fecha, numeroCAI, vencimiento, diasAvisoVencimiento};

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


	public String update(Talonario obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto Talonario no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto Talonario con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object talonarioLetra = ( obj.getTalonarioLetra() != null && obj.getTalonarioLetra().getId() != null) ? obj.getTalonarioLetra().getId() : String.class;
		Object puntoVenta = ( obj.getPuntoVenta() == null ) ? Integer.class : obj.getPuntoVenta();
		Object autonumeracion = ( obj.getAutonumeracion() == null ) ? Boolean.class : obj.getAutonumeracion();
		Object numeracionPreImpresa = ( obj.getNumeracionPreImpresa() == null ) ? Boolean.class : obj.getNumeracionPreImpresa();
		Object asociadoRG10098 = ( obj.getAsociadoRG10098() == null ) ? Boolean.class : obj.getAsociadoRG10098();
		Object talonarioControladorFizcal = ( obj.getTalonarioControladorFizcal() != null && obj.getTalonarioControladorFizcal().getId() != null) ? obj.getTalonarioControladorFizcal().getId() : String.class;
		Object primerNumero = ( obj.getPrimerNumero() == null ) ? Integer.class : obj.getPrimerNumero();
		Object proximoNumero = ( obj.getProximoNumero() == null ) ? Integer.class : obj.getProximoNumero();
		Object ultimoNumero = ( obj.getUltimoNumero() == null ) ? Integer.class : obj.getUltimoNumero();
		Object cantidadMinimaComprobantes = ( obj.getCantidadMinimaComprobantes() == null ) ? Integer.class : obj.getCantidadMinimaComprobantes();
		Object fecha = ( obj.getFecha() == null ) ? java.util.Date.class : obj.getFecha();
		Object numeroCAI = ( obj.getNumeroCAI() == null ) ? Long.class : obj.getNumeroCAI();
		Object vencimiento = ( obj.getVencimiento() == null ) ? java.util.Date.class : obj.getVencimiento();
		Object diasAvisoVencimiento = ( obj.getDiasAvisoVencimiento() == null ) ? Integer.class : obj.getDiasAvisoVencimiento();

		String sql = "SELECT * FROM massoftware.u_Talonario(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, talonarioLetra, puntoVenta, autonumeracion, numeracionPreImpresa, asociadoRG10098, talonarioControladorFizcal, primerNumero, proximoNumero, ultimoNumero, cantidadMinimaComprobantes, fecha, numeroCAI, vencimiento, diasAvisoVencimiento};

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
			throw new IllegalArgumentException("Se esperaba un id (Talonario.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_TalonarioById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (Talonario.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_Talonario_numero(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (Talonario.nombre) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Talonario_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_Talonario_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValuePuntoVenta() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Talonario_puntoVenta()";

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

		String sql = "SELECT * FROM massoftware.f_next_Talonario_primerNumero()";

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

		String sql = "SELECT * FROM massoftware.f_next_Talonario_proximoNumero()";

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

		String sql = "SELECT * FROM massoftware.f_next_Talonario_ultimoNumero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValueCantidadMinimaComprobantes() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Talonario_cantidadMinimaComprobantes()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Long nextValueNumeroCAI() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Talonario_numeroCAI()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Long) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValueDiasAvisoVencimiento() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Talonario_diasAvisoVencimiento()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.Talonario;";

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


	public List<Talonario> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Talonario.numero o Talonario.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº talonario

		if(UtilNumeric.isInteger(arg)) {

			TalonarioFiltro filtroNumero = new TalonarioFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Talonario> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		TalonarioFiltro filtroNombre = new TalonarioFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Talonario> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Talonario>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Talonario findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Talonario findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (Talonario.id) no nulo/vacio.");
		}

		id = id.trim();

		Talonario obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_TalonarioById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 17) {

				obj = mapper17Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 20) {

				obj = mapper20Fields(row);

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


	public List<Talonario> find(TalonarioFiltro filtro) throws Exception {

		List<Talonario> listado = new ArrayList<Talonario>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_Talonario" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 17) {

				Talonario obj = mapper17Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 20) {

				Talonario obj = mapper20Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Talonario mapper17Fields(Object[] row) throws Exception {

		int c = -1;

		String idTalonarioArg0 = (String) row[++c];
		Integer numeroTalonarioArg1 = (Integer) row[++c];
		String nombreTalonarioArg2 = (String) row[++c];
		String talonarioLetraTalonarioArg3 = (String) row[++c]; // TalonarioLetra.id
		Integer puntoVentaTalonarioArg4 = (Integer) row[++c];
		Boolean autonumeracionTalonarioArg5 = (Boolean) row[++c];
		Boolean numeracionPreImpresaTalonarioArg6 = (Boolean) row[++c];
		Boolean asociadoRG10098TalonarioArg7 = (Boolean) row[++c];
		String talonarioControladorFizcalTalonarioArg8 = (String) row[++c]; // TalonarioControladorFizcal.id
		Integer primerNumeroTalonarioArg9 = (Integer) row[++c];
		Integer proximoNumeroTalonarioArg10 = (Integer) row[++c];
		Integer ultimoNumeroTalonarioArg11 = (Integer) row[++c];
		Integer cantidadMinimaComprobantesTalonarioArg12 = (Integer) row[++c];
		java.util.Date fechaTalonarioArg13 = (java.util.Date) row[++c];
		Long numeroCAITalonarioArg14 = (Long) row[++c];
		java.util.Date vencimientoTalonarioArg15 = (java.util.Date) row[++c];
		Integer diasAvisoVencimientoTalonarioArg16 = (Integer) row[++c];

		Talonario obj = new Talonario(idTalonarioArg0, numeroTalonarioArg1, nombreTalonarioArg2, talonarioLetraTalonarioArg3, puntoVentaTalonarioArg4, autonumeracionTalonarioArg5, numeracionPreImpresaTalonarioArg6, asociadoRG10098TalonarioArg7, talonarioControladorFizcalTalonarioArg8, primerNumeroTalonarioArg9, proximoNumeroTalonarioArg10, ultimoNumeroTalonarioArg11, cantidadMinimaComprobantesTalonarioArg12, fechaTalonarioArg13, numeroCAITalonarioArg14, vencimientoTalonarioArg15, diasAvisoVencimientoTalonarioArg16);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Talonario mapper20Fields(Object[] row) throws Exception {

		int c = -1;

		String idTalonarioArg0 = (String) row[++c];
		Integer numeroTalonarioArg1 = (Integer) row[++c];
		String nombreTalonarioArg2 = (String) row[++c];
		String idTalonarioLetraArg3 = (String) row[++c];
		String nombreTalonarioLetraArg4 = (String) row[++c];
		Integer puntoVentaTalonarioArg5 = (Integer) row[++c];
		Boolean autonumeracionTalonarioArg6 = (Boolean) row[++c];
		Boolean numeracionPreImpresaTalonarioArg7 = (Boolean) row[++c];
		Boolean asociadoRG10098TalonarioArg8 = (Boolean) row[++c];
		String idTalonarioControladorFizcalArg9 = (String) row[++c];
		String codigoTalonarioControladorFizcalArg10 = (String) row[++c];
		String nombreTalonarioControladorFizcalArg11 = (String) row[++c];
		Integer primerNumeroTalonarioArg12 = (Integer) row[++c];
		Integer proximoNumeroTalonarioArg13 = (Integer) row[++c];
		Integer ultimoNumeroTalonarioArg14 = (Integer) row[++c];
		Integer cantidadMinimaComprobantesTalonarioArg15 = (Integer) row[++c];
		java.util.Date fechaTalonarioArg16 = (java.util.Date) row[++c];
		Long numeroCAITalonarioArg17 = (Long) row[++c];
		java.util.Date vencimientoTalonarioArg18 = (java.util.Date) row[++c];
		Integer diasAvisoVencimientoTalonarioArg19 = (Integer) row[++c];

		Talonario obj = new Talonario(idTalonarioArg0, numeroTalonarioArg1, nombreTalonarioArg2, idTalonarioLetraArg3, nombreTalonarioLetraArg4, puntoVentaTalonarioArg5, autonumeracionTalonarioArg6, numeracionPreImpresaTalonarioArg7, asociadoRG10098TalonarioArg8, idTalonarioControladorFizcalArg9, codigoTalonarioControladorFizcalArg10, nombreTalonarioControladorFizcalArg11, primerNumeroTalonarioArg12, proximoNumeroTalonarioArg13, ultimoNumeroTalonarioArg14, cantidadMinimaComprobantesTalonarioArg15, fechaTalonarioArg16, numeroCAITalonarioArg17, vencimientoTalonarioArg18, diasAvisoVencimientoTalonarioArg19);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------