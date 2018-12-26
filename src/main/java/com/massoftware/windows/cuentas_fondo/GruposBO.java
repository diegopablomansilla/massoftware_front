package com.massoftware.windows.cuentas_fondo;

import java.util.List;
import java.util.Map;

public interface GruposBO {

	public Grupo find(GrupoFiltro filtro) throws Exception;

	public List<Grupos> find(GruposFiltro filtro) throws Exception;

	public List<Grupos> find(int limit, int offset, Map<String, Boolean> orderBy, GruposFiltro filtro) throws Exception;

	public Integer maxNumero(Integer numeroRubro) throws Exception;

	public void checkUniqueRubroAndNumero(String labelRubro, String labelNumero, Integer numeroRubroOriginal, Integer numeroRubro, Integer numeroOriginal, Integer numero) throws Exception;

	public void checkUniqueNombre(String label, String nombreOriginal, String nombre) throws Exception;

	public void deleteItem(Grupos item) throws Exception;

	public boolean insert(Grupo item) throws Exception;

	public boolean update(Grupo itemOriginal, Grupo item) throws Exception;
}
