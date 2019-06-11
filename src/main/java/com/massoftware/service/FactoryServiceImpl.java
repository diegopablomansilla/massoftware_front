package com.massoftware.service;

import com.massoftware.service.geo.CiudadService;
import com.massoftware.service.geo.CiudadServiceCustom;
import com.massoftware.service.geo.ProvinciaService;
import com.massoftware.service.geo.ProvinciaServiceCustom;

public class FactoryServiceImpl extends AbstractFactoryService {
	
	public ProvinciaService buildProvinciaService() throws Exception {
		return new ProvinciaServiceCustom();
	}

	public CiudadService buildCiudadService() throws Exception {
		return new CiudadServiceCustom();
	}

}
