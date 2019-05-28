package com.massoftware.backend.populate;
import java.util.List;
import java.util.Random;

import com.massoftware.model.seguridad.Usuario;
import com.massoftware.dao.seguridad.UsuarioFiltro;
import com.massoftware.dao.seguridad.UsuarioDAO;
import com.massoftware.model.geo.Zona;
import com.massoftware.dao.geo.ZonaFiltro;
import com.massoftware.dao.geo.ZonaDAO;
import com.massoftware.model.geo.Pais;
import com.massoftware.dao.geo.PaisFiltro;
import com.massoftware.dao.geo.PaisDAO;
import com.massoftware.model.geo.Provincia;
import com.massoftware.dao.geo.ProvinciaFiltro;
import com.massoftware.dao.geo.ProvinciaDAO;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.dao.geo.CiudadFiltro;
import com.massoftware.dao.geo.CiudadDAO;
import com.massoftware.model.geo.CodigoPostal;
import com.massoftware.dao.geo.CodigoPostalFiltro;
import com.massoftware.dao.geo.CodigoPostalDAO;
import com.massoftware.model.logistica.Transporte;
import com.massoftware.dao.logistica.TransporteFiltro;
import com.massoftware.dao.logistica.TransporteDAO;
import com.massoftware.model.logistica.Carga;
import com.massoftware.dao.logistica.CargaFiltro;
import com.massoftware.dao.logistica.CargaDAO;
import com.massoftware.model.logistica.TransporteTarifa;
import com.massoftware.dao.logistica.TransporteTarifaFiltro;
import com.massoftware.dao.logistica.TransporteTarifaDAO;
import com.massoftware.model.afip.TipoDocumentoAFIP;
import com.massoftware.dao.afip.TipoDocumentoAFIPFiltro;
import com.massoftware.dao.afip.TipoDocumentoAFIPDAO;
import com.massoftware.model.afip.MonedaAFIP;
import com.massoftware.dao.afip.MonedaAFIPFiltro;
import com.massoftware.dao.afip.MonedaAFIPDAO;
import com.massoftware.model.monedas.Moneda;
import com.massoftware.dao.monedas.MonedaFiltro;
import com.massoftware.dao.monedas.MonedaDAO;
import com.massoftware.model.contabilidad.ventas.NotaCreditoMotivo;
import com.massoftware.dao.contabilidad.ventas.NotaCreditoMotivoFiltro;
import com.massoftware.dao.contabilidad.ventas.NotaCreditoMotivoDAO;
import com.massoftware.model.clientes.MotivoComentario;
import com.massoftware.dao.clientes.MotivoComentarioFiltro;
import com.massoftware.dao.clientes.MotivoComentarioDAO;
import com.massoftware.model.clientes.TipoCliente;
import com.massoftware.dao.clientes.TipoClienteFiltro;
import com.massoftware.dao.clientes.TipoClienteDAO;
import com.massoftware.model.clientes.ClasificacionCliente;
import com.massoftware.dao.clientes.ClasificacionClienteFiltro;
import com.massoftware.dao.clientes.ClasificacionClienteDAO;
import com.massoftware.model.clientes.MotivoBloqueoCliente;
import com.massoftware.dao.clientes.MotivoBloqueoClienteFiltro;
import com.massoftware.dao.clientes.MotivoBloqueoClienteDAO;

public class Populate {

	static int maxRows = 1000;

