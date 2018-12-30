package com.massoftware.windows.banco2;

import java.math.BigDecimal;
import java.util.ArrayList;

import org.cendra.ex.crud.InsertNullException;
import org.cendra.ex.crud.NullFieldException;
import org.cendra.ex.crud.UniqueException;

import com.massoftware.backend.BackendContext;
import com.massoftware.windows.banco.Banco;

public class BancoBO {

	public Banco find(BancoFiltro filtro) throws Exception {
		
		// ==================================================================
		// MS SQL SERVER

		String attNumero = "CAST(A.BANCO AS INTEGER)";
		String attNombre = "LTRIM(RTRIM(CAST(A.NOMBRE AS VARCHAR)))";
		String attNombreOficial = "LTRIM(RTRIM(CAST(A.NOMBRECOMPLETO AS VARCHAR)))";
		String attCuit = "A.CUIT";
		String attBloqueado = "CAST(A.BLOQUEADO AS BIT)";
		String attHoja = "CAST(A.HOJA AS INTEGER)";
		String attPrimeraFila = "CAST(A.PRIMERAFILA AS INTEGER)";
		String attUltimaFila = "CAST(A.ULTIMAFILA AS INTEGER)";
		String attFecha = "LTRIM(RTRIM(CAST(A.COLUMNAFECHA AS VARCHAR)))";
		String attDescripcion = "LTRIM(RTRIM(CAST(A.COLUMNADESCRIPCION AS VARCHAR)))";
		String attReferencia1 = "LTRIM(RTRIM(CAST(A.COLUMNAREFERENCIA1 AS VARCHAR)))";
		String attReferencia2 = "LTRIM(RTRIM(CAST(A.COLUMNAREFERENCIA2 AS VARCHAR)))";
		String attImporte = "LTRIM(RTRIM(CAST(A.COLUMNAIMPORTE AS VARCHAR)))";
		String attSaldo = "LTRIM(RTRIM(CAST(A.COLUMNASALDO AS VARCHAR)))";

		String tableSQL = "Bancos A";

		String attsSQL = attNumero + ", " + attNombre + ", " + attNombreOficial + ", " + attCuit + ", " + attBloqueado
				+ ", " + attHoja + ", " + attPrimeraFila + ", " + attUltimaFila + ", " + attFecha + ", "
				+ attDescripcion + ", " + attReferencia1 + ", " + attReferencia2 + ", " + attImporte + ", " + attSaldo;
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (filtro.getNumero() != null) {
			filtros.add(filtro.getNumero());
			whereSQL += attNumero + " = ?";
		}

		// ==================================================================

		whereSQL = whereSQL.trim();

		Object[][] table = BackendContext.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		if (table.length == 1) {
			
			Banco item = new Banco();
			
			item.setNumero((Integer) table[0][0]);
			item.setNombre((String) table[0][1]);
			item.setNombreOficial((String) table[0][2]);
			item.setCuit((BigDecimal) table[0][3]);
			item.setBloqueado((Boolean) table[0][4]);

			item.setHoja((Integer) table[0][5]);
			item.setPrimeraFila((Integer) table[0][6]);
			item.setUltimaFila((Integer) table[0][7]);

			item.setFecha((String) table[0][8]);
			item.setDescripcion((String) table[0][9]);
			item.setReferencia1((String) table[0][10]);
			item.setReferencia2((String) table[0][11]);
			item.setImporte((String) table[0][12]);
			item.setSaldo((String) table[0][13]);

			return item;
		} else if (table.length > 1) {

		}

		return null;

	}

	public Integer maxNumero() throws Exception {

		return BackendContext.get().maxValueInteger("CAST(A.BANCO AS INTEGER)", "Bancos A");
	}

