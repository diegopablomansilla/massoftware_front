package com.massoftware.windows.cuentas_fondo;

import java.util.List;

public interface TiposBO {

//	public Tipo find(TipoFiltro filtro) throws Exception;

	// public List<Tipos> find(TiposFiltro filtro) throws Exception;
	//
	// public List<Tipos> find(int limit, int offset, Map<String, Boolean> orderBy,
	// TiposFiltro filtro) throws Exception;

	public List<Tipos> find() throws Exception;
	
	public List<Tipo> findAllTipo() throws Exception;

//	public List<Tipos> find(int limit, int offset, Map<String, Boolean> orderBy) throws Exception;
//
//	public Integer maxNumero() throws Exception;
//
//	public void checkUniqueNumero(String label, Integer numeroOriginal, Integer numero) throws Exception;
//
//	public void checkUniqueNombre(String label, String nombreOriginal, String nombre) throws Exception;
//
//	public void deleteItem(Tipos item) throws Exception;
//
//	public boolean insert(Tipo item) throws Exception;
//
//	public boolean update(Tipo itemOriginal, Tipo item) throws Exception;
}
