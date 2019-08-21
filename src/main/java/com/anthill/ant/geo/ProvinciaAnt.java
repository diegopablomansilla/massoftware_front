package com.anthill.ant.geo;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class ProvinciaAnt extends Ant {

	private Ant paisAnt;

	public ProvinciaAnt(Anthill anthill, Ant paisAnt) {
		super(anthill);
		this.paisAnt = paisAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.PAIS, A.PROVINCIA, A.NOMBRE, A.ABREVIATURA FROM Provincias A WHERE (
		// A.PAIS = 1 AND A.NOMBRE LIKE ''%'' ) ORDER BY A.PAIS, A.NOMBRE, A.PROVINCIA

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Provincia");
		c.setNamePlural("Provincias");

		c.setNamePackage("geo");
		c.setSingular("Provincia");
		c.setPlural("Provincias");
		c.setSingularPre("la provincia");
		c.setPluralPre("las provincias");

		// -------- Atts

		Att numero = new Att("numero", "Nº provincia");
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

		Att abreviatura = new Att("abreviatura", "Abreviatura");
		abreviatura.setRequired(true);
		abreviatura.setUnique(true);
		abreviatura.setLength(null, 5);
		abreviatura.setColumns((float) 5);
		c.addAtt(abreviatura);

		Att numeroAFIP = new Att("numeroAFIP", "Nº provincia AFIP");
		numeroAFIP.setDataTypeInteger(1, null);
		// ((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		// numero.setRequired(true);
		// numero.setUnique(true);
		c.addAtt(numeroAFIP);

		Att numeroIngresosBrutos = new Att("numeroIngresosBrutos", "Nº provincia ingresos brutos");
		numeroIngresosBrutos.setDataTypeInteger(1, null);
		// ((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		// numero.setRequired(true);
		// numero.setUnique(true);
		c.addAtt(numeroIngresosBrutos);

		Att numeroRENATEA = new Att("numeroRENATEA", "Nº provincia RENATEA");
		numeroRENATEA.setDataTypeInteger(1, null);
		// ((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		// numero.setRequired(true);
		// numero.setUnique(true);
		c.addAtt(numeroRENATEA);

		Att pais = new Att("pais", "País");
		pais.setDataTypeClazz(paisAnt.build());
		pais.setRequired(true);
		c.addAtt(pais);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		c.addArgument(abreviatura);
		c.getLastArgument().setRequired(false);

		c.addArgument(pais);
		// provincia.getLastArgument().setRequired(true);

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