	private boolean ifExistsByNumero(Integer numero) throws Exception {
		// ==================================================================
		// MS SQL SERVER

		String attNumero = "CAST(A.BANCO AS INTEGER)";

		String tableSQL = "Bancos A";

		String attsSQL = "COUNT(" + attNumero + ") ";
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (numero != null) {
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

		Object[][] table = BackendContext.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		return (Integer) table[0][0] > 0;

	}

	public void checkUniqueNumero(String label, Integer numeroOriginal, Integer numero) throws Exception {

		if (numeroOriginal != null && numeroOriginal.equals(numero) == false) {

			if (ifExistsByNumero(numero)) {
				throw new UniqueException(label);
			}

		} else if (numeroOriginal == null) {

			if (ifExistsByNumero(numero)) {
				throw new UniqueException(label);
			}
		}

	}

	private boolean ifExistsByNombre(String nombre) throws Exception {
		// ==================================================================
		// MS SQL SERVER

		String attNombre = "LTRIM(RTRIM(CAST(A.NOMBRE AS VARCHAR)))";

		String tableSQL = "Bancos A";

		String attsSQL = "COUNT(" + attNombre + ") ";
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (nombre != null) {
			filtros.add(nombre);
			whereSQL += attNombre + " = ? AND ";
		}

		// ==================================================================

		whereSQL = whereSQL.trim();
		if (whereSQL.length() > 0) {
			whereSQL = whereSQL.substring(0, whereSQL.length() - 4);
		} else {
			whereSQL = null;
		}

		Object[][] table = BackendContext.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		return (Integer) table[0][0] > 0;

	}

	public void checkUniqueNombre(String label, String nombreOriginal, String nombre) throws Exception {

		if (nombreOriginal != null && nombreOriginal.equals(nombre) == false) {

			if (ifExistsByNombre(nombre)) {
				throw new UniqueException(label);
			}

		} else if (nombreOriginal == null) {

			if (ifExistsByNombre(nombre)) {
				throw new UniqueException(label);
			}
		}

	}

	private boolean ifExistsByNombreOficial(String nombreOficial) throws Exception {
		// ==================================================================
		// MS SQL SERVER

		String attNombreOficial = "LTRIM(RTRIM(CAST(A.NOMBRECOMPLETO AS VARCHAR)))";

		String tableSQL = "Bancos A";

		String attsSQL = "COUNT(" + attNombreOficial + ") ";
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (nombreOficial != null) {
			filtros.add(nombreOficial);
			whereSQL += attNombreOficial + " = ? AND ";
		}

		// ==================================================================

		whereSQL = whereSQL.trim();
		if (whereSQL.length() > 0) {
			whereSQL = whereSQL.substring(0, whereSQL.length() - 4);
		} else {
			whereSQL = null;
		}

		Object[][] table = BackendContext.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		return (Integer) table[0][0] > 0;

	}

	public void checkUniqueNombreOficial(String label, String nombreOficialOriginal, String nombreOficial)
			throws Exception {

		if (nombreOficialOriginal != null && nombreOficialOriginal.equals(nombreOficial) == false) {

			if (ifExistsByNombreOficial(nombreOficial)) {
				throw new UniqueException(label);
			}

		} else if (nombreOficialOriginal == null) {

			if (ifExistsByNombreOficial(nombreOficial)) {
				throw new UniqueException(label);
			}
		}

	}

	private boolean ifExistsByCuit(BigDecimal cuit) throws Exception {
		// ==================================================================
		// MS SQL SERVER

		String attCuit = "A.CUIT";

		String tableSQL = "Bancos A";

		String attsSQL = "COUNT(" + attCuit + ") ";
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (cuit != null) {
			filtros.add(cuit);
			whereSQL += attCuit + " = ? AND ";
		}

		// ==================================================================

		whereSQL = whereSQL.trim();
		if (whereSQL.length() > 0) {
			whereSQL = whereSQL.substring(0, whereSQL.length() - 4);
		} else {
			whereSQL = null;
		}

		Object[][] table = BackendContext.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		return (Integer) table[0][0] > 0;

	}

	public void checkUniqueCuit(String label, BigDecimal cuitOriginal, BigDecimal cuit) throws Exception {

		if (cuitOriginal != null && cuitOriginal.equals(cuit) == false) {

			if (ifExistsByCuit(cuit)) {
				throw new UniqueException(label);
			}

		} else if (cuitOriginal == null) {

			if (ifExistsByCuit(cuit)) {
				throw new UniqueException(label);
			}
		}

	}

	private boolean check(Banco itemOriginal, Banco item) throws Exception {

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

		if (itemOriginal != null) {
			checkUniqueNumero("Numero", itemOriginal.getNumero(), item.getNumero());
			checkUniqueNombre("Nombre", itemOriginal.getNombre(), item.getNombre());
			checkUniqueNombreOficial("Nombre oficial", itemOriginal.getNombreOficial(), item.getNombreOficial());
			checkUniqueCuit("CUIT", itemOriginal.getCuit(), item.getCuit());
		} else {
			checkUniqueNumero("Numero", null, item.getNumero());
			checkUniqueNombre("Nombre", null, item.getNombre());
			checkUniqueNombreOficial("Nombre oficial", null, item.getNombreOficial());
			checkUniqueCuit("CUIT", null, item.getCuit());
		}

		// ==================================================================

		return true;
	}

	public boolean update(Banco itemOriginal, Banco item) throws Exception {

		check(itemOriginal, item);

		String tableSQL = "Bancos";

		String attNumero = "BANCO";
		String attNombre = "NOMBRE";
		String attNombreOficial = "NOMBRECOMPLETO";
		String attCuit = "CUIT";
		String attBloqueado = "BLOQUEADO";
		String attHoja = "HOJA";
		String attPrimeraFila = "PRIMERAFILA";
		String attUltimaFila = "ULTIMAFILA";
		String attFecha = "COLUMNAFECHA";
		String attDescripcion = "COLUMNADESCRIPCION";
		String attReferencia1 = "COLUMNAREFERENCIA1";
		String attReferencia2 = "COLUMNAREFERENCIA2";
		String attImporte = "COLUMNAIMPORTE";
		String attSaldo = "COLUMNASALDO";

		String attNumeroOriginal = "CAST(BANCO AS INTEGER)";

		String[] nameAtts = { attNumero, attNombre, attNombreOficial, attCuit, attBloqueado, attHoja, attPrimeraFila,
				attUltimaFila, attFecha, attDescripcion, attReferencia1, attReferencia2, attImporte, attSaldo };

		Object valNumero = Integer.class;
		Object valNombre = String.class;
		Object valNombreOficial = String.class;
		Object valCuit = String.class;
		Object valBloqueado = String.class;
		Object valHoja = Integer.class;
		Object valPrimeraFila = Integer.class;
		Object valUltimaFila = Integer.class;
		Object valFecha = String.class;
		Object valDescripcion = String.class;
		Object valReferencia1 = String.class;
		Object valReferencia2 = String.class;
		Object valImporte = String.class;
		Object valSaldo = String.class;

		if (item.getNumero() != null) {
			valNumero = item.getNumero();
		}
		if (item.getNombre() != null) {
			valNombre = item.getNombre();
		}
		if (item.getNombreOficial() != null) {
			valNombreOficial = item.getNombreOficial();
		}
		if (item.getCuit() != null) {
			valCuit = item.getCuit();
		}
		if (item.getBloqueado() != null) {
			valBloqueado = item.getBloqueado();
		}
		if (item.getHoja() != null) {
			valHoja = item.getHoja();
		}
		if (item.getPrimeraFila() != null) {
			valPrimeraFila = item.getPrimeraFila();
		}
		if (item.getUltimaFila() != null) {
			valUltimaFila = item.getUltimaFila();
		}
		if (item.getFecha() != null) {
			valFecha = item.getFecha();
		}
		if (item.getDescripcion() != null) {
			valDescripcion = item.getDescripcion();
		}
		if (item.getReferencia1() != null) {
			valReferencia1 = item.getReferencia1();
		}
		if (item.getReferencia2() != null) {
			valReferencia2 = item.getReferencia2();
		}
		if (item.getImporte() != null) {
			valImporte = item.getImporte();
		}
		if (item.getSaldo() != null) {
			valSaldo = item.getSaldo();
		}

		Object valNumeroOriginal = Integer.class;

		if (itemOriginal.getNumero() != null) {
			valNumeroOriginal = itemOriginal.getNumero();
		}

		Object[] args = { valNumero, valNombre, valNombreOficial, valCuit, valBloqueado, valHoja, valPrimeraFila,
				valUltimaFila, valFecha, valDescripcion, valReferencia1, valReferencia2, valImporte, valSaldo,
				valNumeroOriginal };

		String whereSQL = attNumeroOriginal + " = ?";

		// ==================================================================

		whereSQL = whereSQL.trim();

		BackendContext.get().update(tableSQL, nameAtts, args, whereSQL);

		return true;
	}

	public boolean insert(Banco item) throws Exception {

		check(null, item);

		String tableSQL = "Bancos";

		String attNumero = "BANCO";
		String attNombre = "NOMBRE";
		String attNombreOficial = "NOMBRECOMPLETO";
		String attCuit = "CUIT";
		String attBloqueado = "BLOQUEADO";
		String attHoja = "HOJA";
		String attPrimeraFila = "PRIMERAFILA";
		String attUltimaFila = "ULTIMAFILA";
		String attFecha = "COLUMNAFECHA";
		String attDescripcion = "COLUMNADESCRIPCION";
		String attReferencia1 = "COLUMNAREFERENCIA1";
		String attReferencia2 = "COLUMNAREFERENCIA2";
		String attImporte = "COLUMNAIMPORTE";
		String attSaldo = "COLUMNASALDO";

		String[] nameAtts = { attNumero, attNombre, attNombreOficial, attCuit, attBloqueado, attHoja, attPrimeraFila,
				attUltimaFila, attFecha, attDescripcion, attReferencia1, attReferencia2, attImporte, attSaldo };

		Object valNumero = Integer.class;
		Object valNombre = String.class;
		Object valNombreOficial = String.class;
		Object valCuit = String.class;
		Object valBloqueado = String.class;
		Object valHoja = Integer.class;
		Object valPrimeraFila = Integer.class;
		Object valUltimaFila = Integer.class;
		Object valFecha = String.class;
		Object valDescripcion = String.class;
		Object valReferencia1 = String.class;
		Object valReferencia2 = String.class;
		Object valImporte = String.class;
		Object valSaldo = String.class;

		if (item.getNumero() != null) {
			valNumero = item.getNumero();
		}
		if (item.getNombre() != null) {
			valNombre = item.getNombre();
		}
		if (item.getNombreOficial() != null) {
			valNombreOficial = item.getNombreOficial();
		}
		if (item.getCuit() != null) {
			valCuit = item.getCuit();
		}
		if (item.getBloqueado() != null) {
			valBloqueado = item.getBloqueado();
		}
		if (item.getHoja() != null) {
			valHoja = item.getHoja();
		}
		if (item.getPrimeraFila() != null) {
			valPrimeraFila = item.getPrimeraFila();
		}
		if (item.getUltimaFila() != null) {
			valUltimaFila = item.getUltimaFila();
		}
		if (item.getFecha() != null) {
			valFecha = item.getFecha();
		}
		if (item.getDescripcion() != null) {
			valDescripcion = item.getDescripcion();
		}
		if (item.getReferencia1() != null) {
			valReferencia1 = item.getReferencia1();
		}
		if (item.getReferencia2() != null) {
			valReferencia2 = item.getReferencia2();
		}
		if (item.getImporte() != null) {
			valImporte = item.getImporte();
		}
		if (item.getSaldo() != null) {
			valSaldo = item.getSaldo();
		}

		Object[] args = { valNumero, valNombre, valNombreOficial, valCuit, valBloqueado, valHoja, valPrimeraFila,
				valUltimaFila, valFecha, valDescripcion, valReferencia1, valReferencia2, valImporte, valSaldo };

		// ==================================================================

		BackendContext.get().insert(tableSQL, nameAtts, args);

		return true;
	}

}
