package com.massoftware.backend.migracion;

import com.massoftware.backend.BackendContextMS;
import com.massoftware.model.Banco;
import com.massoftware.model.Grupo;
import com.massoftware.model.Rubro;

public class MigradorMSToPG {

	public static void main(String[] args) {
		try {

			migrar();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void migrar() throws Exception {

		System.out.println("\n\nStart Migrador\n\n");

		banco();

		// rubro();

		// grupo();

		System.out.println("\n\nEnd Migrador\n\n");

	}

	public static void banco() throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String attId = "CAST(A.BANCO AS VARCHAR)";
		String attNumero = "CAST(A.BANCO AS INTEGER)";
		String attNombre = "LTRIM(RTRIM(CAST(A.NOMBRE AS VARCHAR)))";
		String attCuit = "CAST(A.CUIT AS BIGINT)";
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

		String attsSQL = attId + ", " + attNumero + ", " + attNombre + ", " + attCuit + ", " + attBloqueado + ", "
				+ attHoja + ", " + attPrimeraFila + ", " + attUltimaFila + ", " + attFecha + ", " + attDescripcion
				+ ", " + attReferencia1 + ", " + attReferencia2 + ", " + attImporte + ", " + attSaldo;
		String orderBySQL = null;
		String whereSQL = null;

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			Banco item = new Banco();
			item.setter(table[i]);
			item.insert();

			item.loadById();

			System.out.println(item);

			item.setBloqueado(true);
			item.update();

			item.loadById();

			System.out.println(item);

		}

	}

	public static void rubro() throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String attId = "CAST(A.RUBRO AS VARCHAR)";
		String attNumero = "CAST(A.RUBRO AS INTEGER)";
		String attNombre = "LTRIM(RTRIM(CAST(A.NOMBRE AS VARCHAR)))";

		String tableSQL = "CuentasDeFondosRubro A";

		String attsSQL = attId + ", " + attNumero + ", " + attNombre;
		String orderBySQL = null;
		String whereSQL = null;

		// ==================================================================

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			Rubro item = new Rubro();
			// item.setter(table[i]);
			// item.insert();

		}

	}

	public static void grupo() throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String attId = " CONCAT ( CAST(A.RUBRO AS VARCHAR), '-', CAST(A.GRUPO AS VARCHAR) )";
		String attNumeroRubro = "CAST(A.RUBRO AS INTEGER)";
		String attNumero = "CAST(A.GRUPO AS INTEGER)";
		String attNombre = "LTRIM(RTRIM(CAST(A.NOMBRE AS VARCHAR)))";

		String tableSQL = "CuentasDeFondosGrupo A";

		String attsSQL = attId + ", " + attNumeroRubro + ", " + attNumero + ", " + attNombre;
		String orderBySQL = null;
		String whereSQL = null;

		// ==================================================================

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			Grupo item = new Grupo();
			// item.setter(table[i]);
			// item.insert();
			//
			// item.loadById();
			//
			// item.update();
			//
			// System.out.println(item.getRubro());

		}

	}

}
