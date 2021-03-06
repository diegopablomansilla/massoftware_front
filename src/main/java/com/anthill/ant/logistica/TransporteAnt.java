package com.anthill.ant.logistica;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class TransporteAnt extends Ant {

	private Ant codigoPostalAnt;

	public TransporteAnt(Anthill anthill, Ant codigoPostalAnt) {
		super(anthill);
		this.codigoPostalAnt = codigoPostalAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.TRANSPORTE, A.NOMBRE, A.DOMICILIO, A.CODIGOPOSTAL, A.CIUDADNRO,
		// A.TELEFONO, A.FAX, A.COMENTARIO, B.CIUDAD, B.PAIS, B.PROVINCIA, B.NOMBRE FROM
		// {oj Transportes A LEFT OUTER JOIN Ciudades B ON A.CIUDADNRO= B.CIUDAD } ORDER
		// BY A.NOMBRE, A.TRANSPORTE

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Transporte");
		c.setNamePlural("Transportes");

		c.setNamePackage("logistica");
		c.setSingular("Transporte");
		c.setPlural("Transportes");
		c.setSingularPre("el transporte");
		c.setPluralPre("los transportes");

		// -------- Atts

		Att numero = new Att("numero", "Nº transporte");
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

		Att cuit = new Att("cuit", "CUIT");
		cuit.setDataTypeLong(1L, 99999999999L);
		cuit.setRequired(true);
		cuit.setUnique(true);
		cuit.setColumns((float) 11);
		cuit.setLength(11, 11);
		cuit.setMask("99-99999999-9");
		c.addAtt(cuit);

		Att ingresosBrutos = new Att("ingresosBrutos", "Ingresos brutos");
		ingresosBrutos.setRequired(false);
		ingresosBrutos.setUnique(false);
		ingresosBrutos.setLength(null, 13);
		c.addAtt(ingresosBrutos);

		Att telefono = new Att("telefono", "Teléfono");
		telefono.setRequired(false);
		telefono.setUnique(false);
		telefono.setLength(null, 50);
		c.addAtt(telefono);

		Att fax = new Att("fax", "Fax");
		fax.setRequired(false);
		fax.setUnique(false);
		fax.setLength(null, 50);
		c.addAtt(fax);

		Att codigoPostal = new Att("codigoPostal", "Código postal");
		codigoPostal.setDataTypeClazz(codigoPostalAnt.build());
		codigoPostal.setRequired(true);
		c.addAtt(codigoPostal);

		Att domicilio = new Att("domicilio", "Domicilio");
		domicilio.setRequired(false);
		domicilio.setUnique(false);
		domicilio.setLength(null, 150);
		c.addAtt(domicilio);

		Att comentario = new Att("comentario", "Comentario");
		comentario.setRequired(false);
		comentario.setUnique(false);
		comentario.setLength(null, 300);
		c.addAtt(comentario);

		// -------- GRID

		Att nombrePais = new Att("nombrePais", "Pais");
		Att nombreProvincia = new Att("nombreProvincia", "Provincia");
		Att nombreCiudad = new Att("nombreCiudad", "Ciudad");
		Att codigoPostalGrid = new Att("codigoPostal", "CP");

				
		c.addAttGrid(numero);
		c.addAttGrid(cuit);
		c.addAttGrid(nombre);
		c.addAttGrid(domicilio);
		c.addAttGrid(codigoPostalGrid);
		c.addAttGrid(nombreCiudad);
		c.addAttGrid(nombreProvincia);
		c.addAttGrid(nombrePais);
		

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		// -------- Order

		// monedaAFIP.addOrder(codigo);
		// monedaAFIP.addOrder(nombre);

		c.addOrderAllAtts();

		// ------------------------------------------------

		c.setStmAtts(
				", Transporte.numero, Transporte.cuit, Transporte.nombre, Transporte.domicilio"
				+ ", CodigoPostal.codigo AS codigoPostal, Ciudad.nombre AS nombreCiudad, Provincia.nombre AS nombreProvincia, Pais.nombre AS nombrePais ");
				 
		c.setStmJoins("  LEFT JOIN massoftware.CodigoPostal ON CodigoPostal.id = transporte.codigoPostal "
				+ "	LEFT JOIN massoftware.Ciudad ON Ciudad.id = CodigoPostal.ciudad "
				+ "LEFT JOIN massoftware.Provincia ON Provincia.id = Ciudad.provincia "
				+ " LEFT JOIN massoftware.Pais ON Pais.id = Provincia.pais");
		
//		 c.setBuildStm(false);

		return c;

		// ------------------------------------------------
	}

}
