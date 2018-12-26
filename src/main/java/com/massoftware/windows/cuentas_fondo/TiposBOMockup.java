package com.massoftware.windows.cuentas_fondo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class TiposBOMockup implements TiposBO {

	private List<Tipos> itemsMock;
	private List<Tipo> items2Mock;

	public TiposBOMockup() throws Exception {
		itemsMock = mockData();
		items2Mock = mockData2();
	}

	private List<Tipos> mockData() throws Exception {

		List<Tipos> itemsMock = new ArrayList<Tipos>();

		for (int i = 1; i < 10 + 1; i++) {

			Tipos item = new Tipos();

			item.setNumero(i);
			item.setNombre("Nombre rubro " + i);

			itemsMock.add(item);
		}

		return itemsMock;
	}

	private List<Tipo> mockData2() throws Exception {

		List<Tipo> itemsMock = new ArrayList<Tipo>();

		for (int i = 1; i < 10 + 1; i++) {

			Tipo item = new Tipo();

			item.setNumero(i);
			item.setNombre("Nombre rubro " + i);

			itemsMock.add(item);
		}

		return itemsMock;
	}

	public List<Tipos> find() throws Exception {
		return find(-1, -1, null);
	}

	public List<Tipos> find(int limit, int offset, Map<String, Boolean> orderBy) throws Exception {

		ArrayList<Tipos> arrayList = new ArrayList<Tipos>();

		for (Tipos item : itemsMock) {
			arrayList.add(item);
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

	public List<Tipo> findAllTipo() throws Exception {
		return findAllTipo(-1, -1, null);
	}

	private List<Tipo> findAllTipo(int limit, int offset, Map<String, Boolean> orderBy) throws Exception {

		ArrayList<Tipo> arrayList = new ArrayList<Tipo>();

		for (Tipo item : items2Mock) {
			arrayList.add(item);
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
