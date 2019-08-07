package com.massoftware.service.geo;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.model.geo.Pais;
import com.massoftware.model.geo.Provincia;
import com.massoftware.service.UtilNumeric;

public class ProvinciaServiceCustom extends ProvinciaService {

	// ---------------------------------------------------------------------------------------------------------------------------

	public List<Provincia> findByNumeroOrNombre(Pais pais, String arg) throws Exception {

		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException(
					"Se esperaba un arg (Provincia.numero o Provincia.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		// ------------ buscar por Nº provincia

		if (UtilNumeric.isInteger(arg)) {

			ProvinciaFiltro filtroNumero = new ProvinciaFiltro();
			
			filtroNumero.setPais(pais);

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Provincia> listadoNumero = find(filtroNumero);

			if (listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}

		// ------------ buscar por Nombre

		ProvinciaFiltro filtroNombre = new ProvinciaFiltro();
		
		filtroNombre.setPais(pais);

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Provincia> listadoNombre = find(filtroNombre);

		if (listadoNombre.size() > 0) {

			return listadoNombre;

		}

		return new ArrayList<Provincia>();

	}

} // END CLASS
	// ----------------------------------------------------------------------------------------------------------