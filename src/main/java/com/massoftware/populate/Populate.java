package com.massoftware.populate;
import java.util.List;
import java.util.Random;

import com.massoftware.model.monedas.MonedaAFIP;
import com.massoftware.dao.monedas.MonedaAFIPFiltro;
import com.massoftware.dao.monedas.MonedaAFIPDAO;
import com.massoftware.model.monedas.Moneda;
import com.massoftware.dao.monedas.MonedaFiltro;
import com.massoftware.dao.monedas.MonedaDAO;

public class Populate {

	static int maxRows = 10000;

	public static void main(String[] args) {
		try {
			insertMonedaAFIP();
		} catch (Exception e) {}
		try {
			insertMoneda();
		} catch (Exception e) {}
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

				obj.setCotizacion(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true));

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