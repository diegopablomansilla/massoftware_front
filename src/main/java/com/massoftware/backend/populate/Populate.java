package com.massoftware.backend.populate;
import java.util.List;
import java.util.Random;

import com.massoftware.model.seguridad.Usuario;
import com.massoftware.dao.seguridad.UsuarioFiltro;
import com.massoftware.dao.seguridad.UsuarioDAO;
import com.massoftware.model.geo.Pais;
import com.massoftware.dao.geo.PaisFiltro;
import com.massoftware.dao.geo.PaisDAO;
import com.massoftware.model.geo.Provincia;
import com.massoftware.dao.geo.ProvinciaFiltro;
import com.massoftware.dao.geo.ProvinciaDAO;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.dao.geo.CiudadFiltro;
import com.massoftware.dao.geo.CiudadDAO;
import com.massoftware.model.monedas.MonedaAFIP;
import com.massoftware.dao.monedas.MonedaAFIPFiltro;
import com.massoftware.dao.monedas.MonedaAFIPDAO;
import com.massoftware.model.monedas.Moneda;
import com.massoftware.dao.monedas.MonedaFiltro;
import com.massoftware.dao.monedas.MonedaDAO;

public class Populate {

	static int maxRows = 1000;

	public static void main(String[] args) {
		try {
			insertUsuario();
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
			insertMonedaAFIP();
		} catch (Exception e) {}
		try {
			insertMoneda();
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


}