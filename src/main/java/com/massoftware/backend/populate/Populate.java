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

		for(int i = 0; i < maxRows; i++){

			try {

				Provincia obj = new Provincia();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				obj.setNumeroAFIP(UtilPopulate.getIntegerRandom(1, null, false));

				obj.setNumeroIngresosBrutos(UtilPopulate.getIntegerRandom(1, null, false));

				obj.setNumeroRENATEA(UtilPopulate.getIntegerRandom(1, null, false));

				PaisDAO daoPais = new PaisDAO();
				PaisFiltro filtro = new PaisFiltro();
				Long count = daoPais.count();
				long index = UtilPopulate.getLongRandom(0L, count-1);
				filtro.setOffset(index);
				filtro.setLimit(index);
				List<Pais> listado = daoPais.find(filtro);
				obj.setPais(listado.get(0));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertCiudad() throws Exception {

		CiudadDAO dao = new CiudadDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				Ciudad obj = new Ciudad();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setDepartamento(UtilPopulate.getStringRandom(null, 50, false));

				obj.setNumeroAFIP(UtilPopulate.getIntegerRandom(1, null, false));

				ProvinciaDAO daoProvincia = new ProvinciaDAO();
				ProvinciaFiltro filtro = new ProvinciaFiltro();
				Long count = daoProvincia.count();
				long index = UtilPopulate.getLongRandom(0L, count-1);
				filtro.setOffset(index);
				filtro.setLimit(index);
				List<Provincia> listado = daoProvincia.find(filtro);
				obj.setProvincia(listado.get(0));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertCodigoPostal() throws Exception {

		CodigoPostalDAO dao = new CodigoPostalDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				CodigoPostal obj = new CodigoPostal();

				obj.setCodigo(UtilPopulate.getStringRandom(null, 12, true));

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombreCalle(UtilPopulate.getStringRandom(null, 200, true));

				obj.setNumeroCalle(UtilPopulate.getStringRandom(null, 20, true));

				CiudadDAO daoCiudad = new CiudadDAO();
				CiudadFiltro filtro = new CiudadFiltro();
				Long count = daoCiudad.count();
				long index = UtilPopulate.getLongRandom(0L, count-1);
				filtro.setOffset(index);
				filtro.setLimit(index);
				List<Ciudad> listado = daoCiudad.find(filtro);
				obj.setCiudad(listado.get(0));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}



	public static void insertTransporte() throws Exception {

		TransporteDAO dao = new TransporteDAO();

		for(int i = 0; i < maxRows; i++){

			try {

				Transporte obj = new Transporte();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setCuit(UtilPopulate.getLongRandom(1L, 99999999999L, true));

				obj.setIngresosBrutos(UtilPopulate.getStringRandom(null, 13, false));

				obj.setTelefono(UtilPopulate.getStringRandom(null, 50, false));

				obj.setFax(UtilPopulate.getStringRandom(null, 50, false));

				CodigoPostalDAO daoCodigoPostal = new CodigoPostalDAO();
				CodigoPostalFiltro filtro = new CodigoPostalFiltro();
				Long count = daoCodigoPostal.count();
				long index = UtilPopulate.getLongRandom(0L, count-1);
				filtro.setOffset(index);
				filtro.setLimit(index);
				List<CodigoPostal> listado = daoCodigoPostal.find(filtro);
				obj.setCodigoPostal(listado.get(0));

				obj.setDomicilio(UtilPopulate.getStringRandom(null, 150, false));

				obj.setComentario(UtilPopulate.getStringRandom(null, 300, false));

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

		for(int i = 0; i < maxRows; i++){

			try {

				Moneda obj = new Moneda();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				obj.setCotizacion(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setCotizacionFecha(new java.sql.Timestamp(UtilPopulate.getDateRandom(2000, 2019, true)));

				obj.setControlActualizacion(new Random().nextBoolean());

				MonedaAFIPDAO daoMonedaAFIP = new MonedaAFIPDAO();
				MonedaAFIPFiltro filtro = new MonedaAFIPFiltro();
				Long count = daoMonedaAFIP.count();
				long index = UtilPopulate.getLongRandom(0L, count-1);
				filtro.setOffset(index);
				filtro.setLimit(index);
				List<MonedaAFIP> listado = daoMonedaAFIP.find(filtro);
				obj.setMonedaAFIP(listado.get(0));

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

		for(int i = 0; i < maxRows; i++){

			try {

				MotivoBloqueoCliente obj = new MotivoBloqueoCliente();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				ClasificacionClienteDAO daoClasificacionCliente = new ClasificacionClienteDAO();
				ClasificacionClienteFiltro filtro = new ClasificacionClienteFiltro();
				Long count = daoClasificacionCliente.count();
				long index = UtilPopulate.getLongRandom(0L, count-1);
				filtro.setOffset(index);
				filtro.setLimit(index);
				List<ClasificacionCliente> listado = daoClasificacionCliente.find(filtro);
				obj.setClasificacionCliente(listado.get(0));

				dao.insert(obj);

			} catch (Exception e) {}

		}

	}


}