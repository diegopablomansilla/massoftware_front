package com.massoftware.windows.cuentas_fondo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.cendra.ex.crud.InsertNullException;
import org.cendra.ex.crud.NullFieldException;
import org.cendra.ex.crud.UniqueException;

public class RubrosBOMockup implements RubrosBO {

	private List<Rubros> itemsMock;
	private List<Rubro> items2Mock;

	public RubrosBOMockup() throws Exception {
		itemsMock = mockData();
		items2Mock = mockData2();
	}

	private List<Rubros> mockData() throws Exception {

		List<Rubros> itemsMock = new ArrayList<Rubros>();

		for (int i = 1; i < 10 + 1; i++) {

			Rubros item = new Rubros();

			item.setNumero(i);
			item.setNombre("Nombre rubro " + i);

			itemsMock.add(item);
		}

		return itemsMock;
	}

	private List<Rubro> mockData2() throws Exception {

		List<Rubro> itemsMock = new ArrayList<Rubro>();

		for (int i = 1; i < 10 + 1; i++) {

			Rubro item = new Rubro();

			item.setNumero(i);
			item.setNombre("Nombre rubro " + i);

			itemsMock.add(item);
		}

		return itemsMock;
	}

	public Rubro find(RubroFiltro filtro) throws Exception {

		for (Rubro item : items2Mock) {
			if (filtro.getNumero().equals(item.getNumero())) {
				return item.clone();
			}
		}

		return null;
	}

	public List<Rubros> find() throws Exception {
		return find(-1, -1, null);
	}

	public List<Rubros> find(int limit, int offset, Map<String, Boolean> orderBy) throws Exception {

		ArrayList<Rubros> arrayList = new ArrayList<Rubros>();

		for (Rubros item : itemsMock) {
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
	
	public List<Rubro> findAllRubro() throws Exception {
		return findAllRubro(-1, -1, null);
	}

	private List<Rubro> findAllRubro(int limit, int offset, Map<String, Boolean> orderBy) throws Exception {

		ArrayList<Rubro> arrayList = new ArrayList<Rubro>();

		for (Rubro item : items2Mock) {
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

	public Integer maxNumero() throws Exception {

		return items2Mock.size() + 1;
	}

	public void checkUniqueNumero(String label, Integer numeroOriginal, Integer numero) throws Exception {

		if (numeroOriginal != null && numeroOriginal.equals(numero) == false) {

			for (Rubro item : items2Mock) {
				if (numero.equals(item.getNumero())) {
					throw new UniqueException(label);
				}
			}

		} else if (numeroOriginal == null) {
			for (Rubro item : items2Mock) {
				if (numero.equals(item.getNumero())) {
					throw new UniqueException(label);
				}
			}
		}

	}

	public void checkUniqueNombre(String label, String nombreOriginal, String nombre) throws Exception {

		if (nombreOriginal != null && nombreOriginal.equals(nombre) == false) {

			for (Rubro item : items2Mock) {
				if (nombre.equals(item.getNombre())) {
					throw new UniqueException(label);
				}
			}

		} else if (nombreOriginal == null) {
			for (Rubro item : items2Mock) {
				if (nombre.equals(item.getNombre())) {
					throw new UniqueException(label);
				}
			}
		}

	}

	public void deleteItem(Rubros item) throws Exception {
		for (int i = 0; i < itemsMock.size(); i++) {
			if (itemsMock.get(i).getNumero().equals(item.getNumero())) {
				itemsMock.remove(i);
				items2Mock.remove(i);

				return;
			}
		}
	}

	public boolean insert(Rubro item) throws Exception {

		// ==================================================================
		// CHECKs NULLs

		if (item == null) {
			throw new InsertNullException("Banco");
		}
		if (item.getNumero() == null) {
			throw new NullFieldException("Numero");
		}
		if (item.getNombre() == null) {
			throw new NullFieldException("Nombre");
		}

		// ==================================================================
		// CHECKs UNIQUE

		checkUniqueNumero("Numero", null, item.getNumero());
		checkUniqueNombre("Nombre", null, item.getNombre());

		// ==================================================================
		// INSERT

		Rubros rubros = new Rubros();
		rubros.setNumero(item.getNumero());
		rubros.setNombre(item.getNombre());

		itemsMock.add(rubros);
		items2Mock.add(item);
		Collections.sort(itemsMock);
		Collections.sort(items2Mock);

		return true;
	}

	public boolean update(Rubro itemOriginal, Rubro item) throws Exception {

		// ==================================================================
		// CHECKs NULLs

		if (item == null) {
			throw new InsertNullException("Numero");
		}
		if (item.getNumero() == null) {
			throw new NullFieldException("Numero");
		}
		if (item.getNombre() == null) {
			throw new NullFieldException("Nombre");
		}

		// ==================================================================
		// CHECKs UNIQUE

		checkUniqueNumero("Numero", itemOriginal.getNumero(), item.getNumero());
		checkUniqueNombre("Nombre", itemOriginal.getNombre(), item.getNombre());

		// ==================================================================
		// UPDATE

		Rubros rubros = new Rubros();
		rubros.setNumero(item.getNumero());
		rubros.setNombre(item.getNombre());

		for (int i = 0; i < itemsMock.size(); i++) {
			if (itemsMock.get(i).getNumero().equals(item.getNumero())) {
				itemsMock.remove(i);
				items2Mock.remove(i);
			}
		}

		itemsMock.add(rubros);
		items2Mock.add(item);
		Collections.sort(itemsMock);
		Collections.sort(items2Mock);

		return true;
	}

}
