package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class JuridiccionConvnioMultilateralAnt extends Ant {

	private Ant cuentaFondoAnt;

	public JuridiccionConvnioMultilateralAnt(Anthill anthill, Ant cuentaFondoAnt) {
		super(anthill);
		this.cuentaFondoAnt = cuentaFondoAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.JURISDICCION, A.NOMBRE, A.CUENTAFONDO, B.RUBRO, B.GRUPO, B.CUENTA,
		// B.NOMBRE, B.EJERCICIO, B.CUENTACONTABLE, B.TIPO, B.CAJA, B.BANCO,
		// B.CUENTADIFERIDOS, B.CUENTACAUCION FROM {oj
		// ConvenioMultilateralJurisdicciones A LEFT OUTER JOIN CuentasDeFondos B ON
		// A.CUENTAFONDO= B.CUENTA } ORDER BY A.JURISDICCION

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("JuridiccionConvnioMultilateral");

		c.setNamePackage("fondos");
		c.setSingular("Juridicción de convnio multilateral");
		c.setPlural("Juridicciones de convnio multilateral");
		c.setSingularPre("la juridicción de convnio multilateral");
		c.setPluralPre("las juridicciones de convnio multilateral");

		// -------- Atts

		Att numero = new Att("numero", "Nº juridicción");
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

		
		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

//		c.addArgument(cuentaFondo);
//		c.getLastArgument().setRequired(true);

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
