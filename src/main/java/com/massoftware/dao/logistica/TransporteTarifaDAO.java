package com.massoftware.dao.logistica;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.model.logistica.Transporte;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.logistica.TransporteTarifa;

public class TransporteTarifaDAO {

	private int levelDefault = 3;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(TransporteTarifa obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto TransporteTarifa no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object carga = ( obj.getCarga() != null && obj.getCarga().getId() != null) ? obj.getCarga().getId() : String.class;
		Object ciudad = ( obj.getCiudad() != null && obj.getCiudad().getId() != null) ? obj.getCiudad().getId() : String.class;
		Object precioFlete = ( obj.getPrecioFlete() == null ) ? java.math.BigDecimal.class : obj.getPrecioFlete();
		Object precioUnidadFacturacion = ( obj.getPrecioUnidadFacturacion() == null ) ? java.math.BigDecimal.class : obj.getPrecioUnidadFacturacion();
		Object precioUnidadStock = ( obj.getPrecioUnidadStock() == null ) ? java.math.BigDecimal.class : obj.getPrecioUnidadStock();
		Object precioBultos = ( obj.getPrecioBultos() == null ) ? java.math.BigDecimal.class : obj.getPrecioBultos();
		Object importeMinimoEntrega = ( obj.getImporteMinimoEntrega() == null ) ? java.math.BigDecimal.class : obj.getImporteMinimoEntrega();
		Object importeMinimoCarga = ( obj.getImporteMinimoCarga() == null ) ? java.math.BigDecimal.class : obj.getImporteMinimoCarga();

		String sql = "SELECT * FROM massoftware.i_TransporteTarifa(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, carga, ciudad, precioFlete, precioUnidadFacturacion, precioUnidadStock, precioBultos, importeMinimoEntrega, importeMinimoCarga};

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


	public String update(TransporteTarifa obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto TransporteTarifa no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto TransporteTarifa con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object carga = ( obj.getCarga() != null && obj.getCarga().getId() != null) ? obj.getCarga().getId() : String.class;
		Object ciudad = ( obj.getCiudad() != null && obj.getCiudad().getId() != null) ? obj.getCiudad().getId() : String.class;
		Object precioFlete = ( obj.getPrecioFlete() == null ) ? java.math.BigDecimal.class : obj.getPrecioFlete();
		Object precioUnidadFacturacion = ( obj.getPrecioUnidadFacturacion() == null ) ? java.math.BigDecimal.class : obj.getPrecioUnidadFacturacion();
		Object precioUnidadStock = ( obj.getPrecioUnidadStock() == null ) ? java.math.BigDecimal.class : obj.getPrecioUnidadStock();
		Object precioBultos = ( obj.getPrecioBultos() == null ) ? java.math.BigDecimal.class : obj.getPrecioBultos();
		Object importeMinimoEntrega = ( obj.getImporteMinimoEntrega() == null ) ? java.math.BigDecimal.class : obj.getImporteMinimoEntrega();
		Object importeMinimoCarga = ( obj.getImporteMinimoCarga() == null ) ? java.math.BigDecimal.class : obj.getImporteMinimoCarga();

		String sql = "SELECT * FROM massoftware.u_TransporteTarifa(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, carga, ciudad, precioFlete, precioUnidadFacturacion, precioUnidadStock, precioBultos, importeMinimoEntrega, importeMinimoCarga};

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

			throw new IllegalArgumentException("Se esperaba un id (TransporteTarifa.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_TransporteTarifaById(?)";

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


	// ---------------------------------------------------------------------------------------------------------------------------


	public Integer nextValueNumero() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValuePrecioFlete() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_precioFlete()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValuePrecioUnidadFacturacion() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadFacturacion()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValuePrecioUnidadStock() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadStock()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValuePrecioBultos() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_precioBultos()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValueImporteMinimoEntrega() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoEntrega()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValueImporteMinimoCarga() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoCarga()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.TransporteTarifa;";

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


	public List<TransporteTarifa> findByTransporte(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (TransporteTarifa.transporte) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Transporte

		TransporteTarifaFiltro filtroTransporte = new TransporteTarifaFiltro();

		filtroTransporte.setUnlimited(true);

		Transporte obj = new Transporte();

		obj.setId(arg);

		filtroTransporte.setTransporte(obj);

		List<TransporteTarifa> listadoTransporte = find(filtroTransporte);

		if(listadoTransporte.size() > 0) {

			return listadoTransporte;

		}


		return new ArrayList<TransporteTarifa>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public TransporteTarifa findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public TransporteTarifa findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (TransporteTarifa.id) no nulo/vacio.");

		}


		id = id.trim();


		TransporteTarifa obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_TransporteTarifaById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 8) {

				obj = mapper8Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 16) {

				obj = mapper16Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 32) {

				obj = mapper32Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 41) {

				obj = mapper41Fields(row);

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


	public List<TransporteTarifa> find(TransporteTarifaFiltro filtro) throws Exception {

		List<TransporteTarifa> listado = new ArrayList<TransporteTarifa>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";
		String orderByString = (filtro.getOrderBy() == null || filtro.getOrderBy().equals("id")) ? "" : "_" + filtro.getOrderBy();
		String orderByASCString = "";
		if(orderByString != null && orderByString.trim().length() > 0) {

			orderByString = "TransporteTarifa" + orderByString;
			orderByASCString = "_asc_";
			if(filtro.getOrderByDesc() == true) {
				orderByASCString = "_des_";
			}
			orderByString = orderByASCString + orderByString;
		}
		String params = (filtro.getUnlimited() == true) ? "" : "?, ?";

		String sql = "SELECT * FROM massoftware.f_TransporteTarifa" + orderByString + levelString + "(" + params + ")";


		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {};
		} else {
			args = new Object[] {filtro.getLimit(), filtro.getOffset()};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 8) {

				TransporteTarifa obj = mapper8Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 16) {

				TransporteTarifa obj = mapper16Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 32) {

				TransporteTarifa obj = mapper32Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 41) {

				TransporteTarifa obj = mapper41Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private TransporteTarifa mapper8Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteTarifaArg0 = (String) row[++c];
		Integer numeroTransporteTarifaArg1 = (Integer) row[++c];
		java.math.BigDecimal precioFleteTransporteTarifaArg2 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadFacturacionTransporteTarifaArg3 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadStockTransporteTarifaArg4 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioBultosTransporteTarifaArg5 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoEntregaTransporteTarifaArg6 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoCargaTransporteTarifaArg7 = (java.math.BigDecimal) row[++c];

		TransporteTarifa obj = new TransporteTarifa(idTransporteTarifaArg0, numeroTransporteTarifaArg1, precioFleteTransporteTarifaArg2, precioUnidadFacturacionTransporteTarifaArg3, precioUnidadStockTransporteTarifaArg4, precioBultosTransporteTarifaArg5, importeMinimoEntregaTransporteTarifaArg6, importeMinimoCargaTransporteTarifaArg7);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private TransporteTarifa mapper16Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteTarifaArg0 = (String) row[++c];
		Integer numeroTransporteTarifaArg1 = (Integer) row[++c];
		String idCargaArg2 = (String) row[++c];
		Integer numeroCargaArg3 = (Integer) row[++c];
		String nombreCargaArg4 = (String) row[++c];
		String idCiudadArg5 = (String) row[++c];
		Integer numeroCiudadArg6 = (Integer) row[++c];
		String nombreCiudadArg7 = (String) row[++c];
		String departamentoCiudadArg8 = (String) row[++c];
		Integer numeroAFIPCiudadArg9 = (Integer) row[++c];
		java.math.BigDecimal precioFleteTransporteTarifaArg10 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadFacturacionTransporteTarifaArg11 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadStockTransporteTarifaArg12 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioBultosTransporteTarifaArg13 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoEntregaTransporteTarifaArg14 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoCargaTransporteTarifaArg15 = (java.math.BigDecimal) row[++c];

		TransporteTarifa obj = new TransporteTarifa(idTransporteTarifaArg0, numeroTransporteTarifaArg1, idCargaArg2, numeroCargaArg3, nombreCargaArg4, idCiudadArg5, numeroCiudadArg6, nombreCiudadArg7, departamentoCiudadArg8, numeroAFIPCiudadArg9, precioFleteTransporteTarifaArg10, precioUnidadFacturacionTransporteTarifaArg11, precioUnidadStockTransporteTarifaArg12, precioBultosTransporteTarifaArg13, importeMinimoEntregaTransporteTarifaArg14, importeMinimoCargaTransporteTarifaArg15);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private TransporteTarifa mapper32Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteTarifaArg0 = (String) row[++c];
		Integer numeroTransporteTarifaArg1 = (Integer) row[++c];
		String idCargaArg2 = (String) row[++c];
		Integer numeroCargaArg3 = (Integer) row[++c];
		String nombreCargaArg4 = (String) row[++c];
		String idTransporteArg5 = (String) row[++c];
		Integer numeroTransporteArg6 = (Integer) row[++c];
		String nombreTransporteArg7 = (String) row[++c];
		Long cuitTransporteArg8 = (Long) row[++c];
		String ingresosBrutosTransporteArg9 = (String) row[++c];
		String telefonoTransporteArg10 = (String) row[++c];
		String faxTransporteArg11 = (String) row[++c];
		String domicilioTransporteArg12 = (String) row[++c];
		String comentarioTransporteArg13 = (String) row[++c];
		String idCiudadArg14 = (String) row[++c];
		Integer numeroCiudadArg15 = (Integer) row[++c];
		String nombreCiudadArg16 = (String) row[++c];
		String departamentoCiudadArg17 = (String) row[++c];
		Integer numeroAFIPCiudadArg18 = (Integer) row[++c];
		String idProvinciaArg19 = (String) row[++c];
		Integer numeroProvinciaArg20 = (Integer) row[++c];
		String nombreProvinciaArg21 = (String) row[++c];
		String abreviaturaProvinciaArg22 = (String) row[++c];
		Integer numeroAFIPProvinciaArg23 = (Integer) row[++c];
		Integer numeroIngresosBrutosProvinciaArg24 = (Integer) row[++c];
		Integer numeroRENATEAProvinciaArg25 = (Integer) row[++c];
		java.math.BigDecimal precioFleteTransporteTarifaArg26 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadFacturacionTransporteTarifaArg27 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadStockTransporteTarifaArg28 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioBultosTransporteTarifaArg29 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoEntregaTransporteTarifaArg30 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoCargaTransporteTarifaArg31 = (java.math.BigDecimal) row[++c];

		TransporteTarifa obj = new TransporteTarifa(idTransporteTarifaArg0, numeroTransporteTarifaArg1, idCargaArg2, numeroCargaArg3, nombreCargaArg4, idTransporteArg5, numeroTransporteArg6, nombreTransporteArg7, cuitTransporteArg8, ingresosBrutosTransporteArg9, telefonoTransporteArg10, faxTransporteArg11, domicilioTransporteArg12, comentarioTransporteArg13, idCiudadArg14, numeroCiudadArg15, nombreCiudadArg16, departamentoCiudadArg17, numeroAFIPCiudadArg18, idProvinciaArg19, numeroProvinciaArg20, nombreProvinciaArg21, abreviaturaProvinciaArg22, numeroAFIPProvinciaArg23, numeroIngresosBrutosProvinciaArg24, numeroRENATEAProvinciaArg25, precioFleteTransporteTarifaArg26, precioUnidadFacturacionTransporteTarifaArg27, precioUnidadStockTransporteTarifaArg28, precioBultosTransporteTarifaArg29, importeMinimoEntregaTransporteTarifaArg30, importeMinimoCargaTransporteTarifaArg31);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private TransporteTarifa mapper41Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteTarifaArg0 = (String) row[++c];
		Integer numeroTransporteTarifaArg1 = (Integer) row[++c];
		String idCargaArg2 = (String) row[++c];
		Integer numeroCargaArg3 = (Integer) row[++c];
		String nombreCargaArg4 = (String) row[++c];
		String idTransporteArg5 = (String) row[++c];
		Integer numeroTransporteArg6 = (Integer) row[++c];
		String nombreTransporteArg7 = (String) row[++c];
		Long cuitTransporteArg8 = (Long) row[++c];
		String ingresosBrutosTransporteArg9 = (String) row[++c];
		String telefonoTransporteArg10 = (String) row[++c];
		String faxTransporteArg11 = (String) row[++c];
		String idCodigoPostalArg12 = (String) row[++c];
		String codigoCodigoPostalArg13 = (String) row[++c];
		Integer numeroCodigoPostalArg14 = (Integer) row[++c];
		String nombreCalleCodigoPostalArg15 = (String) row[++c];
		String numeroCalleCodigoPostalArg16 = (String) row[++c];
		String domicilioTransporteArg17 = (String) row[++c];
		String comentarioTransporteArg18 = (String) row[++c];
		String idCiudadArg19 = (String) row[++c];
		Integer numeroCiudadArg20 = (Integer) row[++c];
		String nombreCiudadArg21 = (String) row[++c];
		String departamentoCiudadArg22 = (String) row[++c];
		Integer numeroAFIPCiudadArg23 = (Integer) row[++c];
		String idProvinciaArg24 = (String) row[++c];
		Integer numeroProvinciaArg25 = (Integer) row[++c];
		String nombreProvinciaArg26 = (String) row[++c];
		String abreviaturaProvinciaArg27 = (String) row[++c];
		Integer numeroAFIPProvinciaArg28 = (Integer) row[++c];
		Integer numeroIngresosBrutosProvinciaArg29 = (Integer) row[++c];
		Integer numeroRENATEAProvinciaArg30 = (Integer) row[++c];
		String idPaisArg31 = (String) row[++c];
		Integer numeroPaisArg32 = (Integer) row[++c];
		String nombrePaisArg33 = (String) row[++c];
		String abreviaturaPaisArg34 = (String) row[++c];
		java.math.BigDecimal precioFleteTransporteTarifaArg35 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadFacturacionTransporteTarifaArg36 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadStockTransporteTarifaArg37 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioBultosTransporteTarifaArg38 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoEntregaTransporteTarifaArg39 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoCargaTransporteTarifaArg40 = (java.math.BigDecimal) row[++c];

		TransporteTarifa obj = new TransporteTarifa(idTransporteTarifaArg0, numeroTransporteTarifaArg1, idCargaArg2, numeroCargaArg3, nombreCargaArg4, idTransporteArg5, numeroTransporteArg6, nombreTransporteArg7, cuitTransporteArg8, ingresosBrutosTransporteArg9, telefonoTransporteArg10, faxTransporteArg11, idCodigoPostalArg12, codigoCodigoPostalArg13, numeroCodigoPostalArg14, nombreCalleCodigoPostalArg15, numeroCalleCodigoPostalArg16, domicilioTransporteArg17, comentarioTransporteArg18, idCiudadArg19, numeroCiudadArg20, nombreCiudadArg21, departamentoCiudadArg22, numeroAFIPCiudadArg23, idProvinciaArg24, numeroProvinciaArg25, nombreProvinciaArg26, abreviaturaProvinciaArg27, numeroAFIPProvinciaArg28, numeroIngresosBrutosProvinciaArg29, numeroRENATEAProvinciaArg30, idPaisArg31, numeroPaisArg32, nombrePaisArg33, abreviaturaPaisArg34, precioFleteTransporteTarifaArg35, precioUnidadFacturacionTransporteTarifaArg36, precioUnidadStockTransporteTarifaArg37, precioBultosTransporteTarifaArg38, importeMinimoEntregaTransporteTarifaArg39, importeMinimoCargaTransporteTarifaArg40);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------