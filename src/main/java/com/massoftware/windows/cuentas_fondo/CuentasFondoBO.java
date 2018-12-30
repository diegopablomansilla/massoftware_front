package com.massoftware.windows.cuentas_fondo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.cuentas_fondo.rubros.Rubros;

class CuentasFondoBO {

	List<CuentasFondo> itemsMock = mockData();
	List<Rubros> itemsRubroMock = mockDataRubro();

	private List<CuentasFondo> mockData() {

		List<CuentasFondo> itemsMock = new ArrayList<CuentasFondo>();

		for (int i = 0; i < 100000; i++) {

			CuentasFondo item = new CuentasFondo();

			item.setNumeroRubro(i);
			item.setNumeroGrupo(i);
			item.setNumero(i);
			item.setNombre("Nombre " + i);
			item.setTipo("Tipo " + i);
			item.setNumeroBanco(i);
			item.setBloqueado(i % 2 == 0);

			itemsMock.add(item);
		}

		return itemsMock;
	}

	private List<Rubros> mockDataRubro() {

		List<Rubros> itemsMock = new ArrayList<Rubros>();

		for (int i = 0; i < Short.MAX_VALUE; i++) {

			Rubros item = new Rubros();

			item.setNumero(i);
			item.setNombre("Nombre " + i);

			itemsMock.add(item);
		}

		return itemsMock;
	}

	public List<CuentasFondo> find(int limit, int offset, Map<String, Boolean> orderBy, CuentasFondoFiltro filtro) {

		ArrayList<CuentasFondo> arrayList = new ArrayList<CuentasFondo>();

		for (CuentasFondo item : itemsMock) {

			boolean passesFilterNumeroRubro = (filtro.getNumeroRubro() == null
					|| item.getNumeroRubro().equals(filtro.getNumeroRubro()));

			boolean passesFilterNumeroGrupo = (filtro.getNumeroGrupo() == null
					|| item.getNumeroGrupo().equals(filtro.getNumeroGrupo()));

			boolean passesFilterNumeroBanco = (filtro.getNumeroBanco() == null
					|| item.getNumeroBanco().equals(filtro.getNumeroBanco()));

			boolean passesFilterNumero = (filtro.getNumero() == null || item.getNumero().equals(filtro.getNumero()));

			boolean passesFilterNombre = (filtro.getNombre() == null
					|| item.getNombre().toLowerCase().contains(filtro.getNombre().toLowerCase()));

			boolean passesFilterBloqueado = (filtro.getBloqueado() == null || filtro.getBloqueado() == 0
					|| (item.getBloqueado().equals(true) && filtro.getBloqueado().equals(1))
					|| (item.getBloqueado().equals(false) && filtro.getBloqueado().equals(2)));

			if (passesFilterNumeroRubro && passesFilterNumeroGrupo && passesFilterNumeroBanco && passesFilterNumero
					&& passesFilterNombre && passesFilterBloqueado) {

				arrayList.add(item);
			}
		}

		if (offset == -1 && limit == -1) {
			return arrayList;
		}

		int end = offset + limit;
		if (end > arrayList.size()) {
			String msg = "* LIMIT = " + limit + ", OFFSET = " + offset + ", END = " + end + "\nFILTROS = " + filtro;
			System.out.println("================================================================");
			System.out.println(msg);
			System.out.println("================================================================");
			return arrayList.subList(0, arrayList.size());
		}

		String msg = "+ LIMIT = " + limit + ", OFFSET = " + offset + ", END = " + end + "\nFILTROS = " + filtro;
		System.out.println("================================================================");
		System.out.println(msg);
		System.out.println("================================================================");

		return arrayList.subList(offset, end);
	}

	public void deleteItem(CuentasFondo item) {
		try {

			for (int i = 0; i < itemsMock.size(); i++) {
				if (itemsMock.get(i).getNumero().equals(item.getNumero())) {
					itemsMock.remove(i);
					return;
				}
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

}
