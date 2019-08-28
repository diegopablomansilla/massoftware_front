package com.anthill.ant.geo;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Argument;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class CodigoPostalAnt extends Ant {

	private Ant paisAnt;
	private Ant provinciaAnt;
	private Ant ciudadAnt;

	public CodigoPostalAnt(Anthill anthill, Ant paisAnt, Ant provinciaAnt, Ant ciudadAnt) {
		super(anthill);
		this.paisAnt = paisAnt;
		this.provinciaAnt = provinciaAnt;
		this.ciudadAnt = ciudadAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.CODPOSTAL, A.SECUENCIA, A.CIUDADCALLE, A.CALLENUMERO, A.CIUDAD,
		// A.NROPAIS,
		// A.NROPROVINCIA, B.NROPAIS, B.NROPROVINCIA, B.DESCRIPCION, B.ABREVIATURA,
		// C.NROPAIS, C.DESCRIPCION, C.ABREVIATURA
		// FROM {
		// oj CodPostal A
		// LEFT OUTER JOIN Provincia B
		// ON A.NROPAIS= B.NROPAIS AND A.NROPROVINCIA= B.NROPROVINCIA
		// LEFT OUTER JOIN Pais C
		// ON A.NROPAIS= C.NROPAIS
		// }
		// WHERE ( A.NROPAIS = 1 )
		// ORDER BY A.NROPAIS, A.CODPOSTAL, A.SECUENCIA

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("CodigoPostal");
		c.setNamePlural("CodigosPostales");

		c.setNamePackage("geo");
		c.setSingular("Código postal");
		c.setPlural("Códigos postales");
		c.setSingularPre("el código postal");
		c.setPluralPre("los códigos postales");

		// -------- Atts

		Att codigo = new Att("codigo", "Código");
		codigo.setRequired(true);
		codigo.setUnique(true);
		codigo.setLength(null, 12);
		// codigo.setColumns((float) 6);
		c.addAtt(codigo);

		Att numero = new Att("numero", "Secuencia");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		c.addAtt(numero);

		Att nombreCalle = new Att("nombreCalle", "Calle");
		nombreCalle.setRequired(true);
		nombreCalle.setUnique(false);
		nombreCalle.setLength(null, 200);
		c.addAtt(nombreCalle);

		Att numeroCalle = new Att("numeroCalle", "Número calle");
		numeroCalle.setRequired(true);
		numeroCalle.setUnique(false);
		numeroCalle.setLength(null, 20);
		// departamento.setColumns((float) 5);
		c.addAtt(numeroCalle);

		Att ciudad = new Att("ciudad", "Ciudad");
		ciudad.setDataTypeClazz(ciudadAnt.build());
		ciudad.setRequired(true);
		c.addAtt(ciudad);

		Att provincia = new Att("provincia", "Provincia");
		provincia.setDataTypeClazz(provinciaAnt.build());
		provincia.setRequired(true);
		// c.addAtt(provincia);

		Att pais = new Att("pais", "País");
		pais.setDataTypeClazz(paisAnt.build());
		pais.setRequired(true);
		// provincia.addAtt(pais);

		// -------- GRID

		Att nombrePais = new Att("nombrePais", "Pais");
		Att nombreProvincia = new Att("nombreProvincia", "Provincia");
		Att nombreCiudad = new Att("nombreCiudad", "Ciudad");

		c.addAttGrid(nombrePais);
		c.addAttGrid(nombreProvincia);
		c.addAttGrid(nombreCiudad);
		c.addAttGrid(codigo);
		c.addAttGrid(numero);
		c.addAttGrid(numeroCalle);
		c.addAttGrid(nombreCalle);

		// -------- SBX Args

		c.addArgument(pais);
		c.getLastArgument().setRequired(true);
		c.getLastArgument().setOnlyVisual(true);

		c.addArgument(provincia);
		c.getLastArgument().setRequired(true);
		c.getLastArgument().setOnlyVisual(true);

		c.addArgument(ciudad);
		c.getLastArgument().setRequired(true);

		c.addArgument(codigo, Argument.EQUALS_IGNORE_CASE);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());
		
		c.addArgument(nombreCalle);
		c.getLastArgument().setRequired(false);

		// -------- Simple Args

		// -------- Order

		c.addOrderAllAtts();

		// c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		c.setStmAtts(
				", Pais.nombre AS nombrePais, Provincia.nombre AS nombreProvincia, Ciudad.nombre AS nombreCiudad, CodigoPostal.codigo, CodigoPostal.numero, CodigoPostal.numeroCalle, CodigoPostal.nombreCalle");
		c.setStmJoins("  LEFT JOIN massoftware.Ciudad ON Ciudad.id = CodigoPostal.ciudad LEFT JOIN massoftware.Provincia ON Provincia.id = Ciudad.provincia "
				+ " LEFT JOIN massoftware.Pais ON Pais.id = Provincia.pais");

		 c.setBuildStm(false);

		return c;

		// ------------------------------------------------
	}

}
