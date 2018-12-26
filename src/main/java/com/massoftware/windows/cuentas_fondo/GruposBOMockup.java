package com.massoftware.windows.cuentas_fondo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.cendra.ex.crud.InsertNullException;
import org.cendra.ex.crud.NullFieldException;
import org.cendra.ex.crud.UniqueException;

public class GruposBOMockup implements GruposBO {

	private List<Grupos> itemsMock;
	private List<Grupo> items2Mock;

	public GruposBOMockup() throws Exception {
		itemsMock = mockData();
		items2Mock = mockData2();
	}

	private List<Grupos> mockData() throws Exception {

		List<Grupos> itemsMock = new ArrayList<Grupos>();

		int c = 1;
		int rubro = 1;

		for (int i = 1; i < 100 + 1; i++) {

			Grupos item = new Grupos();

			item.setNumero(i);
			item.setNombre("Nombre grupo " + i);
			item.setNumeroRubro(rubro);

			c++;
			if (c > 10) {
				c = 1;
				rubro++;

			}

			itemsMock.add(item);
		}

		return itemsMock;
	}

	private List<Grupo> mockData2() throws Exception {

		List<Grupo> itemsMock = new ArrayList<Grupo>();

		int c = 1;
		int rubroNumero = 1;

		for (int i = 1; i < 100 + 1; i++) {

			Grupo item = new Grupo();

			Rubro rubro = new Rubro();
			rubro.setNumero(rubroNumero);

			item.setNumero(i);
			item.setNombre("Nombre grupo " + i);
			item.setRubro(rubro);

			c++;
			if (c > 10) {
				c = 1;
				rubroNumero++;

			}

			itemsMock.add(item);
		}

		return itemsMock;
	}

	public Grupo find(GrupoFiltro filtro) throws Exception {

		for (Grupo item : items2Mock) {
			if (filtro.getNumero().equals(item.getNumero())) {
				return item.clone();
			}
		}

		return null;
	}

	public List<Grupos> find(GruposFiltro filtro) throws Exception {
		return find(-1, -1, null, filtro);
	}

