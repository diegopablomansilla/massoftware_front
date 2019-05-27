package com.massoftware.anthill.ant;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;
import com.massoftware.anthill.DataTypeInteger;

public class CiudadAnt extends Ant {

	private Ant paisAnt;
	private Ant provinciaAnt;

	public CiudadAnt(Anthill anthill, Ant paisAnt, Ant provinciaAnt) {
		super(anthill);
		this.paisAnt = paisAnt;
		this.provinciaAnt = provinciaAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.CIUDAD, A.PAIS, A.PROVINCIA, A.NOMBRE, B.PAIS, B.PROVINCIA,
		// B.NOMBRE, C.PAIS, C.NOMBRE, C.ABREVIATURA FROM {oj Ciudades A LEFT OUTER JOIN
		// Provincias B ON A.PAIS= B.PAIS AND A.PROVINCIA= B.PROVINCIA LEFT OUTER JOIN
		// Paises C ON B.PAIS= C.PAIS } ORDER BY A.NOMBRE, A.CIUDAD

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Ciudad");

		c.setNamePackage("geo");
		c.setSingular("Ciudad");
		c.setPlural("Ciudades");
		c.setSingularPre("la ciudad");
		c.setPluralPre("las ciudades");

		// -------- Atts

		Att numero = new Att("numero", "Nº ciudad");
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

		Att departamento = new Att("departamento", "Departamento");
		departamento.setRequired(false);
		departamento.setUnique(false);
		departamento.setLength(null, 50);
		// departamento.setColumns((float) 5);
		c.addAtt(departamento);

		Att numeroAFIP = new Att("numeroAFIP", "Nº provincia AFIP");
		numeroAFIP.setDataTypeInteger(1, null);
		// ((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		// numero.setRequired(true);
		// numero.setUnique(true);
		c.addAtt(numeroAFIP);

		Att provincia = new Att("provincia", "Provincia");
		provincia.setDataTypeClazz(provinciaAnt.build());
		provincia.setRequired(true);
		c.addAtt(provincia);

		Att pais = new Att("pais", "País");
		pais.setDataTypeClazz(paisAnt.build());
		pais.setRequired(true);
		// provincia.addAtt(pais);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		c.addArgument(pais);
		c.getLastArgument().setRequired(true);
		c.getLastArgument().setOnlyVisual(true);

		c.addArgument(provincia);
		c.getLastArgument().setRequired(true);

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
