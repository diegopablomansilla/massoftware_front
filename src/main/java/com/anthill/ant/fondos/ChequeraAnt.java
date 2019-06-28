package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class ChequeraAnt extends Ant {

	private Ant cuentaFondoAnt;

	public ChequeraAnt(Anthill anthill, Ant cuentaFondoAnt) {
		super(anthill);
		this.cuentaFondoAnt = cuentaFondoAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.CHEQUERA, A.PRIMERNRO, A.ULTIMONRO, A.PROXIMONRO, A.CUENTA,
		// A.BLOQUEADO FROM Chequeras A WHERE ( A.CUENTA = ''11202 '' AND NOT
		// A.BLOQUEADO <> 0 ) ORDER BY A.CUENTA, A.CHEQUERA

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Chequera");

		c.setNamePackage("fondos");
		c.setSingular("Chequera");
		c.setPlural("Chequeras");
		c.setSingularPre("la chequera");
		c.setPluralPre("las chequeras");

		// -------- Atts

		Att numero = new Att("numero", "Nº chequera");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		c.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		c.addAtt(nombre);

		Att cuentaFondo = new Att("cuentaFondo", "Cuenta fondo");
		cuentaFondo.setDataTypeClazz(cuentaFondoAnt.build());
		cuentaFondo.setRequired(true);
		c.addAtt(cuentaFondo);

		Att primerNumero = new Att("primerNumero", "Primer número");
		primerNumero.setDataTypeInteger(0, null);
		c.addAtt(primerNumero);

		Att ultimoNumero = new Att("ultimoNumero", "Último número");
		ultimoNumero.setDataTypeInteger(0, null);
		c.addAtt(ultimoNumero);

		Att proximoNumero = new Att("proximoNumero", "Próximo número");
		proximoNumero.setDataTypeInteger(0, null);
		c.addAtt(proximoNumero);

		Att bloqueado = new Att("bloqueado", "Obsoleto");
		bloqueado.setDataTypeBoolean();
		c.addAtt(bloqueado);

		Att impresionDiferida = new Att("impresionDiferida", "Impresión diferida");
		impresionDiferida.setDataTypeBoolean();
		impresionDiferida.setRequired(true);
		c.addAtt(impresionDiferida);

		Att formato = new Att("formato", "Formato");
		formato.setLength(null, 50);
		c.addAtt(formato);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		c.addArgument(cuentaFondo);
		c.getLastArgument().setRequired(true);

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
