package com.massoftware.service.geo;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.UtilNumeric;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.model.geo.Provincia;

public class CiudadServiceCustom extends CiudadService {

	public List<Ciudad> findByNumeroOrNombre(Provincia provincia, String arg) throws Exception {

		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Ciudad.numero o Ciudad.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		// ------------ buscar por Nº ciudad

		if (UtilNumeric.isInteger(arg)) {

			CiudadFiltro filtroNumero = new CiudadFiltro();

			filtroNumero.setProvincia(provincia);

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Ciudad> listadoNumero = find(filtroNumero);

			if (listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}

		// ------------ buscar por Nombre

		CiudadFiltro filtroNombre = new CiudadFiltro();

		filtroNombre.setProvincia(provincia);

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Ciudad> listadoNombre = find(filtroNombre);

		if (listadoNombre.size() > 0) {

			return listadoNombre;

		}

		return new ArrayList<Ciudad>();

	}

} // END CLASS
	// ----------------------------------------------------------------------------------------------------------