package com.massoftware.backend.populate;
import java.util.List;
import java.util.List;
import java.util.Random;
import com.massoftware.AppCX;

import com.massoftware.model.seguridad.Usuario;
import com.massoftware.service.seguridad.UsuarioFiltro;
import com.massoftware.service.seguridad.UsuarioService;
import com.massoftware.model.geo.Zona;
import com.massoftware.service.geo.ZonaFiltro;
import com.massoftware.service.geo.ZonaService;
import com.massoftware.model.geo.Pais;
import com.massoftware.service.geo.PaisFiltro;
import com.massoftware.service.geo.PaisService;
import com.massoftware.model.geo.Provincia;
import com.massoftware.service.geo.ProvinciaFiltro;
import com.massoftware.service.geo.ProvinciaService;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.service.geo.CiudadFiltro;
import com.massoftware.service.geo.CiudadService;
import com.massoftware.model.geo.CodigoPostal;
import com.massoftware.service.geo.CodigoPostalFiltro;
import com.massoftware.service.geo.CodigoPostalService;
import com.massoftware.model.logistica.Transporte;
import com.massoftware.service.logistica.TransporteFiltro;
import com.massoftware.service.logistica.TransporteService;
import com.massoftware.model.logistica.Carga;
import com.massoftware.service.logistica.CargaFiltro;
import com.massoftware.service.logistica.CargaService;
import com.massoftware.model.logistica.TransporteTarifa;
import com.massoftware.service.logistica.TransporteTarifaFiltro;
import com.massoftware.service.logistica.TransporteTarifaService;
import com.massoftware.model.afip.TipoDocumentoAFIP;
import com.massoftware.service.afip.TipoDocumentoAFIPFiltro;
import com.massoftware.service.afip.TipoDocumentoAFIPService;
import com.massoftware.model.afip.MonedaAFIP;
import com.massoftware.service.afip.MonedaAFIPFiltro;
import com.massoftware.service.afip.MonedaAFIPService;
import com.massoftware.model.monedas.Moneda;
import com.massoftware.service.monedas.MonedaFiltro;
import com.massoftware.service.monedas.MonedaService;
import com.massoftware.model.contabilidad.ventas.NotaCreditoMotivo;
import com.massoftware.service.contabilidad.ventas.NotaCreditoMotivoFiltro;
import com.massoftware.service.contabilidad.ventas.NotaCreditoMotivoService;
import com.massoftware.model.clientes.MotivoComentario;
import com.massoftware.service.clientes.MotivoComentarioFiltro;
import com.massoftware.service.clientes.MotivoComentarioService;
import com.massoftware.model.clientes.TipoCliente;
import com.massoftware.service.clientes.TipoClienteFiltro;
import com.massoftware.service.clientes.TipoClienteService;
import com.massoftware.model.clientes.ClasificacionCliente;
import com.massoftware.service.clientes.ClasificacionClienteFiltro;
import com.massoftware.service.clientes.ClasificacionClienteService;
import com.massoftware.model.clientes.MotivoBloqueoCliente;
import com.massoftware.service.clientes.MotivoBloqueoClienteFiltro;
import com.massoftware.service.clientes.MotivoBloqueoClienteService;

public class Populate {

	static int maxRows = 1000;

	public static void main(String[] args) throws Exception {
			insertUsuario();
			insertZona();
			insertPais();
			insertProvincia();
			insertCiudad();
			insertCodigoPostal();
			insertTransporte();
			insertCarga();
			insertTransporteTarifa();
			insertTipoDocumentoAFIP();
			insertMonedaAFIP();
			insertMoneda();
			insertNotaCreditoMotivo();
			insertMotivoComentario();
			insertTipoCliente();
			insertClasificacionCliente();
			insertMotivoBloqueoCliente();
	}


