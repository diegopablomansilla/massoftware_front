package com.massoftware.windows.cuentas_fondo;

import java.util.List;
import java.util.Map;

import com.massoftware.windows.cuentas_fondo.rubros.Rubros;

public interface IRubrosBO {

	public Rubro find(RubroFiltro filtro) throws Exception;

	// public List<Rubros> find(RubrosFiltro filtro) throws Exception;
	//
	// public List<Rubros> find(int limit, int offset, Map<String, Boolean> orderBy,
	// RubrosFiltro filtro) throws Exception;

	public List<Rubros> find() throws Exception;
	
	public List<Rubro> findAllRubro() throws Exception;

	public List<Rubros> find(int limit, int offset, Map<String, Boolean> orderBy) throws Exception;

	public Integer maxNumero() throws Exception;

	public void checkUniqueNumero(String label, Integer numeroOriginal, Integer numero) throws Exception;

	public void checkUniqueNombre(String label, String nombreOriginal, String nombre) throws Exception;

	public void deleteItem(Rubros item) throws Exception;

	public boolean insert(Rubro item) throws Exception;

	public boolean update(Rubro itemOriginal, Rubro item) throws Exception;
}
