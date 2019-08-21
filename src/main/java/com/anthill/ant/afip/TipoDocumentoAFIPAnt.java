package com.anthill.ant.afip;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class TipoDocumentoAFIPAnt extends Ant {

	public TipoDocumentoAFIPAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// SELECT A.TIPO, A.DESCRIPCION FROM AfipTiposDocumentos A ORDER BY A.TIPO

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("TipoDocumentoAFIP");
		c.setNamePlural("TiposDocumentosAFIP");

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