	public List<Grupos> find(int limit, int offset, Map<String, Boolean> orderBy, GruposFiltro filtro)
			throws Exception {

		ArrayList<Grupos> arrayList = new ArrayList<Grupos>();

		for (Grupos item : itemsMock) {

			boolean passesFilterNumero = (filtro.getNumero() == null || item.getNumero().equals(filtro.getNumero()));

			boolean passesFilterNombre = false;

			if (filtro.getNombre() != null) {

				String[] palabras = filtro.getNombre().split(" ");

				boolean passesFilter = false;

				for (String palabra : palabras) {
					passesFilter = item.getNombre().toLowerCase().contains(palabra.trim().toLowerCase());
					if (passesFilter == false) {
						break;
					}
				}

				passesFilterNombre = passesFilter;
			} else {
				passesFilterNombre = true;
			}

			boolean passesFilterNumeroRubro = (filtro.getNumeroRubro() == null
					|| item.getNumeroRubro().equals(filtro.getNumeroRubro()));

			if (passesFilterNumero && passesFilterNombre && passesFilterNumeroRubro) {
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

	public Integer maxNumero(Integer numeroRubro) throws Exception {

		int c = 0;
		for (Grupo grupo : items2Mock) {
			if (grupo.getRubro().getNumero().equals(numeroRubro)) {
				c++;
			}
		}

		return c + 1;
	}

	public void checkUniqueRubroAndNumero(String labelRubro, String labelNumero, Integer numeroRubroOriginal,
			Integer numeroRubro, Integer numeroOriginal, Integer numero) throws Exception {

		if(numeroRubro == null) {
			numeroRubro = -1;
		}
		
		if (numeroRubroOriginal != null && numeroRubroOriginal.equals(numeroRubro) == false && numeroOriginal != null
				&& numeroOriginal.equals(numero) == false) {

			for (Grupo item : items2Mock) {			
				if (numeroRubro.equals(item.getRubro().getNumero()) && numero.equals(item.getNumero())) {
					throw new UniqueException(labelRubro, labelNumero);
				}
			}

		} else if (numeroRubroOriginal == null && numeroOriginal == null) {
			for (Grupo item : items2Mock) {
				if (numeroRubro.equals(item.getRubro().getNumero()) && numero.equals(item.getNumero())) {
					throw new UniqueException(labelRubro, labelNumero);
				}
			}
		}

	}

	public void checkUniqueNombre(String label, String nombreOriginal, String nombre) throws Exception {

		if (nombreOriginal != null && nombreOriginal.equals(nombre) == false) {

			for (Grupo item : items2Mock) {
				if (nombre.equals(item.getNombre())) {
					throw new UniqueException(label);
				}
			}

		} else if (nombreOriginal == null) {
			for (Grupo item : items2Mock) {
				if (nombre.equals(item.getNombre())) {
					throw new UniqueException(label);
				}
			}
		}

	}

	public void deleteItem(Grupos item) throws Exception {
		for (int i = 0; i < itemsMock.size(); i++) {

			if (itemsMock.get(i).getNumeroRubro().equals(item.getNumeroRubro())
					&& itemsMock.get(i).getNumero().equals(item.getNumero())) {
				itemsMock.remove(i);
				items2Mock.remove(i);

				return;
			}
		}
	}

	public boolean insert(Grupo item) throws Exception {

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
		if (item.getRubro() == null) {
			throw new NullFieldException("Rubro");
		}
		if (item.getRubro().getNumero() == null) {
			throw new NullFieldException("Rubro");
		}

		// ==================================================================
		// CHECKs UNIQUE

		checkUniqueRubroAndNumero("Rubro", "Numero", null, item.getRubro().getNumero(), null, item.getNumero());
		checkUniqueNombre("Nombre", null, item.getNombre());

		// ==================================================================
		// INSERT

		Grupos grupos = new Grupos();
		grupos.setNumero(item.getNumero());
		grupos.setNombre(item.getNombre());
		grupos.setNumeroRubro(item.getRubro().getNumero());

		itemsMock.add(grupos);
		items2Mock.add(item);
		Collections.sort(itemsMock);
		Collections.sort(items2Mock);
		
		return true;
	}

	public boolean update(Grupo itemOriginal, Grupo item) throws Exception {

		// ==================================================================
		// CHECKs NULLs

		if (item == null) {
			throw new InsertNullException("Grupo");
		}
		if (item.getNumero() == null) {
			throw new NullFieldException("Numero");
		}
		if (item.getNombre() == null) {
			throw new NullFieldException("Nombre");
		}
		if (item.getRubro() == null) {
			throw new NullFieldException("Rubro");
		}
		if (item.getRubro().getNumero() == null) {
			throw new NullFieldException("Rubro");
		}

		// ==================================================================
		// CHECKs UNIQUE

		checkUniqueRubroAndNumero("Rubro", "Numero", itemOriginal.getRubro().getNumero(), item.getRubro().getNumero(),
				itemOriginal.getNumero(), item.getNumero());
		checkUniqueNombre("Nombre", itemOriginal.getNombre(), item.getNombre());

		// ==================================================================
		// UPDATE

		Grupos grupos = new Grupos();
		grupos.setNumero(item.getNumero());
		grupos.setNombre(item.getNombre());
		grupos.setNumeroRubro(item.getRubro().getNumero());

		for (int i = 0; i < itemsMock.size(); i++) {
			if (itemsMock.get(i).getNumero().equals(item.getNumero())) {
				itemsMock.remove(i);
				items2Mock.remove(i);
			}
		}
		itemsMock.add(grupos);
		items2Mock.add(item);
		Collections.sort(itemsMock);
		Collections.sort(items2Mock);

		return true;
	}

}
