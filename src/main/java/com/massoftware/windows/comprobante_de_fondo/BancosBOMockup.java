package com.massoftware.windows.comprobante_de_fondo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.massoftware.windows.bancos.Bancos;
import com.massoftware.windows.bancos.BancosFiltro;

class BancosBOMockup implements IBancosBO {

	private List<Bancos> itemsMock;
//	private List<Banco> items2Mock;

	public BancosBOMockup() throws Exception {
		itemsMock = mockData();
//		items2Mock = mockData2();
	}

	private List<Bancos> mockData() throws Exception {

		List<Bancos> itemsMock = new ArrayList<Bancos>();

		for (int i = 1; i < Short.MAX_VALUE + 1; i++) {

			Bancos item = new Bancos();

			item.setNumero(i);
			item.setNombre("Nombre " + i);			
			item.setBloqueado(i % 2 == 0);

			itemsMock.add(item);
		}

		return itemsMock;
	}

//	private List<Banco> mockData2() throws Exception {
//
//		List<Banco> itemsMock = new ArrayList<Banco>();
//
//		for (int i = 1; i < Short.MAX_VALUE + 1; i++) {
//
//			Banco item = new Banco();
//
//			item.setNumero(i);
//			item.setNombre("Nombre " + i);
//			item.setNombreOficial("Nombre Oficial " + i);
//			item.setBloqueado(i % 2 == 0);
//			item.setCuit("" + i + i + i + i + i + i + i + i + i + i + i + i);
//			item.setHoja(255);
//			item.setPrimeraFila(i);
//			item.setUltimaFila(i);
//			item.setFecha("AAA");
//			item.setDescripcion("BBB");
//			item.setReferencia1("CCC");
//			item.setImporte("DDD");
//			item.setReferencia2("EEE");
//			item.setSaldo("FFF");
//
//			itemsMock.add(item);
//		}
//
//		return itemsMock;
//	}
//
//	public Banco find(BancoFiltro filtro) throws Exception {
//
//		for (Banco item : items2Mock) {
//			if (filtro.getNumero().equals(item.getNumero())) {
//				return item.clone();
//			}
//		}
//
//		return null;
//	}

	public List<Bancos> find(BancosFiltro filtro) throws Exception {
		return find(-1, -1, null, filtro);
	}

