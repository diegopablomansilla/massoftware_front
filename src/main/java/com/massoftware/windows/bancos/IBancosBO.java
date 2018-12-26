package com.massoftware.windows.bancos;

import java.util.List;
import java.util.Map;

public interface IBancosBO {	

//	public Banco find(BancoFiltro filtro) throws Exception;

	public List<Bancos> find(BancosFiltro filtro) throws Exception;

	public List<Bancos> find(int limit, int offset, Map<String, Boolean> orderBy, BancosFiltro filtro) throws Exception;

	public Integer maxNumero() throws Exception;

	public void checkUniqueNumero(String label, Integer numeroOriginal, Integer numero) throws Exception;

	public void checkUniqueNombre(String label, String nombreOriginal, String nombre) throws Exception;

	public void checkUniqueNombreOficial(String label, String nombreOficialOriginal, String nombreOficial)
			throws Exception;

	public void checkUniqueCuit(String label, String cuitOriginal, String cuit) throws Exception;

	public void deleteItem(Bancos item) throws Exception;

//	public boolean insert(Banco item) throws Exception;
//
//	public boolean update(Banco itemOriginal, Banco item) throws Exception;
}
