package com.massoftware;

import com.massoftware.windows.cuentas_fondo.GruposBO;
import com.massoftware.windows.cuentas_fondo.GruposBOMockup;
import com.massoftware.windows.cuentas_fondo.IRubrosBO;
import com.massoftware.windows.cuentas_fondo.RubrosBOMockup;

public class Context {

	// ------------------------------------------------------------------------

	private static IRubrosBO rubrosBO;
	private static GruposBO gruposBO;

	public static IRubrosBO getRubrosBO() throws Exception {
		if (rubrosBO == null) {
			rubrosBO = new RubrosBOMockup();
		}

		return rubrosBO;
	}

	public static GruposBO getGruposBO() throws Exception {
		if (gruposBO == null) {
			gruposBO = new GruposBOMockup();
		}

		return gruposBO;
	}

}
