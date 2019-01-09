package com.massoftware.windows.bancos;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.cendra.ex.crud.DeleteForeingObjectConflictException;
import org.cendra.ex.crud.InsertNullException;
import org.cendra.ex.crud.NullFieldException;

import com.massoftware.backend.BackendContextPG;

class BancosBO {

	public List<Bancos> find(int limit, int offset, Map<String, Boolean> orderBy, BancosFiltro filtro)
			throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String attId = "id";
		String attNumero = "numero";
		String attNombre = "nombre";
		String attBloqueado = "bloqueado";

		String tableSQL = "Banco";
		String attsSQL = attId + ", " + attNumero + ", " +attNombre + ", " + attBloqueado;
		String orderBySQL = attNumero;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (filtro.getNumero() != null) {
			filtros.add(filtro.getNumero());
			whereSQL += attNumero + " = ? AND ";
		}
		if (filtro.getNombre() != null) {
			String[] palabras = filtro.getNombre().split(" ");
			for (String palabra : palabras) {
				filtros.add(palabra.trim());								
				whereSQL += "TRIM(massoftware.TRASLATE(" + attNombre + ")))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRASLATE(?))) || '%')::VARCHAR AND ";
			}
		}
		if (filtro.getNombreOficial() != null) {
			String[] palabras = filtro.getNombreOficial().split(" ");
			for (String palabra : palabras) {
				filtros.add(palabra.trim());				
				whereSQL += "TRIM(massoftware.TRASLATE(" + attNombre + ")))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRASLATE(?))) || '%')::VARCHAR AND ";
			}

		}
//		if (filtro.getBloqueado() != null) {
//			filtros.add(filtro.getBloqueado());
//			whereSQL += attBloqueado + " = ? AND ";
//		}

		// ==================================================================

		whereSQL = whereSQL.trim();
		if (whereSQL.length() > 0) {
			whereSQL = whereSQL.substring(0, whereSQL.length() - 4);
		} else {
			whereSQL = null;
		}

		ArrayList<Bancos> lista = new ArrayList<Bancos>();

		Object[][] table = BackendContextPG.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, limit, offset,
				filtros.toArray());

		for (int i = 0; i < table.length; i++) {
			Bancos item = new Bancos();
			item.setId((String) table[i][0]);
			item.setNumero((Integer) table[i][1]);
			item.setNombre((String) table[i][2]);			
			item.setBloqueado((Boolean) table[i][3]);

			lista.add(item);
		}

		return lista;
	}

	public void deleteItem(Bancos item) throws Exception {

		// CuentasDeFondos
		// Personal
		// Proveedores
		// ValoresDeTerceros
		// ValoresPropios

		// ==================================================================
		// CHECKs NULLs

		if (item == null) {
			throw new InsertNullException("Banco");
		}
		if (item.getNumero() == null) {
			throw new NullFieldException("Numero");
		}

		// ==================================================================
		// CHECKs FKs

		Integer c = ifExistsCuentasDeFondos(item.getNumero());

		if (c > 0) {
			throw new DeleteForeingObjectConflictException("el", "Banco", item, (long)c, "Cuenta de Fondo");
		}

		c = ifExistsPersonal(item.getNumero());

		if (c > 0) {
			throw new DeleteForeingObjectConflictException("el", "Banco", item, (long)c, "Personal");
		}

		c = ifExistsProveedores(item.getNumero());

		if (c > 0) {
			throw new DeleteForeingObjectConflictException("el", "Banco", item, (long)c, "Proveedor");
		}

		c = ifExistsValoresDeTerceros(item.getNumero());

		if (c > 0) {
			throw new DeleteForeingObjectConflictException("el", "Banco", item, (long)c, "Valor de Tercero");
		}

		c = ifExistsValoresPropios(item.getNumero());

		if (c > 0) {
			throw new DeleteForeingObjectConflictException("el", "Banco", item, (long)c, "Valor Propio");
		}

		// ==================================================================

		String attNumero = "CAST(BANCO AS INTEGER)";

		String tableSQL = "Bancos";
		String whereSQL = "";

		ArrayList<Object> args = new ArrayList<Object>();

		args.add(item.getNumero());
		whereSQL += attNumero + " = ?";

		BackendContextPG.get().delete(tableSQL, whereSQL, args.toArray());

	}

	private Integer ifExistsCuentasDeFondos(Integer numero) throws Exception {
		String tableSQL = "CuentasDeFondos";

		return ifExists(tableSQL, numero);
	}

	private Integer ifExistsPersonal(Integer numero) throws Exception {
		String tableSQL = "Personal";

		return ifExists(tableSQL, numero);
	}

	private Integer ifExistsProveedores(Integer numero) throws Exception {
		String tableSQL = "Proveedores";

		return ifExists(tableSQL, numero);
	}

	private Integer ifExistsValoresDeTerceros(Integer numero) throws Exception {
		String tableSQL = "ValoresDeTerceros";

		return ifExists(tableSQL, numero);
	}

	private Integer ifExistsValoresPropios(Integer numero) throws Exception {
		String tableSQL = "ValoresPropios";

		return ifExists(tableSQL, numero);
	}

	private Integer ifExists(String tableSQL, Integer numero) throws Exception {
		// ==================================================================
		// MS SQL SERVER

		String attNumero = "CAST(BANCO AS INTEGER)";
		if ("Proveedores".equals(tableSQL)) {
			attNumero = "CAST(BANCOTRANSF AS INTEGER)";
		}

		String attsSQL = "COUNT(" + attNumero + ") ";
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (attNumero != null) {
			filtros.add(numero);
			whereSQL += attNumero + " = ? AND ";
		}

		// ==================================================================

		whereSQL = whereSQL.trim();
		if (whereSQL.length() > 0) {
			whereSQL = whereSQL.substring(0, whereSQL.length() - 4);
		} else {
			whereSQL = null;
		}

		Object[][] table = BackendContextPG.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		return (Integer) table[0][0];

	}

}
