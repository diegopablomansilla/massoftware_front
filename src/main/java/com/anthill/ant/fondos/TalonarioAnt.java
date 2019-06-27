package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class TalonarioAnt extends Ant {

	private Ant talonarioLetraAnt;
	private Ant talonarioControladorFizcalAnt;

	public TalonarioAnt(Anthill anthill, Ant talonarioLetraAnt, Ant talonarioControladorFizcalAnt) {
		super(anthill);
		this.talonarioLetraAnt = talonarioLetraAnt;
		this.talonarioControladorFizcalAnt = talonarioControladorFizcalAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.MULTIPROPOSITO, A.NOMBRE, A.LETRA, A.SUCURSAL, A.PROXIMONUMERO FROM
		// TablaDeMultiproposito A ORDER BY A.MULTIPROPOSITO

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Talonario");

		c.setNamePackage("fondos");
		c.setSingular("Talonario");
		c.setPlural("Talonarios");
		c.setSingularPre("el talonario");
		c.setPluralPre("los talonarios");

		// -------- Atts

		Att numero = new Att("numero", "Nº talonario");
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

		Att talonarioLetra = new Att("talonarioLetra", "Letra");
		talonarioLetra.setDataTypeClazz(talonarioLetraAnt.build());
		talonarioLetra.setRequired(true);
		c.addAtt(talonarioLetra);

		Att puntoVenta = new Att("puntoVenta", "Punto de venta");
		puntoVenta.setDataTypeInteger(1, 9999);
		puntoVenta.setRequired(true);
		c.addAtt(puntoVenta);

		Att autonumeracion = new Att("autonumeracion", "Autonumeración");
		autonumeracion.setDataTypeBoolean();
		autonumeracion.setRequired(true);
		c.addAtt(autonumeracion);

		Att numeracionPreImpresa = new Att("numeracionPreImpresa", "Numeración pre-impresa");
		numeracionPreImpresa.setDataTypeBoolean();
		numeracionPreImpresa.setRequired(true);
		c.addAtt(numeracionPreImpresa);

		Att asociadoRG10098 = new Att("asociadoRG10098", "Asociado al RG 100/98");
		asociadoRG10098.setDataTypeBoolean();
		asociadoRG10098.setRequired(true);
		c.addAtt(asociadoRG10098);

		Att talonarioControladorFizcal = new Att("talonarioControladorFizcal", "Asociado a controlador fizcal");
		talonarioControladorFizcal.setDataTypeClazz(talonarioControladorFizcalAnt.build());
		talonarioControladorFizcal.setRequired(true);
		c.addAtt(talonarioControladorFizcal);

		Att primerNumero = new Att("primerNumero", "Primer nº");
		primerNumero.setDataTypeInteger(1, null);		
		c.addAtt(primerNumero);

		Att proximoNumero = new Att("proximoNumero", "Próximo nº");
		proximoNumero.setDataTypeInteger(1, null);		
		c.addAtt(proximoNumero);

		Att ultimoNumero = new Att("ultimoNumero", "Último nº");
		ultimoNumero.setDataTypeInteger(1, null);		
		c.addAtt(ultimoNumero);

		Att cantidadMinimaComprobantes = new Att("cantidadMinimaComprobantes", "Cant. min. cbtes.");
		cantidadMinimaComprobantes.setDataTypeInteger(1, null);		
		c.addAtt(cantidadMinimaComprobantes);

		Att fecha = new Att("fecha", "Fecha");
		fecha.setDataTypeDate();		
		c.addAtt(fecha);
		
		Att numeroCAI = new Att("numeroCAI", "Nº C.A.I");
		numeroCAI.setDataTypeLong(1L, 99999999999999L);				
//		numeroCAI.setColumns((float) 11);
//		numeroCAI.setLength(11, 11);
//		numeroCAI.setMask("99-99999999-9");
		c.addAtt(numeroCAI);
		
		Att vencimiento = new Att("vencimiento", "Vencimiento C.A.I");
		vencimiento.setDataTypeDate();		
		c.addAtt(vencimiento);
		
		Att diasAvisoVencimiento = new Att("diasAvisoVencimiento", "Días aviso vto.");
		diasAvisoVencimiento.setDataTypeInteger(1, null);		
		c.addAtt(diasAvisoVencimiento);

		
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