	public static void main(String[] args) {
		try {
			insertUsuario();
		} catch (Exception e) {}
		try {
			insertZona();
		} catch (Exception e) {}
		try {
			insertPais();
		} catch (Exception e) {}
		try {
			insertProvincia();
		} catch (Exception e) {}
		try {
			insertCiudad();
		} catch (Exception e) {}
		try {
			insertCodigoPostal();
		} catch (Exception e) {}
		try {
			insertTransporte();
		} catch (Exception e) {}
		try {
			insertCarga();
		} catch (Exception e) {}
		try {
			insertTransporteTarifa();
		} catch (Exception e) {}
		try {
			insertTipoDocumentoAFIP();
		} catch (Exception e) {}
		try {
			insertMonedaAFIP();
		} catch (Exception e) {}
		try {
			insertMoneda();
		} catch (Exception e) {}
		try {
			insertNotaCreditoMotivo();
		} catch (Exception e) {}
		try {
			insertMotivoComentario();
		} catch (Exception e) {}
		try {
			insertTipoCliente();
		} catch (Exception e) {}
		try {
			insertClasificacionCliente();
		} catch (Exception e) {}
		try {
			insertMotivoBloqueoCliente();
		} catch (Exception e) {}
	}


	public static void insertUsuario() throws Exception {

		UsuarioDAO dao = new UsuarioDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				Usuario obj = new Usuario();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertZona() throws Exception {

		ZonaDAO dao = new ZonaDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				Zona obj = new Zona();

				obj.setCodigo(UtilPopulate.getStringRandom(null, 3, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setBonificacion(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("0"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setRecargo(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("0"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertPais() throws Exception {

		PaisDAO dao = new PaisDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				Pais obj = new Pais();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertProvincia() throws Exception {

		ProvinciaDAO dao = new ProvinciaDAO();
		PaisDAO daoPais = new PaisDAO();
		Long paisCount = daoPais.count();

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
				paisFiltro.setLimit(paisIndex);
				List<Pais> paisListado = daoPais.find(paisFiltro);
				obj.setPais(paisListado.get(0));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertCiudad() throws Exception {

		CiudadDAO dao = new CiudadDAO();
		ProvinciaDAO daoProvincia = new ProvinciaDAO();
		Long provinciaCount = daoProvincia.count();

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
				provinciaFiltro.setLimit(provinciaIndex);
				List<Provincia> provinciaListado = daoProvincia.find(provinciaFiltro);
				obj.setProvincia(provinciaListado.get(0));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertCodigoPostal() throws Exception {

		CodigoPostalDAO dao = new CodigoPostalDAO();
		CiudadDAO daoCiudad = new CiudadDAO();
		Long ciudadCount = daoCiudad.count();

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
				ciudadFiltro.setLimit(ciudadIndex);
				List<Ciudad> ciudadListado = daoCiudad.find(ciudadFiltro);
				obj.setCiudad(ciudadListado.get(0));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertTransporte() throws Exception {

		TransporteDAO dao = new TransporteDAO();
		CodigoPostalDAO daoCodigoPostal = new CodigoPostalDAO();
		Long codigoPostalCount = daoCodigoPostal.count();

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
				codigoPostalFiltro.setLimit(codigoPostalIndex);
				List<CodigoPostal> codigoPostalListado = daoCodigoPostal.find(codigoPostalFiltro);
				obj.setCodigoPostal(codigoPostalListado.get(0));

				obj.setDomicilio(UtilPopulate.getStringRandom(null, 150, false));

				obj.setComentario(UtilPopulate.getStringRandom(null, 300, false));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertCarga() throws Exception {

		CargaDAO dao = new CargaDAO();
		TransporteDAO daoTransporte = new TransporteDAO();
		Long transporteCount = daoTransporte.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Carga obj = new Carga();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				TransporteFiltro transporteFiltro = new TransporteFiltro();
				long transporteIndex = UtilPopulate.getLongRandom(0L, transporteCount-1);
				transporteFiltro.setOffset(transporteIndex);
				transporteFiltro.setLimit(transporteIndex);
				List<Transporte> transporteListado = daoTransporte.find(transporteFiltro);
				obj.setTransporte(transporteListado.get(0));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertTransporteTarifa() throws Exception {

		TransporteTarifaDAO dao = new TransporteTarifaDAO();
		CargaDAO daoCarga = new CargaDAO();
		Long cargaCount = daoCarga.count();
		CiudadDAO daoCiudad = new CiudadDAO();
		Long ciudadCount = daoCiudad.count();

		for(int i = 0; i < maxRows; i++){

			try {

				TransporteTarifa obj = new TransporteTarifa();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				CargaFiltro cargaFiltro = new CargaFiltro();
				long cargaIndex = UtilPopulate.getLongRandom(0L, cargaCount-1);
				cargaFiltro.setOffset(cargaIndex);
				cargaFiltro.setLimit(cargaIndex);
				List<Carga> cargaListado = daoCarga.find(cargaFiltro);
				obj.setCarga(cargaListado.get(0));

				CiudadFiltro ciudadFiltro = new CiudadFiltro();
				long ciudadIndex = UtilPopulate.getLongRandom(0L, ciudadCount-1);
				ciudadFiltro.setOffset(ciudadIndex);
				ciudadFiltro.setLimit(ciudadIndex);
				List<Ciudad> ciudadListado = daoCiudad.find(ciudadFiltro);
				obj.setCiudad(ciudadListado.get(0));

				obj.setPrecioFlete(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setPrecioUnidadFacturacion(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setPrecioUnidadStock(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setPrecioBultos(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setImporteMinimoEntrega(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setImporteMinimoCarga(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertTipoDocumentoAFIP() throws Exception {

		TipoDocumentoAFIPDAO dao = new TipoDocumentoAFIPDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				TipoDocumentoAFIP obj = new TipoDocumentoAFIP();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertMonedaAFIP() throws Exception {

		MonedaAFIPDAO dao = new MonedaAFIPDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				MonedaAFIP obj = new MonedaAFIP();

				obj.setCodigo(UtilPopulate.getStringRandom(null, 3, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertMoneda() throws Exception {

		MonedaDAO dao = new MonedaDAO();
		MonedaAFIPDAO daoMonedaAFIP = new MonedaAFIPDAO();
		Long monedaAFIPCount = daoMonedaAFIP.count();

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
				monedaAFIPFiltro.setLimit(monedaAFIPIndex);
				List<MonedaAFIP> monedaAFIPListado = daoMonedaAFIP.find(monedaAFIPFiltro);
				obj.setMonedaAFIP(monedaAFIPListado.get(0));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertNotaCreditoMotivo() throws Exception {

		NotaCreditoMotivoDAO dao = new NotaCreditoMotivoDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				NotaCreditoMotivo obj = new NotaCreditoMotivo();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertMotivoComentario() throws Exception {

		MotivoComentarioDAO dao = new MotivoComentarioDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				MotivoComentario obj = new MotivoComentario();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertTipoCliente() throws Exception {

		TipoClienteDAO dao = new TipoClienteDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				TipoCliente obj = new TipoCliente();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertClasificacionCliente() throws Exception {

		ClasificacionClienteDAO dao = new ClasificacionClienteDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				ClasificacionCliente obj = new ClasificacionCliente();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setColor(UtilPopulate.getIntegerRandom(1, null, true));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertMotivoBloqueoCliente() throws Exception {

		MotivoBloqueoClienteDAO dao = new MotivoBloqueoClienteDAO();
		ClasificacionClienteDAO daoClasificacionCliente = new ClasificacionClienteDAO();
		Long clasificacionClienteCount = daoClasificacionCliente.count();

		for(int i = 0; i < maxRows; i++){

			try {

				MotivoBloqueoCliente obj = new MotivoBloqueoCliente();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				ClasificacionClienteFiltro clasificacionClienteFiltro = new ClasificacionClienteFiltro();
				long clasificacionClienteIndex = UtilPopulate.getLongRandom(0L, clasificacionClienteCount-1);
				clasificacionClienteFiltro.setOffset(clasificacionClienteIndex);
				clasificacionClienteFiltro.setLimit(clasificacionClienteIndex);
				List<ClasificacionCliente> clasificacionClienteListado = daoClasificacionCliente.find(clasificacionClienteFiltro);
				obj.setClasificacionCliente(clasificacionClienteListado.get(0));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}


}