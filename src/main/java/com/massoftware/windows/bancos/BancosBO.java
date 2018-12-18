package com.massoftware.windows.bancos;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class BancosBO {

	List<Bancos> itemsMock = mockData();

	private List<Bancos> mockData() {

		List<Bancos> itemsMock = new ArrayList<Bancos>();

		for (int i = 0; i < 10000; i++) {

			Bancos item = new Bancos();

			item.setNumero(i);
			item.setNombre("Nombre " + i);
			item.setNombreOficial("Nombre Oficial " + i);
			item.setBloqueado(i % 2 == 0);

			itemsMock.add(item);
		}

		return itemsMock;
	}

	public List<Bancos> find(BancosFiltro filtro) {
		return find(-1, -1, null, filtro);
	}

	public List<Bancos> find(int limit, int offset, Map<String, Boolean> orderBy, BancosFiltro filtro) {

		ArrayList<Bancos> arrayList = new ArrayList<Bancos>();

		for (Bancos item : itemsMock) {

			boolean passesFilterNumero = (filtro.getNumero() == null || item.getNumero().equals(filtro.getNumero()));

			boolean passesFilterNombre = (filtro.getNombre() == null
					|| item.getNombre().toLowerCase().contains(filtro.getNombre().toLowerCase()));

			boolean passesFilterNombreOficial = (filtro.getNombreOficial() == null
					|| item.getNombreOficial().toLowerCase().contains(filtro.getNombreOficial().toLowerCase()));

			boolean passesFilterBloqueado = (filtro.getBloqueado() == null || filtro.getBloqueado() == 0
					|| (item.getBloqueado().equals(true) && filtro.getBloqueado().equals(1))
					|| (item.getBloqueado().equals(false) && filtro.getBloqueado().equals(2)));

			if (passesFilterNumero && passesFilterNombre && passesFilterNombreOficial && passesFilterBloqueado) {
				arrayList.add(item);
			}
		}

		if (offset == -1 && limit == -1) {
			return arrayList;
		}

		int end = offset + limit;
		if (end > arrayList.size()) {
			return arrayList.subList(0, arrayList.size());
		}

		return arrayList.subList(offset, end);
	}

}