	public List<Bancos> find(int limit, int offset, Map<String, Boolean> orderBy, BancosFiltro filtro)
			throws Exception {

		ArrayList<Bancos> arrayList = new ArrayList<Bancos>();

		for (Bancos item : itemsMock) {

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

			// boolean passesFilterNombre = (filtro.getNombre() == null
			// ||
			// item.getNombre().toLowerCase().contains(filtro.getNombre().toLowerCase()));

			

			

			// boolean passesFilterNombreOficial = (filtro.getNombreOficial() == null
			// ||
			// item.getNombreOficial().toLowerCase().contains(filtro.getNombreOficial().toLowerCase()));

			boolean passesFilterBloqueado = (filtro.getBloqueado() == null || filtro.getBloqueado() == 0
					|| (item.getBloqueado().equals(true) && filtro.getBloqueado().equals(1))
					|| (item.getBloqueado().equals(false) && filtro.getBloqueado().equals(2)));

			if (passesFilterNumero && passesFilterNombre && passesFilterBloqueado) {
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
/*
	public Integer maxNumero() throws Exception {

		return items2Mock.size() + 1;
	}

	public void checkUniqueNumero(String label, Integer numeroOriginal, Integer numero) throws Exception {

		if (numeroOriginal != null && numeroOriginal.equals(numero) == false) {

			for (Banco item : items2Mock) {
				if (numero.equals(item.getNumero())) {
					throw new UniqueException(label);
				}
			}

		} else if (numeroOriginal == null) {
			for (Banco item : items2Mock) {
				if (numero.equals(item.getNumero())) {
					throw new UniqueException(label);
				}
			}
		}

	}

	public void checkUniqueNombre(String label, String nombreOriginal, String nombre) throws Exception {

		if (nombreOriginal != null && nombreOriginal.equals(nombre) == false) {

			for (Banco item : items2Mock) {
				if (nombre.equals(item.getNombre())) {
					throw new UniqueException(label);
				}
			}

		} else if (nombreOriginal == null) {
			for (Banco item : items2Mock) {
				if (nombre.equals(item.getNombre())) {
					throw new UniqueException(label);
				}
			}
		}

	}

	public void checkUniqueNombreOficial(String label, String nombreOficialOriginal, String nombreOficial)
			throws Exception {

		if (nombreOficialOriginal != null && nombreOficialOriginal.equals(nombreOficial) == false) {

			for (Banco item : items2Mock) {
				if (nombreOficial.equals(item.getNombreOficial())) {
					throw new UniqueException(label);
				}
			}

		} else if (nombreOficialOriginal == null) {
			for (Banco item : items2Mock) {
				if (nombreOficial.equals(item.getNombreOficial())) {
					throw new UniqueException(label);
				}
			}
		}

	}

	public void checkUniqueCuit(String label, String cuitOriginal, String cuit) throws Exception {

		if (cuitOriginal != null && cuitOriginal.equals(cuit) == false) {

			for (Banco item : items2Mock) {
				if (cuit.equals(item.getCuit())) {
					throw new UniqueException(label);
				}
			}

		} else if (cuitOriginal == null) {
			for (Banco item : items2Mock) {
				if (cuit.equals(item.getCuit())) {
					throw new UniqueException(label);
				}
			}
		}

	}

	public void deleteItem(Bancos item) throws Exception {
		for (int i = 0; i < itemsMock.size(); i++) {
			if (itemsMock.get(i).getNumero().equals(item.getNumero())) {
				itemsMock.remove(i);
				items2Mock.remove(i);

				return;
			}
		}
	}

	public boolean insert(Banco item) throws Exception {

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
		if (item.getNombreOficial() == null) {
			throw new NullFieldException("Nombre oficial");
		}
		if (item.getCuit() == null) {
			throw new NullFieldException("CUIT");
		}

		// ==================================================================
		// CHECKs UNIQUE

		checkUniqueNumero("Numero", null, item.getNumero());
		checkUniqueNombre("Nombre", null, item.getNombre());
		checkUniqueNombreOficial("Nombre oficial", null, item.getNombreOficial());
		checkUniqueCuit("CUIT", null, item.getCuit());

		// ==================================================================
		// INSERT

		Bancos bancos = new Bancos();
		bancos.setNumero(item.getNumero());
		bancos.setNombre(item.getNombre());
		bancos.setNombreOficial(item.getNombreOficial());
		bancos.setBloqueado(item.getBloqueado());

		itemsMock.add(bancos);
		items2Mock.add(item);

		Collections.sort(itemsMock);
		Collections.sort(items2Mock);

		return true;
	}

	public boolean update(Banco itemOriginal, Banco item) throws Exception {

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
		if (item.getNombreOficial() == null) {
			throw new NullFieldException("Nombre oficial");
		}
		if (item.getCuit() == null) {
			throw new NullFieldException("CUIT");
		}

		// ==================================================================
		// CHECKs UNIQUE

		checkUniqueNumero("Numero", itemOriginal.getNumero(), item.getNumero());
		checkUniqueNombre("Nombre", itemOriginal.getNombre(), item.getNombre());
		checkUniqueNombreOficial("Nombre oficial", itemOriginal.getNombreOficial(), item.getNombreOficial());
		checkUniqueCuit("CUIT", itemOriginal.getCuit(), item.getCuit());

		// ==================================================================
		// UPDATE

		Bancos bancos = new Bancos();
		bancos.setNumero(item.getNumero());
		bancos.setNombre(item.getNombre());
		bancos.setNombreOficial(item.getNombreOficial());
		bancos.setBloqueado(item.getBloqueado());

		for (int i = 0; i < itemsMock.size(); i++) {
			if (itemsMock.get(i).getNumero().equals(item.getNumero())) {
				itemsMock.remove(i);
				items2Mock.remove(i);
			}
		}

		itemsMock.add(bancos);
		items2Mock.add(item);

		Collections.sort(itemsMock);
		Collections.sort(items2Mock);

		return true;
	}
*/

	@Override
	public Integer maxNumero() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void checkUniqueNumero(String label, Integer numeroOriginal, Integer numero) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void checkUniqueNombre(String label, String nombreOriginal, String nombre) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void checkUniqueNombreOficial(String label, String nombreOficialOriginal, String nombreOficial)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void checkUniqueCuit(String label, String cuitOriginal, String cuit) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteItem(Bancos item) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