	public static void insertUsuario() throws Exception {

		UsuarioService service = AppCX.services().buildUsuarioService();

		for(int i = 0; i < maxRows; i++){

			try {

				Usuario obj = new Usuario();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertZona() throws Exception {

		ZonaService service = AppCX.services().buildZonaService();

		for(int i = 0; i < maxRows; i++){

			try {

				Zona obj = new Zona();

				obj.setCodigo(UtilPopulate.getStringRandom(null, 3, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setBonificacion(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("0"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setRecargo(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("0"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertPais() throws Exception {

		PaisService service = AppCX.services().buildPaisService();

		for(int i = 0; i < maxRows; i++){

			try {

				Pais obj = new Pais();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertProvincia() throws Exception {

		ProvinciaService service = AppCX.services().buildProvinciaService();
		PaisService servicePais = AppCX.services().buildPaisService();
		Long paisCount = servicePais.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Provincia obj = new Provincia();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				obj.setNumeroAFIP(UtilPopulate.getIntegerRandom(1, null, false));

				obj.setNumeroIngresosBrutos(UtilPopulate.getIntegerRandom(1, null, false));

				obj.setNumeroRENATEA(UtilPopulate.getIntegerRandom(1, null, false));

				PaisFiltro paisFiltro = new PaisFiltro();
				long paisIndex = UtilPopulate.getLongRandom(0L, paisCount-1);
				paisFiltro.setOffset(paisIndex);
				paisFiltro.setLimit(1L);
				List<Pais> paisListado = servicePais.find(paisFiltro);
				obj.setPais(paisListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertCiudad() throws Exception {

		CiudadService service = AppCX.services().buildCiudadService();
		ProvinciaService serviceProvincia = AppCX.services().buildProvinciaService();
		Long provinciaCount = serviceProvincia.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Ciudad obj = new Ciudad();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setDepartamento(UtilPopulate.getStringRandom(null, 50, false));

				obj.setNumeroAFIP(UtilPopulate.getIntegerRandom(1, null, false));

				ProvinciaFiltro provinciaFiltro = new ProvinciaFiltro();
				long provinciaIndex = UtilPopulate.getLongRandom(0L, provinciaCount-1);
				provinciaFiltro.setOffset(provinciaIndex);
				provinciaFiltro.setLimit(1L);
				List<Provincia> provinciaListado = serviceProvincia.find(provinciaFiltro);
				obj.setProvincia(provinciaListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertCodigoPostal() throws Exception {

		CodigoPostalService service = AppCX.services().buildCodigoPostalService();
		CiudadService serviceCiudad = AppCX.services().buildCiudadService();
		Long ciudadCount = serviceCiudad.count();

		for(int i = 0; i < maxRows; i++){

			try {

				CodigoPostal obj = new CodigoPostal();

				obj.setCodigo(UtilPopulate.getStringRandom(null, 12, true));

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombreCalle(UtilPopulate.getStringRandom(null, 200, true));

				obj.setNumeroCalle(UtilPopulate.getStringRandom(null, 20, true));

				CiudadFiltro ciudadFiltro = new CiudadFiltro();
				long ciudadIndex = UtilPopulate.getLongRandom(0L, ciudadCount-1);
				ciudadFiltro.setOffset(ciudadIndex);
				ciudadFiltro.setLimit(1L);
				List<Ciudad> ciudadListado = serviceCiudad.find(ciudadFiltro);
				obj.setCiudad(ciudadListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTransporte() throws Exception {

		TransporteService service = AppCX.services().buildTransporteService();
		CodigoPostalService serviceCodigoPostal = AppCX.services().buildCodigoPostalService();
		Long codigoPostalCount = serviceCodigoPostal.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Transporte obj = new Transporte();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setCuit(UtilPopulate.getLongRandom(1L, 99999999999L, true));

				obj.setIngresosBrutos(UtilPopulate.getStringRandom(null, 13, false));

				obj.setTelefono(UtilPopulate.getStringRandom(null, 50, false));

				obj.setFax(UtilPopulate.getStringRandom(null, 50, false));

				CodigoPostalFiltro codigoPostalFiltro = new CodigoPostalFiltro();
				long codigoPostalIndex = UtilPopulate.getLongRandom(0L, codigoPostalCount-1);
				codigoPostalFiltro.setOffset(codigoPostalIndex);
				codigoPostalFiltro.setLimit(1L);
				List<CodigoPostal> codigoPostalListado = serviceCodigoPostal.find(codigoPostalFiltro);
				obj.setCodigoPostal(codigoPostalListado.get(0));

				obj.setDomicilio(UtilPopulate.getStringRandom(null, 150, false));

				obj.setComentario(UtilPopulate.getStringRandom(null, 300, false));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertCarga() throws Exception {

		CargaService service = AppCX.services().buildCargaService();
		TransporteService serviceTransporte = AppCX.services().buildTransporteService();
		Long transporteCount = serviceTransporte.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Carga obj = new Carga();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				TransporteFiltro transporteFiltro = new TransporteFiltro();
				long transporteIndex = UtilPopulate.getLongRandom(0L, transporteCount-1);
				transporteFiltro.setOffset(transporteIndex);
				transporteFiltro.setLimit(1L);
				List<Transporte> transporteListado = serviceTransporte.find(transporteFiltro);
				obj.setTransporte(transporteListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTransporteTarifa() throws Exception {

		TransporteTarifaService service = AppCX.services().buildTransporteTarifaService();
		CargaService serviceCarga = AppCX.services().buildCargaService();
		Long cargaCount = serviceCarga.count();
		CiudadService serviceCiudad = AppCX.services().buildCiudadService();
		Long ciudadCount = serviceCiudad.count();

		for(int i = 0; i < maxRows; i++){

			try {

				TransporteTarifa obj = new TransporteTarifa();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				CargaFiltro cargaFiltro = new CargaFiltro();
				long cargaIndex = UtilPopulate.getLongRandom(0L, cargaCount-1);
				cargaFiltro.setOffset(cargaIndex);
				cargaFiltro.setLimit(1L);
				List<Carga> cargaListado = serviceCarga.find(cargaFiltro);
				obj.setCarga(cargaListado.get(0));

				CiudadFiltro ciudadFiltro = new CiudadFiltro();
				long ciudadIndex = UtilPopulate.getLongRandom(0L, ciudadCount-1);
				ciudadFiltro.setOffset(ciudadIndex);
				ciudadFiltro.setLimit(1L);
				List<Ciudad> ciudadListado = serviceCiudad.find(ciudadFiltro);
				obj.setCiudad(ciudadListado.get(0));

				obj.setPrecioFlete(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setPrecioUnidadFacturacion(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setPrecioUnidadStock(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setPrecioBultos(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setImporteMinimoEntrega(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setImporteMinimoCarga(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTipoDocumentoAFIP() throws Exception {

		TipoDocumentoAFIPService service = AppCX.services().buildTipoDocumentoAFIPService();

		for(int i = 0; i < maxRows; i++){

			try {

				TipoDocumentoAFIP obj = new TipoDocumentoAFIP();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertMonedaAFIP() throws Exception {

		MonedaAFIPService service = AppCX.services().buildMonedaAFIPService();

		for(int i = 0; i < maxRows; i++){

			try {

				MonedaAFIP obj = new MonedaAFIP();

				obj.setCodigo(UtilPopulate.getStringRandom(null, 3, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertMoneda() throws Exception {

		MonedaService service = AppCX.services().buildMonedaService();
		MonedaAFIPService serviceMonedaAFIP = AppCX.services().buildMonedaAFIPService();
		Long monedaAFIPCount = serviceMonedaAFIP.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Moneda obj = new Moneda();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				obj.setCotizacion(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setCotizacionFecha(new java.sql.Timestamp(UtilPopulate.getDateRandom(2000, 2019, true)));

				obj.setControlActualizacion(new Random().nextBoolean());

				MonedaAFIPFiltro monedaAFIPFiltro = new MonedaAFIPFiltro();
				long monedaAFIPIndex = UtilPopulate.getLongRandom(0L, monedaAFIPCount-1);
				monedaAFIPFiltro.setOffset(monedaAFIPIndex);
				monedaAFIPFiltro.setLimit(1L);
				List<MonedaAFIP> monedaAFIPListado = serviceMonedaAFIP.find(monedaAFIPFiltro);
				obj.setMonedaAFIP(monedaAFIPListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertNotaCreditoMotivo() throws Exception {

		NotaCreditoMotivoService service = AppCX.services().buildNotaCreditoMotivoService();

		for(int i = 0; i < maxRows; i++){

			try {

				NotaCreditoMotivo obj = new NotaCreditoMotivo();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertMotivoComentario() throws Exception {

		MotivoComentarioService service = AppCX.services().buildMotivoComentarioService();

		for(int i = 0; i < maxRows; i++){

			try {

				MotivoComentario obj = new MotivoComentario();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTipoCliente() throws Exception {

		TipoClienteService service = AppCX.services().buildTipoClienteService();

		for(int i = 0; i < maxRows; i++){

			try {

				TipoCliente obj = new TipoCliente();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertClasificacionCliente() throws Exception {

		ClasificacionClienteService service = AppCX.services().buildClasificacionClienteService();

		for(int i = 0; i < maxRows; i++){

			try {

				ClasificacionCliente obj = new ClasificacionCliente();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setColor(UtilPopulate.getIntegerRandom(1, null, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertMotivoBloqueoCliente() throws Exception {

		MotivoBloqueoClienteService service = AppCX.services().buildMotivoBloqueoClienteService();
		ClasificacionClienteService serviceClasificacionCliente = AppCX.services().buildClasificacionClienteService();
		Long clasificacionClienteCount = serviceClasificacionCliente.count();

		for(int i = 0; i < maxRows; i++){

			try {

				MotivoBloqueoCliente obj = new MotivoBloqueoCliente();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				ClasificacionClienteFiltro clasificacionClienteFiltro = new ClasificacionClienteFiltro();
				long clasificacionClienteIndex = UtilPopulate.getLongRandom(0L, clasificacionClienteCount-1);
				clasificacionClienteFiltro.setOffset(clasificacionClienteIndex);
				clasificacionClienteFiltro.setLimit(1L);
				List<ClasificacionCliente> clasificacionClienteListado = serviceClasificacionCliente.find(clasificacionClienteFiltro);
				obj.setClasificacionCliente(clasificacionClienteListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}


}