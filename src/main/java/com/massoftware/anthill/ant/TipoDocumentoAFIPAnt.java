package com.massoftware.anthill.ant;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;
import com.massoftware.anthill.DataTypeInteger;

public class TipoDocumentoAFIPAnt extends Ant {

	public TipoDocumentoAFIPAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// SELECT A.TIPO, A.DESCRIPCION FROM AfipTiposDocumentos A ORDER BY A.TIPO

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("TipoDocumentoAFIP");

		c.setNamePackage("afip");
		c.setSingular("Tipo de documento");
		c.setPlural("Tipos de documentos");
		c.setSingularPre("el tipo de documento");
		c.setPluralPre("los tipos de documentos");

		// -------- Atts

		Att numero = new Att("numero", "Nº tipo");
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

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
